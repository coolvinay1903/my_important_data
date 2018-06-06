#!/bin/bash

# This script needs to be sourced whenever a new shell is being used to set all the environment variables. licenses etc. to proper values
export MED_SITE=Noida
export SYSC_LIB=lib/linux_el30_gnu45/
export VMW_BIN=gnu.product
if [ ! -z $MED_TBX_HOME ]; then
    export TBX_HOME=$MED_TBX_HOME
    export MW_HOME=$MED_TBX_HOME
else
    export TBX_HOME=$VMW_HOME/tbx
    export MW_HOME=$VMW_HOME/tbx
fi
export SYSTEMC=/home/tbx/SYSTEMC/systemc-2.2.0/
export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2:1718@wv-lic-snpslmd.wv.mentorg.com:1718@vanginkel.ies.mentorg.com:1717@innnis4.inn.mentorg.com:1717@innnis3.inn.mentorg.com:1718@wv-lic-snpslmd.wv.mentorg.com::1717@wv-lic-03.wv.mentorg.com:1717@vanginkel.ies.mentorg.com:1717@lichoste.wv.mentorg.com:1717@solmaster.wv.mentorg.com::/LICENSES/mgc.innnis2
export VELCOMP_TBX_MERGE_REG=1
export OS3_REG_ALLOW_LOWER_QUESTA=1
if [ ! -z $BEHAVC_REG_HOME ]; then
    export BEHAVC_REG_HOME=~tbxreg/regressions/TBX_REGRESSIONS
fi
export MACHLIST=$BEHAVC_REG_HOME/scripts/OS3/machlist_noida
export TBX_REGRESS=1
export DIAMOND=1
export TBX_REGRESSIONS=1
export MTI_VCO_MODE=32
export ROOT_TBX=/home/tbx
export HOME_RTLREG=$ROOT_TBX/rtlreg
export TIME_CONTROL=1
export BUILD_PLATFORM=linux_el30_gnu45

# source /ENV/que10.4b
## Questa related settings here
source ~/bash_settings/que10.4b.sh
if [ ! -z $LM_LICENSE_FILE ]; then
    export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2
else
    export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2:$LM_LICENSE_FILE
fi
export ROOT_QUESTA=$MGC_HOME
## End of Questa settings

export HOME_0IN=/in/zero-in10.2b/linux/linux_x86_64
export VERILOG=my_mti
export BEHAVC_COMMON_OPT="-hdl verilog -write_cdfg -allow_4ST -preserve -process_sign -compile_hier_tf"
export BEHAVC_COMMON_OPT="$BEHAVC_COMMON_OPT -allow_bhv_sysvlog"
export DESIGN_OPTIONS="-hdl verilog -write_cdfg -process_sign -allow_4ST -allow_PD -allow_STR -allow_IAD -allow_ZPN -allow_ZPR"
export VERILOG_COMMON_OPT="+define+BEHAVC +define+NO_VCD_DUMP +define+BEHAVC_SIM"
export TIPSIM_COMMON_OPT="-y ./rtlc.out +libext+.v +loadpli1=$BEHAVC_REG_HOME/lib/libmctpli.so:mctsim_bootstrap +define+BEHAVC_SYSTF_TIP -v $VMW_HOME/TIP/tipsim/verilog/tipComodelMacros.v +incdir+$BEHAVC_REG_HOME/lib +define+BEHAVC_EXTERN_CLK +define+BEHAVC_TIPSIM "
export HDL_PLATFORM=mti
export BEHAVC_HOME=$TBX_HOME/rtlc
export RTLC_HOME=$TBX_HOME/rtlc
export MIXED_RTLC_HOME=$TBX_HOME/rtlc
export BEHAVC_EXEC=$TBX_HOME/rtlc/bin/behavc-vle
export BEHAVC=$TBX_HOME/rtlc/bin/behavc-vle
export INCR_CLEAN=TRUE
export LIB_FILE=$BEHAVC_HOME/lib/bhv_med_sim.v
export DIFF_CMD="diff -w -B"
export TBXREGINFRA=/home/tbxreg/GIT_REGRESSION_SCRIPTS/tbxreg/
export DUMP_AREA=/nobackup/vinays/dump/
export GLOBAL_DUMP_AREA=$DUMP_AREA

PATH=$ROOT_QUESTA/bin/:$PATH
PATH=$HOME_0IN/bin/:$VMW_HOME/bin:$TBX_HOME/bin:$TBX_HOME/rtlc/bin:$PATH
export PATH=$TBXREGINFRA/scripts/OS3/:$PATH
