#include "abc.h"
#include <vector>
#include <map>
#include "map/mio/mio.h"
ABC_NAMESPACE_IMPL_START

typedef std::pair<Abc_Obj_t*, bool>       FaultNodes;
typedef std::pair<Abc_Obj_t*, Abc_Obj_t*> InvFaultPair;
typedef std::pair<Abc_Obj_t*, Abc_Obj_t*> EquivFaultPair;
typedef std::map<Abc_Obj_t*, bool>        EquivFaultNodes;
int                                       debug = 1;

class FaultCollapse {

private:
    static EquivFaultNodes              EquivFaultNodes_zero, EquivFaultNodes_one;
    static std::vector<EquivFaultNodes> vEquivFaultClasses_zero;
    static std::vector<EquivFaultNodes> vEquivFaultClasses_one;
    static std::vector<InvFaultPair>    vInvFaultClasses;
    static std::vector<EquivFaultPair>  vEquivFaultClasses;

public:
    FaultCollapse() {
        EquivFaultNodes_zero.clear();
        EquivFaultNodes_one.clear();
        vEquivFaultClasses_zero.clear();
        vEquivFaultClasses_one.clear();
        vInvFaultClasses.clear();
        vEquivFaultClasses.clear();
    }
    static void  Reset() {
        EquivFaultNodes_zero.clear();
        EquivFaultNodes_one.clear();
        vEquivFaultClasses_zero.clear();
        vEquivFaultClasses_one.clear();
        vInvFaultClasses.clear();
        vEquivFaultClasses.clear();
    }
    static bool isAnd(Abc_Obj_t * pNode) ;
    static bool isBuf(Abc_Obj_t * pNode) ;
    static bool isInv(Abc_Obj_t * pNode) ;
    static bool isOr(Abc_Obj_t * pNode) ;
    static void InsertToEquivOneNodes(Abc_Obj_t * pNode);
    static void InsertToEquivZeroNodes(Abc_Obj_t * pNode);
    static void InsertToInvEquivNodes(Abc_Obj_t * pNode1, Abc_Obj_t * pNode2);
    static void InsertToEquivNodes(Abc_Obj_t * pNode1, Abc_Obj_t * pNode2);
    static void ResetEquivOneNodes() ;
    static void ResetEquivZeroNodes() ;
    static void AddFaninsToEquivZeroNode(Abc_Obj_t * pNode);
    static void AddFaninsToEquivOneNode(Abc_Obj_t * pNode);
    static int  getNextPropValue (Abc_Obj_t * pNode,  int propZeroOld) ;
    static void printEquivClasses();
};

EquivFaultNodes FaultCollapse::EquivFaultNodes_zero;
EquivFaultNodes FaultCollapse::EquivFaultNodes_one;
std::vector<EquivFaultNodes> FaultCollapse::vEquivFaultClasses_zero;
std::vector<EquivFaultNodes> FaultCollapse::vEquivFaultClasses_one;
std::vector<InvFaultPair> FaultCollapse::vInvFaultClasses;
std::vector<EquivFaultPair> FaultCollapse::vEquivFaultClasses;
void FaultCollapse::ResetEquivZeroNodes() {
    if (EquivFaultNodes_zero.size() == 0) return;
        vEquivFaultClasses_zero.push_back(EquivFaultNodes_zero);
        if (debug) printf ("Added an equiv zero class\n");
        EquivFaultNodes_zero.clear();
}
void FaultCollapse::ResetEquivOneNodes() {
    if (EquivFaultNodes_one.size() == 0) return;
    vEquivFaultClasses_one.push_back(EquivFaultNodes_one);
    if (debug) printf ("Added an equiv one class\n");
    EquivFaultNodes_one.clear();
}
void FaultCollapse::InsertToEquivZeroNodes(Abc_Obj_t * pNode)
{
    if (!pNode) return;
    if (EquivFaultNodes_zero.find(pNode) == EquivFaultNodes_zero.end()) {
        FaultNodes n(pNode,false);
        EquivFaultNodes_zero.insert(n);
        printf ("Adding %s to equiv zero node\n",Abc_ObjName(pNode));
    }
}
void FaultCollapse::InsertToEquivOneNodes(Abc_Obj_t * pNode)
{
    if (!pNode) return;
    if (EquivFaultNodes_one.find(pNode) == EquivFaultNodes_one.end()) {
        FaultNodes n(pNode,false);
        EquivFaultNodes_one.insert(n);
        printf ("Adding %s to equiv one node\n",Abc_ObjName(pNode));
    }
}
void FaultCollapse::InsertToInvEquivNodes(Abc_Obj_t * pNode1, Abc_Obj_t * pNode2)
{
    if (!pNode1 || !pNode2) return;
    InvFaultPair inv(pNode1,pNode2);
    vInvFaultClasses.push_back(inv);
    if (debug) printf ("Added an inv equiv class\n");
}
void FaultCollapse::InsertToEquivNodes(Abc_Obj_t * pNode1, Abc_Obj_t * pNode2)
{
    if (!pNode1 || !pNode2) return;
    EquivFaultPair eqv(pNode1,pNode2);
    vEquivFaultClasses.push_back(eqv);
    if (debug) printf ("Added an equiv class\n");
}

bool FaultCollapse::isAnd(Abc_Obj_t * pNode) {
    //return Abc_NodeIsAnd2( pNode );

    if ( Abc_ObjFaninNum(pNode) < 2)
        return 0;
    Abc_Ntk_t * pNtk = pNode->pNtk;

    if ( Abc_NtkHasSop(pNtk) )
        return Abc_SopIsAndType(((char *)pNode->pData));
    if ( Abc_NtkIsMappedLogic(pNode->pNtk)) {
        char* pSop = Mio_GateReadSop((Mio_Gate_t *)pNode->pData);
        if (Abc_SopIsAndType(pSop))
            return 1;
        else if (strncmp(Mio_GateReadName((Mio_Gate_t *)pNode->pData),"AND",3) == 0)
            return 1;
    }
    return 0;
}
bool FaultCollapse::isOr(Abc_Obj_t * pNode) {
    //return Abc_NodeIsOr2( pNode );
    if ( Abc_ObjFaninNum(pNode) < 2)
        return 0;
    Abc_Ntk_t * pNtk = pNode->pNtk;

    if ( Abc_NtkHasSop(pNtk) )
        return ( Abc_SopIsOrType(((char *)pNode->pData))   ||
                !strcmp(((char *)pNode->pData), "01 0\n") ||
                !strcmp(((char *)pNode->pData), "10 0\n") ||
                !strcmp(((char *)pNode->pData), "00 0\n") );
    //off-sets, too
    if ( Abc_NtkIsMappedLogic(pNode->pNtk)) {
        char* pSop = Mio_GateReadSop((Mio_Gate_t *)pNode->pData);
        if ( Abc_SopIsOrType(pSop) ||
                strcmp(pSop,"01 0\n")   ||
                strcmp(pSop,"10 0\n")   ||
                strcmp(pSop,"00 0\n") )
                return 1;
        else if (strncmp(Mio_GateReadName((Mio_Gate_t *)pNode->pData),"OR",2) == 0)
            return 1;
    }
    return 0;
}
bool FaultCollapse::isInv(Abc_Obj_t * pNode) {
    return Abc_NodeIsInv(pNode);
}
bool FaultCollapse::isBuf(Abc_Obj_t * pNode) {
    return Abc_NodeIsBuf(pNode);
}

void FaultCollapse::AddFaninsToEquivZeroNode(Abc_Obj_t * pNode) {
    Abc_Obj_t * pFanin = NULL;
    int  i = 0;
    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        InsertToEquivZeroNodes(pFanin);
    }
}
void FaultCollapse::AddFaninsToEquivOneNode(Abc_Obj_t * pNode) {
    Abc_Obj_t * pFanin = NULL;
    int i = 0;
    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        InsertToEquivOneNodes(pFanin);
    }
}

/**Function*************************************************************

   Synopsis    [Utility to print Equivalent Fault Classes ]

   Description []

   SideEffects []

   SeeAlso     []

**********************************************************************/
void FaultCollapse::printEquivClasses() {
    const char* filename = "equiv_fault_nodes.info";
    FILE* fp = fopen(filename, "w");
    if (!fp) {
        printf ("Unable to open file %s.\n",filename);
    }
    int equiv_class_count = 1;
    for ( int i = 0; i < vEquivFaultClasses_zero.size(); i++ ) {
        EquivFaultNodes mMapEquiv = vEquivFaultClasses_zero[i];
        if (mMapEquiv.empty()) continue;
        fprintf (fp ,"Equiv Zero Class %d:\n",equiv_class_count++);
        EquivFaultNodes::iterator iter, end;
        iter = mMapEquiv.begin();
        end = mMapEquiv.end();
        for (; iter != end; ++iter)
        {
            fprintf (fp,"%s%s ", (iter->second?"!":""),Abc_ObjName(iter->first));
        }
        fprintf(fp, "\n");
    }
    equiv_class_count = 1;
    for ( int i = 0; i < vEquivFaultClasses_one.size(); i++ ) {
        EquivFaultNodes mMapEquiv = vEquivFaultClasses_one[i];
        if (mMapEquiv.empty()) continue;
        fprintf (fp, "Equiv One Class %d:\n",equiv_class_count++);
        EquivFaultNodes::iterator iter, end;
        iter = mMapEquiv.begin();
        end = mMapEquiv.end();
        for (; iter != end; ++iter)
        {
            fprintf (fp, "%s%s ", (iter->second?"!":""),Abc_ObjName(iter->first));
        }
        fprintf(fp,"\n");
    }
    for ( int i = 0; i < vInvFaultClasses.size(); i++ ) {
        fprintf (fp, "Inv equiv Class %d:\n",i+1);
        InvFaultPair p = vInvFaultClasses[i];
        fprintf (fp, "%s => %s\n",Abc_ObjName(p.first),Abc_ObjName(p.second));
    }
    for ( int i = 0; i < vEquivFaultClasses.size(); i++ ) {
        fprintf (fp, "Equiv Class %d:\n",i+1);
        EquivFaultPair p = vEquivFaultClasses[i];
        fprintf (fp, "%s => %s\n",Abc_ObjName(p.first),Abc_ObjName(p.second));
    }
}

/**Function*************************************************************

   Synopsis    [Checks and gets the next value to propagate across a node. ]

   Description [This is based on whether the node in question is an AND, OR or
   inverter. This function also captures the Fault equivalence
   across the nodes.]

   SideEffects []

   SeeAlso     []

**********************************************************************/
int FaultCollapse::getNextPropValue (Abc_Obj_t * pNode, int propZeroOld) {
    int propZero = -1;
    Abc_Obj_t * pInNet0 = Abc_ObjFanin0(pNode);
    Abc_Obj_t * pOutNet = NULL;
    const char* GateName = Mio_GateReadName((Mio_Gate_t *)pNode->pData);
    //if (Abc_ObjFanoutNum(pNode) == 1)
        pOutNet = pNode;
    if (propZeroOld) {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Continue propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            AddFaninsToEquivZeroNode(pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode)) {
            propZero = 0;
            if (debug) printf ("Break propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivOneNodes();
            AddFaninsToEquivOneNode(pNode);
            InsertToEquivOneNodes(pOutNet);
        }
    } else {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Break propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivZeroNodes();
            AddFaninsToEquivZeroNode(pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else  if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode))  {
            propZero = 0;
            if (debug) printf ("Continue propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            AddFaninsToEquivOneNode(pNode);
            InsertToEquivOneNodes(pOutNet);
        }
    }
    if (propZero == -1) {
        if (isBuf(pNode)) {
            propZero = propZeroOld;
            InsertToEquivNodes(pInNet0,pOutNet);
        }
        /*else
            assert(propZero != -1); */
    }
    return propZero;
}
void printObjType(Abc_Obj_t * pNode) {
    if (debug) printf ("Obj: %s Type: %d\n", Abc_ObjName(pNode), pNode->Type);
}
/**Function*************************************************************

   Synopsis    [Performs DFS for one node.]

   Description []

   SideEffects []

   SeeAlso     []

**********************************************************************/
void Abc_NtkDfsReverse_prop_rec( Abc_Obj_t * pNode, int propZero )
{
    Abc_Obj_t * pFanout ;
    int i;
    int propZeroNext = 0;

    assert( !Abc_ObjIsNet(pNode) );

    // if this node is already visited, skip
    if ( Abc_NodeIsTravIdCurrent( pNode ) )
        return;

    // mark the node as visited
    Abc_NodeSetTravIdCurrent( pNode );

    // skip the CO
    if ( Abc_ObjIsCo(pNode) )
        return;

    assert( Abc_ObjIsNode( pNode ) );
    propZeroNext = FaultCollapse::getNextPropValue(pNode,propZero);
    Abc_ObjForEachFanout( pNode, pFanout, i ) {
        if ( Abc_NodeIsTravIdCurrent( pFanout ) ) return;

        if (debug) printf ("Node: %s Fanout %d: %s\n",Abc_ObjName(pNode),i,Abc_ObjName(pFanout));
        //int propZeroNext_i = FaultCollapse::CheckForComplementedNode(pNode, pFanout, propZeroNext);
        Abc_NtkDfsReverse_prop_rec( pFanout, propZeroNext );
    }
}

/**Function*************************************************************

   Synopsis    [Performs DFS for one node and propagates zero or one value.]

   Description []

   SideEffects []

   SeeAlso     []

***********************************************************************/
void Abc_NtkDfsReverse_prop( Abc_Ntk_t * pNtk )
{
    Abc_Obj_t * pObj;
    int i,j;
    int propZero = 1;
    // set the traversal ID
    Abc_NtkIncrementTravId( pNtk );

    Abc_NtkForEachCi( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PI %s\n",Abc_ObjName(pObj));
        propZero = 1;
        Abc_NodeSetTravIdCurrent( pObj );
        Abc_Obj_t * pFanout ;
        Abc_ObjForEachFanout( pObj, pFanout, j ) {
            if ( Abc_NodeIsTravIdCurrent( pFanout ) )
                continue;
            Abc_NtkDfsReverse_prop_rec( pFanout, propZero );
            FaultCollapse::ResetEquivZeroNodes();
            FaultCollapse::ResetEquivOneNodes();
        }
        if (debug) printf ("<--- End working on PI %s\n\n",Abc_ObjName(pObj));
    }
    FaultCollapse::printEquivClasses();
    FaultCollapse::Reset();
}


////////////////////////////////////////////////////////////////////////
///                       END OF FILE                                ///
////////////////////////////////////////////////////////////////////////

ABC_NAMESPACE_IMPL_END
