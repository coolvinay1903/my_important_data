#include "abc.h"
#include <vector>
#include <map>
#include <set>
#include <list>
#include <bitset>
#include <algorithm>
#include <string>
using std::string;
#include "map/mio/mio.h"
ABC_NAMESPACE_IMPL_START

struct            FaultInfo;
static const long NumCos = 100;
static bool       debug  = 0;

typedef std::set<Abc_Obj_t*>              ListOfNodes;
typedef std::pair<Abc_Obj_t*, bool>       FaultNodes;
typedef std::pair<Abc_Obj_t*, Abc_Obj_t*> InvFaultPair;
typedef std::pair<Abc_Obj_t*, Abc_Obj_t*> EquivFaultPair;
typedef std::map<Abc_Obj_t*, bool>        EquivFaultNodes;
typedef std::map<Abc_Obj_t*, FaultInfo>   NodeFaultInfo;
typedef std::list<std::pair<int, std::bitset<NumCos> > > ListOfDependentCis_t;

class FaultInfo {
public:
    ListOfNodes SA0;
    ListOfNodes SA1;
    FaultInfo() {
        SA0.clear();
        SA1.clear();
    }
    void AddNodeToSA0List(Abc_Obj_t* pObj) {
        SA0.insert(pObj);
    }
    void AddNodeToSA1List(Abc_Obj_t* pObj) {
        SA1.insert(pObj);
    }
    void AddToSA0Info(ListOfNodes* f) {
        ListOfNodes::iterator iter = f->begin();
        for (; iter != f->end(); ++iter) {
            SA0.insert(*iter);
        }
    }
    void AddToSA1Info(ListOfNodes* f) {
        ListOfNodes::iterator iter = f->begin();
        for (; iter != f->end(); ++iter) {
            SA1.insert(*iter);
        }
    }
    void dumpSA0Info(FILE* fp) {
        if (SA0.size() == 0)
            return;
        if (debug) printf ("List of dominated SA0 nodes: ");
        if (fp)fprintf (fp, "List of dominated SA0 nodes: ");
        dumpInfo(SA0,fp);
    }
    void dumpSA1Info(FILE* fp) {
        if (SA1.size() == 0)
            return;
        if (debug) printf ("List of dominated SA1 nodes: ");
        if (fp) fprintf (fp, "List of dominated SA1 nodes: ");
        dumpInfo(SA1,fp);
    }
    void dumpStuckAtInfo(FILE* fp = NULL) {
        dumpSA0Info(fp);
        dumpSA1Info(fp);
    }
    void dumpInfo(ListOfNodes& S, FILE* fp = NULL) {
        ListOfNodes::iterator iter = S.begin();
        for (; iter != S.end(); ++iter) {
            if (fp) fprintf (fp, " %s",Abc_ObjName(*iter));
            if (debug) printf (" %s",Abc_ObjName(*iter));
        }
        if (debug) printf("\n");
        if (fp) fprintf(fp, "\n");
    }
};

class FaultCollapse {

private:

    static EquivFaultNodes              EquivFaultNodes_zero, EquivFaultNodes_one;
    static std::vector<EquivFaultNodes> vEquivFaultClasses_zero;
    static std::vector<EquivFaultNodes> vEquivFaultClasses_one;
    static std::vector<InvFaultPair>    vInvFaultClasses;
    static std::vector<EquivFaultPair>  vEquivFaultClasses;
    static NodeFaultInfo                mNodeFaultInfo_PI;
    static NodeFaultInfo                mNodeFaultInfo_PO;

public:
    FaultCollapse() {
        EquivFaultNodes_zero.clear();
        EquivFaultNodes_one.clear();
        vEquivFaultClasses_zero.clear();
        vEquivFaultClasses_one.clear();
        vInvFaultClasses.clear();
        vEquivFaultClasses.clear();
        mNodeFaultInfo_PI.clear();
        mNodeFaultInfo_PO.clear();
    }
    static void  Reset() {
        EquivFaultNodes_zero.clear();
        EquivFaultNodes_one.clear();
        vEquivFaultClasses_zero.clear();
        vEquivFaultClasses_one.clear();
        vInvFaultClasses.clear();
        vEquivFaultClasses.clear();
        mNodeFaultInfo_PI.clear();
        mNodeFaultInfo_PO.clear();
    }
    enum GateType {
        AND_TYPE = 0,
        OR_TYPE,
        INV_TYPE,
        BUF_TYPE,
        CO_TYPE,
        CI_TYPE,
        UNKNOWN_TYPE
    };
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
    static bool AddFaninsToEquivZeroNode( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode);
    static bool AddFaninsToEquivOneNode( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode);
    static int  getNextPropValue ( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode,  int propZeroOld, bool& shouldMarkVisited) ;
    static int  getNextPropValue_reverse ( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode,  int propZeroOld, bool& shouldMarkVisited) ;
    static FaultInfo* getFaultInfo_PI (Abc_Obj_t* pNode);
    static FaultInfo* getFaultInfo_PO (Abc_Obj_t* pNode);
    static void printEquivClasses(Abc_Ntk_t* pNtk);
    static FaultCollapse::GateType getGateType(Abc_Obj_t* pNode);
    static FaultInfo* genFaultInfoPI(Abc_Obj_t* pNode);
    static FaultInfo* genFaultInfoPO(Abc_Obj_t* pNode);
    static FaultInfo* getFaultInfoCi(Abc_Obj_t* pNode);
    static FaultInfo* getFaultInfoCo(Abc_Obj_t* pNode);
    static void MergeRedundantPIFaultInfo(Abc_Ntk_t* pNtk);
    static void MergeRedundantPIFaultInfo(Abc_Ntk_t* pNtk, std::map<Abc_Obj_t*, int> &mCoNum, FILE* fp, bool processSA1 = false);

};

EquivFaultNodes              FaultCollapse::EquivFaultNodes_zero;
EquivFaultNodes              FaultCollapse::EquivFaultNodes_one;
std::vector<EquivFaultNodes> FaultCollapse::vEquivFaultClasses_zero;
std::vector<EquivFaultNodes> FaultCollapse::vEquivFaultClasses_one;
std::vector<InvFaultPair>    FaultCollapse::vInvFaultClasses;
std::vector<EquivFaultPair>  FaultCollapse::vEquivFaultClasses;
NodeFaultInfo                FaultCollapse::mNodeFaultInfo_PI;
NodeFaultInfo                FaultCollapse::mNodeFaultInfo_PO;

FaultCollapse::GateType FaultCollapse::getGateType(Abc_Obj_t* pNode) {
    if (Abc_ObjIsCo(pNode))
        return CO_TYPE;
    else if (Abc_ObjIsCi(pNode))
        return CI_TYPE;
    else if (isAnd(pNode))
        return AND_TYPE;
    else if (isOr(pNode))
        return OR_TYPE;
    else if (isInv(pNode))
        return INV_TYPE;
    else if (isBuf(pNode))
        return BUF_TYPE;

    return UNKNOWN_TYPE;
}
FaultInfo* FaultCollapse::getFaultInfoCi(Abc_Obj_t* pNode) {

    assert(Abc_ObjIsCi(pNode));
    // Add the PI to the SA1 and SA0 and return the information.
    FaultInfo FI;
    FI.AddNodeToSA1List(pNode);
    FI.AddNodeToSA0List(pNode);
    mNodeFaultInfo_PI[pNode] = FI;
    return &mNodeFaultInfo_PI[pNode];
}
FaultInfo* FaultCollapse::getFaultInfoCo(Abc_Obj_t* pNode) {

    assert(Abc_ObjIsCo(pNode));
    // Add the PO to the SA1 and SA0 and return the information.
    FaultInfo FI;
    FI.AddNodeToSA1List(pNode);
    FI.AddNodeToSA0List(pNode);
    mNodeFaultInfo_PO[pNode] = FI;
    return &mNodeFaultInfo_PO[pNode];
}
FaultInfo* FaultCollapse::genFaultInfoPI(Abc_Obj_t* pNode) {

    //Find FaultInfo of the FaninNodes and build the FaultInfo of this
    //node from it.
    Abc_Obj_t* pFanin;
    int i = 0;
    FaultInfo F;
    GateType G = getGateType(pNode);
    bool canPropOne = 0, canPropZero = 0, invProp = 0;
    switch (G) {
        case AND_TYPE:
            canPropZero = 1;
            canPropOne = 0;
            break;
        case OR_TYPE:
            canPropZero = 0;
            canPropOne = 1;
            break;
        case INV_TYPE:
            invProp = 1;
        case BUF_TYPE:
        case CO_TYPE:
            canPropZero = 1;
            canPropOne = 1;
            break;
        case CI_TYPE:
            return getFaultInfoCi(pNode);
            break;
        case UNKNOWN_TYPE:
            canPropOne = 0;
            canPropZero = 0;
            break;
    }
    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        FaultInfo *f = getFaultInfo_PI(pFanin);
        if (!invProp) {
            if (canPropOne)
                F.AddToSA1Info(&f->SA1);
            if (canPropZero)
                F.AddToSA0Info(&f->SA0);
        } else {
            if (canPropOne)
                F.AddToSA0Info(&f->SA1);
            if (canPropZero)
                F.AddToSA1Info(&f->SA0);
        }
    }
    mNodeFaultInfo_PI[pNode] = F;
    return &mNodeFaultInfo_PI[pNode];
}
FaultInfo* FaultCollapse::genFaultInfoPO(Abc_Obj_t* pNode) {

    //Find FaultInfo of the FanoutNodes and build the FaultInfo of this
    //node from it.
    Abc_Obj_t* pFanout;
    int i = 0;
    FaultInfo F;
    Abc_ObjForEachFanout( pNode, pFanout, i ) {
        FaultInfo *f = getFaultInfo_PO(pFanout);
        GateType G = getGateType(pFanout);
        bool canPropOne = 0, canPropZero = 0, invProp = 0;
        switch (G) {
            case AND_TYPE:
                canPropZero = 1;
                canPropOne = 0;
                break;
            case OR_TYPE:
                canPropZero = 0;
                canPropOne = 1;
                break;
            case INV_TYPE:
                invProp = 1;
            case BUF_TYPE:
            case CI_TYPE:
                canPropZero = 1;
                canPropOne = 1;
                break;
            case CO_TYPE:
                return getFaultInfoCo(pFanout);
                break;
            case UNKNOWN_TYPE:
                canPropOne = 0;
                canPropZero = 0;
                break;
        }
        if (!invProp) {
            if (canPropOne)
                F.AddToSA1Info(&f->SA1);
            if (canPropZero)
                F.AddToSA0Info(&f->SA0);
        } else {
            if (canPropOne)
                F.AddToSA0Info(&f->SA1);
            if (canPropZero)
                F.AddToSA1Info(&f->SA0);
        }
    }
    mNodeFaultInfo_PO[pNode] = F;
    return &mNodeFaultInfo_PO[pNode];
}

FaultInfo* FaultCollapse::getFaultInfo_PI(Abc_Obj_t* pNode) {
    // if already populated just return the info.
    if (mNodeFaultInfo_PI.find(pNode) != mNodeFaultInfo_PI.end() )
        return &mNodeFaultInfo_PI[pNode];

    return genFaultInfoPI(pNode);
}

FaultInfo* FaultCollapse::getFaultInfo_PO(Abc_Obj_t* pNode)
{
    if (mNodeFaultInfo_PO.find(pNode) != mNodeFaultInfo_PO.end() )
        return &mNodeFaultInfo_PO[pNode];

    return genFaultInfoPO(pNode);
}

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

bool FaultCollapse::AddFaninsToEquivZeroNode( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode) {
    Abc_Obj_t * pFanin = NULL;
    int  i = 0;
    bool someFaninSkipped = 0;
    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        // This ensures fault dominance. If the side-fanin node has multiple fanouts, then dominance cannot be established.
        // However, if the faninNode is same as the previousNode, as it is part of the dominance tree.
        if ( Abc_ObjFanoutNum(pFanin) == 1 || pFanin == pPrevNode )
            InsertToEquivZeroNodes(pFanin);
        else
            someFaninSkipped = 1;
    }
    return !someFaninSkipped;
}
bool FaultCollapse::AddFaninsToEquivOneNode( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode) {
    Abc_Obj_t * pFanin = NULL;
    int i = 0;
    bool someFaninSkipped = 0;
    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        // This ensures fault dominance. If the side-fanin node has multiple fanouts, then dominance cannot be established.
        // However, if the faninNode is same as the previousNode, as it is part of the dominance tree.
        if ( Abc_ObjFanoutNum(pFanin) == 1 || pFanin == pPrevNode )
            InsertToEquivOneNodes(pFanin);
         else
            someFaninSkipped = 1;
    }
    return !someFaninSkipped;
}

/**Function*************************************************************

   Synopsis    [Utility to print Equivalent Fault Classes ]

   Description []

   SideEffects []

   SeeAlso     []

**********************************************************************/
void FaultCollapse::printEquivClasses(Abc_Ntk_t* pNtk) {
    string fname = Abc_NtkName(pNtk);
    fname += ".";
    fname += "equiv_fault_nodes.info";
    const char* filename = fname.c_str();
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
    fclose(fp);
}

/**Function*************************************************************

   Synopsis    [Checks and gets the next value to propagate across a node. ]

   Description [This is based on whether the node in question is an AND, OR or
   inverter. This function also captures the Fault equivalence
   across the nodes.]

   SideEffects []

   SeeAlso     []

**********************************************************************/
int FaultCollapse::getNextPropValue_reverse ( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode, int propZeroOld, bool& shouldMarkVisited) {
    int propZero = -1;
    Abc_Obj_t * pInNet0 = Abc_ObjFanin0(pNode);
    Abc_Obj_t * pOutNet = NULL;

    pOutNet = pNode;
    if (Abc_ObjIsCi(pNode)) {
        InsertToEquivNodes(pInNet0,pOutNet);
        return -1;
    }
    const char* GateName = Mio_GateReadName((Mio_Gate_t *)pNode->pData);

    if (propZeroOld) {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Continue propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            shouldMarkVisited = AddFaninsToEquivZeroNode(pPrevNode, pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode)) {
            propZero = 0;
            if (debug) printf ("Break propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivOneNodes();
            shouldMarkVisited = AddFaninsToEquivOneNode(pPrevNode, pNode);
            InsertToEquivOneNodes(pOutNet);
        }
    } else {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Break propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivZeroNodes();
            shouldMarkVisited = AddFaninsToEquivZeroNode(pPrevNode, pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else  if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode))  {
            propZero = 0;
            if (debug) printf ("Continue propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            shouldMarkVisited = AddFaninsToEquivOneNode(pPrevNode, pNode);
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
void Abc_NtkDfsFwdProp_rec( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode, int propZero )
{
    Abc_Obj_t * pFanout ;
    int i;
    int propZeroNext = 0;

    assert( !Abc_ObjIsNet(pNode) );

    // if this node is already visited, skip
    if ( Abc_NodeIsTravIdCurrent( pNode ) )
        return;

    if ( Abc_ObjIsCo(pNode) ) {
        printf ("Working on CO: %s at LEVEL %d\n", Abc_ObjName(pNode), Abc_ObjLevel(pNode));
    }
    // Only visit gates whose level is one larger than previous gate level
    if ( !Abc_ObjIsCo(pNode) && pNode->Level != pPrevNode->Level+1)
        return;

    bool shouldMarkVisited = true;
    propZeroNext = FaultCollapse::getNextPropValue(pPrevNode, pNode, propZero, shouldMarkVisited);

    // skip the CO
    if ( Abc_ObjIsCo(pNode) )
        return;

    if (shouldMarkVisited)
        // mark the node as visited
        Abc_NodeSetTravIdCurrent( pNode );

    assert( Abc_ObjIsNode( pNode ) );

    Abc_ObjForEachFanout( pNode, pFanout, i ) {
        if ( Abc_NodeIsTravIdCurrent( pFanout ) ) return;

        if (debug) printf ("Node: %s Fanout %d: Level:%d %s\n",Abc_ObjName(pNode),i, Abc_ObjLevel(pFanout),Abc_ObjName(pFanout));
        //int propZeroNext_i = FaultCollapse::CheckForComplementedNode(pNode, pFanout, propZeroNext);
        Abc_NtkDfsFwdProp_rec( pNode, pFanout, propZeroNext );
    }
}

/**Function*************************************************************

   Synopsis    [Performs DFS for one node and propagates zero or one value.]

   Description []

   SideEffects []

   SeeAlso     []

***********************************************************************/
void Abc_NtkDfsFwdProp( Abc_Ntk_t * pNtk )
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
            Abc_NtkDfsFwdProp_rec(pObj, pFanout, propZero );
            FaultCollapse::ResetEquivZeroNodes();
            FaultCollapse::ResetEquivOneNodes();
        }
        if (debug) printf ("<--- End working on PI %s\n\n",Abc_ObjName(pObj));
    }
    FaultCollapse::printEquivClasses(pNtk);
    FaultCollapse::Reset();
}
/**Function*************************************************************

   Synopsis    [Checks and gets the next value to propagate across a node. ]

   Description [This is based on whether the node in question is an AND, OR or
   inverter. This function also captures the Fault equivalence
   across the nodes.]

   SideEffects []

   SeeAlso     []

**********************************************************************/
int FaultCollapse::getNextPropValue ( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode, int propZeroOld, bool& shouldMarkVisited) {
    int propZero = -1;
    Abc_Obj_t * pInNet0 = Abc_ObjFanin0(pNode);
    Abc_Obj_t * pOutNet = NULL;

    pOutNet = pNode;
    if (Abc_ObjIsCo(pNode)) {
        InsertToEquivNodes(pInNet0,pOutNet);
        return -1;
    }
    const char* GateName = Mio_GateReadName((Mio_Gate_t *)pNode->pData);

    if (propZeroOld) {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Continue propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            shouldMarkVisited = AddFaninsToEquivZeroNode(pPrevNode, pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode)) {
            propZero = 0;
            if (debug) printf ("Break propagation of zeros as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivOneNodes();
            shouldMarkVisited = AddFaninsToEquivOneNode(pPrevNode, pNode);
            InsertToEquivOneNodes(pOutNet);
        }
    } else {
        if (isAnd(pNode)) {
            propZero = 1;
            if (debug) printf ("Break propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            ResetEquivZeroNodes();
            shouldMarkVisited = AddFaninsToEquivZeroNode(pPrevNode, pNode);
            InsertToEquivZeroNodes(pOutNet);
        } else  if (isInv(pNode)) {
            propZero = !propZeroOld;
            if (debug) printf ("Propagating %d as encountered %s %s\n",propZero, GateName, Abc_ObjName(pNode));
            InsertToInvEquivNodes(pInNet0,pOutNet);
        } else if (isOr(pNode))  {
            propZero = 0;
            if (debug) printf ("Continue propagation of one as encountered %s %s\n", GateName, Abc_ObjName(pNode));
            shouldMarkVisited = AddFaninsToEquivOneNode(pPrevNode, pNode);
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
bool isGt (const std::pair<int, std::bitset<NumCos> >& a, const std::pair<int, std::bitset<NumCos> >& b) {
    if ( a.second.count() > b.second.count())
        return true;

    return false;
}
void FaultCollapse::MergeRedundantPIFaultInfo(Abc_Ntk_t* pNtk, std::map<Abc_Obj_t*, int> &mCoNum, FILE* fp, bool processSA1) {

    int i = 0;
    Abc_Obj_t* pCi = NULL;
    ListOfDependentCis_t ListOfDependentCis;
    std::bitset<NumCos> temp;
    ListOfDependentCis.clear();

    //1. Generate CO dominance bit string for each PI
    Abc_NtkForEachCi( pNtk, pCi, i )
    {
        temp.reset();
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pCi);
        ListOfNodes::iterator iter, end;
        if (processSA1) {
            if (f->SA1.size() == 0) continue;
            iter = f->SA1.begin();
            end = f->SA1.end();
        } else {
            if (f->SA0.size() == 0) continue;
            iter = f->SA0.begin();
            end = f->SA0.end();
        }
        for (; iter != end; ++iter) {
            temp.set(mCoNum[*iter]);
        }
        std::pair<int,std::bitset<NumCos> > p(i,temp);
        ListOfDependentCis.push_back(p);
        if (debug) {
            printf ("PI %s\n",Abc_ObjName(pCi));
            f->dumpSA1Info(NULL);
            //std::string bit_string = temp.to_string<char,std::string::traits_type,std::string::allocator_type>();
            std::string bit_string = temp.to_string();
            printf ("bit_string %s\n",bit_string.c_str());
        }
    }

    //2. Sort the Listofdependentcis based on number of bits set in the bit_string
    ListOfDependentCis.sort(isGt);

    //3. Do bitwise and of the bit strings of pair of PIs, and merge the redundant ones
    ListOfDependentCis_t::iterator iter1, iter2, curr, end;
    end = ListOfDependentCis.end();
    int total_merges = 0;
    for ( iter1 = ListOfDependentCis.begin(); iter1 != end; ++iter1) {
        for ( iter2 = iter1, ++iter2; iter2 != end; ) {
            curr = iter2; ++iter2;
            if (debug) printf("Comparing %s and %s\n",Abc_ObjName(Abc_NtkCi(pNtk,iter1->first)), Abc_ObjName(Abc_NtkCi(pNtk,curr->first)));
            if ( iter1->second.count() >= curr->second.count()) {
                std::bitset<NumCos> a ;
                a.reset();
                a |= iter1->second;
                a &= curr->second;
                if (debug) {
                    std::string first_string = iter1->second.to_string();
                    std::string second_string = curr->second.to_string();
                    std::string final_string = a.to_string();
                    printf ("%s\n",Abc_ObjName(Abc_NtkCi(pNtk,iter1->first)));
                    printf ("bit_string =  %s\n",first_string.c_str());
                    printf ("%s\n",Abc_ObjName(Abc_NtkCi(pNtk,curr->first)));
                    printf ("bit_string =  %s\n",second_string.c_str());
                    printf ("%s\n","Resultant bitwise and");
                    printf ("bit_string =  %s\n",final_string.c_str());
                }
                if (a.count() == curr->second.count()) {
                    if (debug) printf ("Merging PIs %s and %s for %s faults\n",Abc_ObjName(Abc_NtkCi(pNtk,iter1->first)), Abc_ObjName(Abc_NtkCi(pNtk,curr->first)), (processSA1 ? "SA1" : "SA0"));
                    ListOfDependentCis.erase(curr);
                    total_merges++;
                }
            }
        }
    }

    //4. Print the resultant PIs and their dominance info.
    i = 0; pCi = NULL;
    fprintf (fp, "****************************************\n");
    fprintf (fp, "********** Stuck at %s faults ********\n", (processSA1 ? " One" : "Zero"));
    fprintf (fp, "****************************************\n");
    for (ListOfDependentCis_t::iterator iter = ListOfDependentCis.begin(); iter != ListOfDependentCis.end(); ++iter ) {
        Abc_Obj_t* pCi = Abc_NtkCi(pNtk,iter->first);
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pCi);
        fprintf (fp ,"PI %s\n",Abc_ObjName(pCi));
        if (debug) printf ("PI %s\n",Abc_ObjName(pCi));
        if (processSA1)
            f->dumpSA1Info(fp);
        else
            f->dumpSA0Info(fp);
    }
    fprintf (fp, "Total Merges = %d\n", total_merges);
}
void FaultCollapse::MergeRedundantPIFaultInfo(Abc_Ntk_t* pNtk) {

    int i = 0;
    Abc_Obj_t *pObj = NULL;
    std::map<Abc_Obj_t*, int> mCoNum;
    Abc_NtkForEachCo ( pNtk, pObj, i) {
        mCoNum[pObj] = i;
    }
    string filename = Abc_NtkName(pNtk);
    filename += ".";
    filename += "merged_dominant_fault_nodes_PI.info";
    const char* filename2 = filename.c_str();
    FILE* fp = fopen(filename2, "w");
    if (!fp) {
        printf ("Unable to open file %s.\n",filename2);
        return;
    }
    MergeRedundantPIFaultInfo(pNtk, mCoNum, fp, false /* processSA1 */); // SA0
    MergeRedundantPIFaultInfo(pNtk, mCoNum, fp, true  /* processSA1 */); // SA1
    fclose(fp);
/*
    // Process SA0 list
    i = 0;
    Abc_NtkForEachCi( pNtk, pCi, i )
    {
        temp.reset();
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pCi);
        ListOfNodes::iterator iter = f->SA0.begin();
        for (; iter != f->SA0.end(); ++iter) {
            temp.set(mCoNum[*iter]);
        }
        ListOfDependentCis[i] = temp;
        if (debug) {
            printf ("PI %s\n",Abc_ObjName(pCi));
            f->dumpSA0Info(NULL);
            std::string bit_string = temp.to_string<char,std::string::traits_type,std::string::allocator_type>();
            printf ("bit_string %s\n",bit_string.c_str());
        }
    }

    std::map<int, std::bitset<NumCos> >::iterator iter1, iter2, curr, end;
    end = ListOfDependentCis.end();
    for ( iter1 = ListOfDependentCis.begin(); iter1 != end; ++iter1 ) {
        for ( iter2 = iter1, ++iter2; iter2 != end; ) {
            curr = iter2; ++iter2;
            if ( iter1->second.count() >= curr->second.count()) {
                std::bitset<NumCos> a ;
                a.reset();
                a |= iter1->second;
                a &= curr->second;
                if (a.count() == curr->second.count()) {
                    if (debug) {
                        std::string first_string = iter1->second.to_string<char,std::string::traits_type,std::string::allocator_type>();
                        std::string second_string = curr->second.to_string<char,std::string::traits_type,std::string::allocator_type>();
                        std::string final_string = a.to_string<char,std::string::traits_type,std::string::allocator_type>();
                        printf ("S1 =  %s\n",first_string.c_str());
                        printf ("S2 =  %s\n",second_string.c_str());
                        printf ("S3 =  %s\n",final_string.c_str());
                    }
                    printf ("Merging PIs %s and %s for SA0 faults\n",Abc_ObjName(Abc_NtkCi(pNtk,iter1->first)), Abc_ObjName(Abc_NtkCi(pNtk,curr->first)));
                    ListOfDependentCis.erase(curr);
                }
            }
        }
    }

*/
    /*
    i = 0; pCi = NULL; pObj = NULL;
    fprintf (fp, "****************************************\n");
    fprintf (fp, "********** Stuck at Zero faults ********\n");
    fprintf (fp, "****************************************\n");
    Abc_NtkForEachCi( pNtk, pObj, i )
    {
        if ( ListOfDependentCis.find(i) != ListOfDependentCis.end()) {
            FaultInfo *f = FaultCollapse::getFaultInfo_PO(pObj);
            fprintf (fp ,"PI %s\n",Abc_ObjName(pObj));
            printf ("PI %s\n",Abc_ObjName(pObj));
            f->dumpSA0Info(fp);
        }
    }
    */
}
/**Function*************************************************************

   Synopsis    [Performs DFS for one node.]

   Description []

   SideEffects []

   SeeAlso     []

**********************************************************************/
void Abc_NtkDfsReverseProp_rec( Abc_Obj_t * pPrevNode, Abc_Obj_t * pNode, int propZero )
{
    Abc_Obj_t * pFanin ;
    int i;
    int propZeroNext = 0;

    assert( !Abc_ObjIsNet(pNode) );

    // if this node is already visited, skip
    if ( Abc_NodeIsTravIdCurrent( pNode ) )
        return;

    if ( Abc_ObjIsCi(pNode) ) {
        printf ("Working on CI: %s at LEVEL %d\n", Abc_ObjName(pNode), Abc_ObjLevel(pNode));
    }
    // Only visit gates whose level is one larger than previous gate level
    if ( !Abc_ObjIsCi(pNode) && pNode->Level != pPrevNode->Level-1)
        return;

    bool shouldMarkVisited = true;
    propZeroNext = FaultCollapse::getNextPropValue(pPrevNode, pNode, propZero, shouldMarkVisited);

    // skip the Ci
    if ( Abc_ObjIsCi(pNode) )
        return;

    if (shouldMarkVisited)
        // mark the node as visited
        Abc_NodeSetTravIdCurrent( pNode );

    assert( Abc_ObjIsNode( pNode ) );

    Abc_ObjForEachFanin( pNode, pFanin, i ) {
        if ( Abc_NodeIsTravIdCurrent( pFanin ) ) return;

        if (debug) printf ("Node: %s Fanin %d: Level:%d %s\n",Abc_ObjName(pNode),i, Abc_ObjLevel(pFanin),Abc_ObjName(pFanin));
        //int propZeroNext_i = FaultCollapse::CheckForComplementedNode(pNode, pFanin, propZeroNext);
        Abc_NtkDfsFwdProp_rec( pNode, pFanin, propZeroNext );
    }
}

/**Function*************************************************************

   Synopsis    [Performs DFS for one node and propagates zero or one value.]

   Description []

   SideEffects []

   SeeAlso     []

***********************************************************************/
void Abc_NtkDfsReverseProp( Abc_Ntk_t * pNtk )
{
    Abc_Obj_t * pObj;
    int i,j;
    int propZero = 1;
    // set the traversal ID
    Abc_NtkIncrementTravId( pNtk );

    Abc_NtkForEachCo( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PO %s\n",Abc_ObjName(pObj));
        propZero = 1;
        Abc_NodeSetTravIdCurrent( pObj );
        Abc_Obj_t * pFanin ;
        Abc_ObjForEachFanin( pObj, pFanin, j ) {
            if ( Abc_NodeIsTravIdCurrent( pFanin ) )
                continue;
            Abc_NtkDfsReverseProp_rec(pObj, pFanin, propZero );
            FaultCollapse::ResetEquivZeroNodes();
            FaultCollapse::ResetEquivOneNodes();
        }

        if (debug) printf ("<--- End working on PO %s\n\n",Abc_ObjName(pObj));
    }
    FaultCollapse::printEquivClasses(pNtk);
    FaultCollapse::Reset();
}
void Abc_NtkDfsReverse_prop ( Abc_Ntk_t * pNtk , int dbg )
{
    Abc_Obj_t * pObj;
    int i;
    debug = dbg;
    //int propZero = 1;
    // set the traversal ID
    //Abc_NtkIncrementTravId( pNtk );
    assert(Abc_NtkIsMappedLogic(pNtk));
    string fname = Abc_NtkName(pNtk);
    fname += ".";
    fname += "dominant_fault_nodes_PO.info";
    const char* filename = fname.c_str();
    FILE* fp = fopen(filename, "w");
    if (!fp) {
        printf ("Unable to open file %s.\n",filename);
    }
    Abc_NtkForEachCo( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PO %s\n",Abc_ObjName(pObj));
        FaultInfo *f = FaultCollapse::getFaultInfo_PI(pObj);
        if (debug) printf ("PO %s\n",Abc_ObjName(pObj));
        if (fp) fprintf (fp ,"PO %s\n",Abc_ObjName(pObj));
        f->dumpStuckAtInfo(fp);
        if (debug) printf ("<--- End working on PO %s\n\n",Abc_ObjName(pObj));
    }
    fclose(fp);
    fname = Abc_NtkName(pNtk);
    fname += ".";
    fname += "dominant_fault_nodes_PI.info";
    const char* filename2 = fname.c_str();
    fp = fopen(filename2, "w");
    if (!fp) {
        printf ("Unable to open file %s.\n",filename2);
    }
/*
    i = 0;
    Abc_NtkForEachCi( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PI %s\n",Abc_ObjName(pObj));
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pObj);
        printf ("PI %s\n",Abc_ObjName(pObj));
        if (fp) fprintf (fp ,"PI %s\n",Abc_ObjName(pObj));
        f->dumpStuckAtInfo(fp);
        if (debug) printf ("<--- End working on PI %s\n\n",Abc_ObjName(pObj));
    }
*/
    i = 0;
    fprintf (fp, "****************************************\n");
    fprintf (fp, "********** Stuck at %s faults ********\n", "Zero");
    fprintf (fp, "****************************************\n");
    Abc_NtkForEachCi( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PI %s\n",Abc_ObjName(pObj));
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pObj);
        if (f->SA0.size() == 0) continue;
        if (debug) printf ("PI %s\n",Abc_ObjName(pObj));
        if (fp) fprintf (fp ,"PI %s\n",Abc_ObjName(pObj));
        f->dumpSA0Info(fp);
        if (debug) printf ("<--- End working on PI %s\n\n",Abc_ObjName(pObj));
    }
    i = 0;
    fprintf (fp, "****************************************\n");
    fprintf (fp, "********** Stuck at %s faults ********\n", " One");
    fprintf (fp, "****************************************\n");
    Abc_NtkForEachCi( pNtk, pObj, i )
    {
        if (debug) printf ("---> Start working on PI %s\n",Abc_ObjName(pObj));
        FaultInfo *f = FaultCollapse::getFaultInfo_PO(pObj);
        if (f->SA1.size() == 0) continue;
        if (debug) printf ("PI %s\n",Abc_ObjName(pObj));
        if (fp) fprintf (fp ,"PI %s\n",Abc_ObjName(pObj));
        f->dumpSA1Info(fp);
        if (debug) printf ("<--- End working on PI %s\n\n",Abc_ObjName(pObj));
    }
    fclose(fp);
    FaultCollapse::MergeRedundantPIFaultInfo(pNtk);
    FaultCollapse::Reset();
}

/*//////////////////////////////////////////////////////////////////////
///                       END OF FILE                                ///
//////////////////////////////////////////////////////////////////////*/

ABC_NAMESPACE_IMPL_END
