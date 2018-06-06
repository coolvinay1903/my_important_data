#!/bin/bash

#My aliases
#export backslash_quote=1
alias hn='hostname -f'
alias testcases='cd /home/tbxreg/regressions/TBX_REGRESSIONS'
alias d='cd ..'
alias 2d='cd ../..'
alias 3d='cd ../../..'
alias 4d='cd ../../../..'
alias 5d='cd ../../../../..'
alias 6d='cd ../../../../../..'
alias 7d='cd ../../../../../../..'
alias a='. ~/bash_settings/.bash_aliases; . ~/bash_settings/.bash_functional_aliases'
alias ep='. ~/.bashrc'
alias shd='date +%Y%m%d_%H%M%S'
alias sl='ls'
alias ccd='cd'
alias cta='cat'
alias vcr='velcomp -end_task rtlc'
alias va='velanalyze '
alias vcp='velcomp -task cviewpreprocess'
alias rvcp='$RED_OS3FP_HOME/bin/velcomp -task cviewpreprocess'
alias vr='velrun -cview | tee -a vr.`sd`.log'
alias vhv='velhvl -cview -cfiles c_caller.cxx'
#alias sv='source ~/bash_settings/bash_software_source/ius13.20.020.sh; simvision tbx.dump'
alias gdb='/tools/linux64/gdb-7.5.1/bin/gdb'
alias tkdiff='/in/tcl/tkdiff/4.2/tkdiff'
alias xa='x ~/bash_settings/.bash_aliases'
alias xfa='x ~/bash_settings/.bash_functional_aliases'
alias xc='x ~/.bashrc'
alias t='source ~/public/util_scripts/set_term_name.sh'
alias rm='/bin/rm'
alias bv='echo Vi bindings enabled; bindkey -v'
alias be='echo emacs bindings enabled; bindkey -e'
alias decrypt='~/public//util_scripts/decrypt.sh'
alias print='lp -d hp-in11'
alias pdf='/in/Acrobat701/bin/acroread'
alias gtt='csh ~vinays/scripts/GenerateTestDotTcl.csh'

alias pbox='/in/scmtools/x86_64/Linux4/bin/pbox'
alias rmold='rm -rf red.out _red* tbx.* data1.out tbxbindings.h tbx.config transcript ctran.log veloce.log veloce.map velocesim.v veloce.med velrunopts.ini *.log data.out tree.out Recompiled.list Report.out partition.info diff_file* tmpfile*'
alias cst='cstat | grep File:'
alias ffl=' ff ./ "*.cxx"; ff ./ "*.c"; ff ./ "*.cc";ff ./ "*.hxx";ff ./ "*.h"'

## Sandbox related settings

# 1. Red platform settings
#alias vps_settings'export VMW_HOME=/in/vps_releases/releases/OS3_FP_latest ; source /in/TBX_SANDBOXES/vinays/red_settings/setCompileTimeRedHome.sh /in/vps_releases/releases/OS3_FP_latest;'
alias vps_settings='source /in/TBX_SANDBOXES/vinays/vps_releases/OS3_FP_latest/settings/setCompileTimeRedHome.sh'
alias vps_settings_dev='source /in/TBX_SANDBOXES/vinays/vps_releases/DailyBuild_dev/settings/setCompileTimeRedHome.sh'
alias my_vps_settings='export VMW_HOME=/nobackup/vinays/dump/vps/questa_frontend/VMW_HOME;source /in/TBX_SANDBOXES/vinays/red_settings/setCompileTimeRedHome.sh /nobackup/vinays/dump/vps/questa_frontend/VMW_HOME '
alias vps_dev='export MED_TBX_HOME=/in/inntbx9/tbx/vps/sandbox/tbx_dev/tbx_dev/package/TestBench-Xpress/;vps_settings_dev'
alias vps_1703_latest='export MED_TBX_HOME=/in/inntbx9/tbx/vps/sandbox/tbx_1703/tbx_1703/package/TestBench-Xpress;vps_settings'
alias myvps_1703='export MED_TBX_HOME=/nobackup/vinays/dump/vps/questa_frontend/VMW_HOME/tbx; my_vps_settings'
alias vps_vel_settings='source /in/TBX_SANDBOXES/vinays/vps_releases/OS3_FP_latest/settings/setCompileTimeVeloceHome.sh'
alias vps_1703_latest_vel='export MED_TBX_HOME=/in/inntbx9/tbx/vps/sandbox/tbx_1703/tbx_1703/package/TestBench-Xpress;vps_vel_settings'


# 2. Veloce platform settings
alias env_settings='source /home/vinays/bash_settings/setVeloce.sh '
alias masterbuild_dev='export VMW_HOME=/med/distrib/Diamond_RD/qa/blue/rnd/software/; export MED_TBX_HOME=/in/tbx1/rtlc_behavc_builds/tbx_dev/package/TestBench-Xpress/;env_settings tbx_dev'
alias masterbuild_1800='export VMW_HOME=/med/distrib/Diamond_RD/qa/v1800_latest/rnd/software/; export MED_TBX_HOME=/in/tbx1/rtlc_behavc_builds/tbx_1800/package/TestBench-Xpress/;env_settings tbx_1800'
alias masterbuild_1703='export VMW_HOME=/med/distrib/Diamond_RD/qa/v1703_latest/rnd/software/; export MED_TBX_HOME=/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress/;env_settings tbx_1703'

alias mybuild_1703='export VMW_HOME=/med/distrib/Diamond_RD/qa/v1703_latest/rnd/software/; export MED_TBX_HOME=/in/TBX_SANDBOXES/vinays/tbx_1703/package/TestBench-Xpress;env_settings tbx_1703'
alias mybuild_dev='export VMW_HOME=/med/distrib/Diamond_RD/qa/blue/software; export MED_TBX_HOME=/in/TBX_SANDBOXES/vinays/tbx_dev/package/TestBench-Xpress;env_settings tbx_dev'
# end of sandbox related settings

alias rtlcommit='/home/rtlc/SOFTWARES/bin/rtlcommit'
alias testing='export TBXREGINFRA=/in/TBX_SANDBOXES/vinays/reg/tbxreg/; export PATH=$TBXREGINFRA/scripts/OS3/:$PATH ; export DUMP_AREA=/nobackup/vinays/dumpx'
alias setgit='source /tools/git/bin/git_setup.sh'
alias unsetregress='unset TBX_REGRESS ; unset TBX_REGRESSIONS'
alias unreg='unset TBX_REGRESS ; unset TBX_REGRESSIONS'
alias reg='export TBX_REGRESS=1; export TBX_REGRESSIONS=1'

#alias aalias
alias u=unalias
alias m=more
alias cpr='cp -r'
alias k9='kill -9 %%'
alias kp='kill_process'
alias g='gvim'
alias csc='cscope -d'
alias ld='ls'
alias lo=logout
unset autologout

######################### Make relatedalias ############################=
alias makedebug='makefast.grid Optimize=debug Support=behav && makefast.grid Optimize=debug Support=rtl'
alias makeopt='makefast.grid Support=behav && makefast.grid Support=rtl'
alias moc='makefast.grid Support=rtl'
alias mob='makefast.grid Support=behav'
alias modb='makefast.grid Support=behav && makefast.grid Optimize=debug Support=behav'
alias modc='makefast.grid Support=rtl && makefast.grid Optimize=debug Support=rtl'
alias mg='makefast.grid'
alias mcb='make clean Support=behav && make clean Optimize=debug Support=behav'
alias mcc='make clean Support=rtl && make clean Optimize=debug Support=rtl'
alias mclean='mcc && mcb'
alias mk='make clean && make && cd ../exportlibs/ && make clean && make'
alias mm='make clean && make && cd .. && make update & cd .. && make update'
alias mkall='cd mct/kernel/ && make clean && make && cd ../exportlibs/ && make clean && make && cd ../../modelworks/middleware && make clean && make && cd .. && make update & cd .. && make update'
alias makeall_vps='make clean Support=rtl FpgaProto=yes && make clean FpgaProto=yes && makeVeryFast.64 Support=rtl FpgaProto=yes && makeVeryFast.64 FpgaProto=yes'
alias makeall='make clean Support=rtl && make clean && makeVeryFast.64 Support=rtl && makeVeryFast.64'
alias modbr='make clean Support=behav && make clean Optimize=debug Support=behav && make clean Support=rtl && make clean Optimize=debug Support=rtl && makeVeryFast.64 Support=rtl && makeVeryFast.64 Support=behav && makeVeryFast.64 Support=rtl Optimize=debug && makeVeryFast.64 Support=behav Optimize=debug '
##########################################################################

alias sa='export RTLC_STOP_ASSERT=1'
alias st='source ~/public/util_scripts/set_term_name.sh '
alias cvsd='cvs -q diff -u'

######################### Emulator related alias #########################=
alias bstat='bub st -r \$Emulator '
alias bgetl='bub lock -r \$Emulator -t 40 '
alias back='bub ack -r \$Emulator '
alias bkill='bub kill -r \$Emulator '
alias eon='source ~/scripts/pwon.sh '
alias eoff='source ~/scripts/pwoff.sh '
alias estat='emu st -r \$Emulator '
alias egetl='emu lock -r \$Emulator -t 40 '
alias eack='emu ack -r \$Emulator '
alias ekill='emu kill -r \$Emulator '
alias eon='source ~/scripts/pwon.sh '
alias eoff='source ~/scripts/pwoff.sh '
#########################################################################

alias sd='export DISPLAY=`cat ~/.display`'
alias s6='ssh inntbx11'
alias s5='ssh inndt33'
alias cf="cvs -q diff|grep Index| awk '{print \$2}' > changed_files"
alias ldpath='export LD_LIBRARY_PATH=$TBX_HOME/lib/linux64_el30_gnu472:$TBX_HOME/lib/linux64_el30_gnu620:$TBX_HOME/lib/linux64_el30_gnu45:$TBX_HOME/lib/linux_el30_gnu45:$TBX_HOME/rtlc/rtlcLib:$LD_LIBRARY_PATH; export SHELL=sh'
alias gdbsettings='/home/vinays/bash_settings/bash_software_source/gdb-7.4.1.sh; export RTLC_STOP_ASSERT=1; export BEHAVC_HOME=$TBX_HOME/rtlc; export RTLC_HOME=$BEHAVC_HOME; ldpath'
alias ldpath_dev='export LD_LIBRARY_PATH=$TBX_HOME/lib/linux64_el30_gnu620:$TBX_HOME/lib/linux64_el30_gnu472:$TBX_HOME/lib/linux64_el30_gnu45:$TBX_HOME/lib/linux_el30_gnu45:$TBX_HOME/rtlc/rtlcLib:$LD_LIBRARY_PATH; export SHELL=sh'
alias gdbsettings_dev='export PATH=/in/gdb/7.4.1/Linux6/x86_64/bin:$PATH; export LD_LIBRARY_PATH=/in/gdb/7.4.1/Linux6/x86_64/lib:$LD_LIBRARY_PATH;source /home/vinays/bash_settings/bash_software_source/gcc-6.2.0.sh; export RTLC_STOP_ASSERT=1; export BEHAVC_HOME=$TBX_HOME/rtlc; export RTLC_HOME=$BEHAVC_HOME; ldpath_dev'
alias gdbsettings_1703='export PATH=/in/gdb/7.4.1/Linux6/x86_64/bin:$PATH; export LD_LIBRARY_PATH=/in/gdb/7.4.1/Linux6/x86_64/lib:$LD_LIBRARY_PATH;source ~vinays/bash_settings/gcc7.sh; export RTLC_STOP_ASSERT=1; export BEHAVC_HOME=$TBX_HOME/rtlc; export RTLC_HOME=$BEHAVC_HOME; ldpath'
alias acro='/in/Acrobat942/bin/acroread'
alias build_vle='/home/vinays/public/util_scripts/build-vle.sh'
export SB=/in/TBX_SANDBOXES/vinays
export VSB=/in/TBX_SANDBOXES/vinays/vps_sandbox
export PRINTER=hp-in11
export EDITOR=emacs
export CVSROOT=/home/rtlc/RTLCROOT
