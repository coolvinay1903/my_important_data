#!/bin/bash

source /home/vinays/bash_settings/env_script.sh

##########  DEFAULT
export RTLC_EXEC=$MED_TBX_HOME/rtlc/bin/rtlc-vle
export BEHAVC_EXEC=$MED_TBX_HOME/rtlc/bin/behavc-vle
export POSTPROC_EXEC=$MED_TBX_HOME/rtlc/bin/postproc-vle

##########  Generic
export BEHAVC=$BEHAVC_EXEC
export TBX_HOME=$MED_TBX_HOME
export RTLC_HOME=$MED_TBX_HOME/rtlc
export BEHAVC_HOME=$MED_TBX_HOME/rtlc
export BEHAVC_REG_HOME=/home/tbxreg/regressions/TBX_REGRESSIONS/
export PATH=$BEHAVC_REG_HOME/scripts/OS3:$BEHAVC_REG_HOME/scripts:/tools/linux/bin/:$PATH
if [[ ! -z $1 ]]; then
    export BRANCH=$1
else
    export BRANCH=tbx_1703
fi
export LD_LIBRARY_PATH=$MED_TBX_HOME/rtlc/rtlcLib:$MED_TBX_HOME/lib/linux_el30_gnu45:$MED_TBX_HOME/lib/linux64_el30_gnu620:$MED_TBX_HOME/lib/linux64_el30_gnu472:$LD_LIBRARY_PATH
