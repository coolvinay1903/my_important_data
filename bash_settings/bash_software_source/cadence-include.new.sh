#!/bin/bash
###### Setting up PATH ######

pa1=`echo $PATH | sed -e 's/\/in\/cadence\/tools\/bin//g' | sed -e 's/\/in\/cadence.old\/tools\/bin//g'`
pa2=`echo $pa1 | sed -e 's/\/in\/cadence\/tools.hppa\/bin//g' | sed -e 's/\/in\/ldv[0-9]\.[0-9]\/tools.hppa\/bin//g'`
pa=`echo $pa2 | sed -e 's/\/in\/ldv[0-9]\.[0-9]\/*[A-Z,0-9]*\/tools\/bin//g' | sed -e 's@/in/ius[0-9]\.[0-9]/*[a-zA-Z,0-9]*/tools/bin@@'`
unset PATH
unset path

export PATH=$CDS_ROOT/tools/bin:$CDS_ROOT/tools.lnx86/bin/64bit:$CDS_ROOT/tools.lnx86/bin/64bit:$pa
###### Setting up LM_LICENSE_FILE ######

if  [[ ! -z $LM_LICENSE_FILE ]]  ; then
    LM1=`echo $LM_LICENSE_FILE | sed -e 's/1717@vanginkel.ies.mentorg.com//g' | sed -e 's/1717@ies-lic-cdslmd.ies.mentorg.com//g' | sed -e 's/1717@lichoste.wv.mentorg.com//g' | sed -e 's/1717@solmaster.wv.mentorg.com//g'`
    LM=`echo $LM1 | sed -e 's/^://' | sed -e 's/$://g' | sed -e 's/:*//'`
    unset LM_LICENSE_FILE
    if  [[ `echo $LM | /usr/bin/wc -m` -gt 2 ]]  ; then
        export LM_LICENSE_FILE=1717@ies-lic-cdslmd.ies.mentorg.com:$LM
    else
        export LM_LICENSE_FILE=1717@ies-lic-cdslmd.ies.mentorg.com
    fi
else
    export LM_LICENSE_FILE=1717@ies-lic-cdslmd.ies.mentorg.com
fi

###### Setting up LD_LIBRARY_PATH ######

if  [[ ! -z $LD_LIBRARY_PATH ]]  ; then
    LD1=`echo $LD_LIBRARY_PATH | sed -e 's/\/in\/cadence\/tools\/lib//g' | sed -e 's/\/in\/cadence.old\/tools\/lib//g'`
    LD2=`echo $LD1 | sed -e 's/\/in\/ldv[0-9]\.[0-9]\/*[A-Z,0-9]*\/tools\/lib//g'`
    LD3=`echo $LD2 | sed -e 's/\/in\/ldv[0-9]\.[0-9]\/tools.hppa\/lib//g'`
    LD=`echo $LD3 | sed -e 's/^://' | sed -e 's/$://g' | sed -e 's/:*//'`

    unset LD_LIBRARY_PATH
    if  [[ `echo $LD | /usr/bin/wc -m` -gt 3 ]]  ; then
        export LD_LIBRARY_PATH=$LD
    fi
    if  [[ `echo $LD | /usr/bin/wc -m` -gt 3  ]]  ; then
        export LD_LIBRARY_PATH=$CDS_ROOT/tools/lib:$LD_LIBRARY_PATH
    else
        export LD_LIBRARY_PATH=$CDS_ROOT/tools/lib
    fi
else
    export LD_LIBRARY_PATH=$CDS_ROOT/tools/lib
fi
unset pa pa1 pa2 LM LM1 LM2 LD LD1 LD2 LD3
