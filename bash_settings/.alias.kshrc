#!/bin/ksh
alias testcases='cd /home/tbxreg/regressions/TBX_REGRESSIONS'
alias d='cd ..'
alias 2d='cd ../..'
alias 3d='cd ../../..'
alias 4d='cd ../../../..'
alias 5d='cd ../../../../..'
alias 6d='cd ../../../../../..'
alias 7d='cd ../../../../../../..'
alias a='source ~/.alias.cshrc'
alias ep='source ~/.cshrc'
alias x='xemacs -geometry 900x600 -bg white -fg black '
alias sd='date +%Y_%m_%d'
alias sl='ls'
alias ccd='cd'
alias cta='cat'
alias emacs='/tools/emacs/emacs-24.4/rhel5/bin/emacs'
alias xemacs='emacs'
alias uc="tr '[a-z]' '[A-Z]'"
alias lc="tr '[A-Z]' '[a-z]'"
alias rm='/bin/rm'
alias bv='echo Vi bindings enabled; bindkey -v'
alias be='echo emacs bindings enabled; bindkey -e'
#alias last='history 1000|awk \'{\$1 \"\"; print substr(\$0,2)}\'|grep '
#alias recent="history 1000 | awk ' { \$2=\"\"; \$1=\"\"; print substr (\$0,3) } ' |grep "
#alias recent='history 1000 | awk " { \$2=\"\"; \$1=\"\"; print substr (\$0,3) } " |grep '
#alias recent="historya!
#alias recent="history 1000 | perl -nle 'm/(\s*\S+\s+\S+\s+)(.*)/ and print \$2' | grep "
alias print='lp -d hp-in11'
alias tkdiff='/home/mjhalava/bin/tkdiff'
alias pdf='/in/Acrobat701/bin/acroread'
alias gtt='csh ~angoyal/scripts/GenerateTestDotTcl.csh'
alias wcp='csh ~angoyal/scripts/wget.csh \!:1 \!:2'
alias my_rcp='rcp \!:1 pcr513.fra.mentorg.com:/home/angoyal/'
alias upd='csh ~angoyal/scripts/updateGold.csh \!:1'
alias scon_setup='export SCON=1 ; senv gcc-4.9.2 ; export VCO=aof'
alias decryptl='/in/scmtools/Linux3/bin/ikoscrypt_new -key "HJ-&en*A@KL2" -decrypt \!*'
alias pbox='/in/scmtools/x86_64/Linux4/bin/pbox'
alias rmold='rm -rf data1.out tbxbindings.h tbx.config transcript veloce.log veloce.map velocesim.v veloce.med velrunopts.ini'
alias cstat='cvs status \!* | grep Status | grep -v Up-to-date'
alias cst="cstat | grep File:"
alias ff='find \!:1 -name \!:2 -print'
alias ffl="ff ./ '*.cxx'; ff ./ '*.c'; ff ./ '*.cc';ff ./ '*.cc';ff ./ '*.hxx';ff ./ '*.h'"
alias grepc='grep -s \!:* `ffl`'
alias decryptl_new='/in/scmtools/Linux3/bin/ikoscrypt_new -key "HJ-&en*A@KL2" -decrypt \!*'
alias decryptl_dev='/home/tbx/CRYPT/ikoscrypt -key "HJ-&en*A@KL2" -decrypt \!*'
alias vps_settings='export VMW_HOME=/in/vps_releases/releases/OS3_FP_latest ; source ~angoyal/settings/setCompileTimeVeloceHome ; source ~angoyal/settings/setRunTimeEnvVars ; source ~angoyal/settings/setRegressionSettings'
alias vps_settings='export VMW_HOME=/med/distrib/Diamond_RD/distribution/Prototype_RED22/OS3_FP.17.0.4-3 ; source ~angoyal/settings/setCompileTimeVeloceHome ; source ~angoyal/settings/setRunTimeEnvVars ; source ~angoyal/settings/setRegressionSettings'
alias vps='export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/vps/tbx_dev/TestBench-Xpress/; vps_settings'
alias vps_1703='export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/vps_1703/TestBench-Xpress/; vps_settings'
alias vps2='export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/vps2/TestBench-Xpress/; vps_settings'
alias vps_release='export MED_TBX_HOME=/in/vps_releases/releases/OS3_FP_latest; vps_settings'
alias vps='export VMW_HOME=/med/distrib/Diamond_RD/distribution/Prototype_RED22/OS3_FP.17.0.4-2/; export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/vps/tbx_dev/TestBench-Xpress/; source ~angoyal/settings/setCompileTimeVeloceHome ; source ~angoyal/settings/setRunTimeEnvVars ; source ~angoyal/settings/setRegressionSettings'
alias mybuild='export VMW_HOME=/distrib/Diamond_RD/qa/v1700_latest/rnd/software/; export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/master_dev_new/TestBench-Xpress; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias masterbuild='export VMW_HOME=/distrib/Diamond_RD/qa/v1700_latest/rnd/software/; export MED_TBX_HOME=/in/tbx1/rtlc_behavc_builds/tbx_dev/package/TestBench-Xpress/; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias masterbuild_1703='export VMW_HOME=/distrib/Diamond_RD/qa/v1703_latest/rnd/software/; export MED_TBX_HOME=/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress/; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias mybuild_1703='export VMW_HOME=/distrib/Diamond_RD/qa/v1703_latest/rnd/software/; export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/1703/tbx_1703/src/TestBench-Xpress; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias mybuild_1703_tmp='export VMW_HOME=/distrib/Diamond_RD/qa/v1703_latest/rnd/software/; export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/temp/TestBench-Xpress; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias dummy='export VMW_HOME=/distrib/Diamond_RD/qa/v1700_latest/rnd/software/; export MED_TBX_HOME=/in/TBX_SANDBOXES/angoyal/dummy/TestBench-Xpress/; source ~angoyal/TbxTestcase/setVeloce; source ~angoyal/TbxTestcase/env_script.csh'
alias rtlcommit=/home/rtlc/SOFTWARES/bin/rtlcommit
alias runWithPerticularRelease='export VMW_HOME=/in/TBX_SANDBOXES/dsethi/OS3_FP.17.0.4-2/; export MED_TBX_HOME=/med/distrib/Diamond_RD/distribution/Prototype_RED22/OS3_FP.17.0.4-2/tbx/ ; source ~angoyal/settings/setCompileTimeVeloceHome ; source ~angoyal/settings/setRunTimeEnvVars ; source ~angoyal/settings/setRegressionSettings'
alias testing='export TBXREGINFRA=/in/TBX_SANDBOXES/angoyal/reg/tbxreg/ ; export PATH=$TBXREGINFRA/scripts/OS3/:$PATH ; export DUMP_AREA=/nobackup/angoyal/dumpx'
alias setgit='source /tools/git/bin/git_setup.csh'
alias reddecryptl="/in/TBX_SANDBOXES/dsethi/tbx_1703/src/rtlc/Applications/Decryptor/PreciseDecrypt -enfile \!:1 -dcfile \!:1.decrypt"
alias findf='find . -name '
alias vps_release_master='export MED_TBX_HOME=/in/inntbx9/tbx/vps/sandbox/tbx_dev/tbx_dev/package/TestBench-Xpress/ ; vps_settings'
alias vps_release_master_1703='export MED_TBX_HOME=/in/inntbx9/tbx/vps/sandbox/tbx_1703/tbx_1703/package/TestBench-Xpress/ ; vps_settings; export BRANCH=tbx_1703'
alias vps_latest="source /in/TBX_SANDBOXES/dsethi/OS3_FP.17.0.4-7/settings/setCompileTimeVeloceHome ; source /in/TBX_SANDBOXES/dsethi/OS3_FP.17.0.4-7/settings/setCompileTimeRedHome ; source /in/TBX_SANDBOXES/dsethi/OS3_FP.17.0.4-7/settings/setRunTimeEnvVars ; source /in/TBX_SANDBOXES/dsethi/OS3_FP.17.0.4-7/settings/setRegressionSettings"
alias unsetregress='unexport TBX_REGRESS=; unsetenv TBX_REGRESSIONS'
alias decryptl_new_D3='/home/tbx/CRYPT/ikoscrypt -emul_platform D3 -key "HJ-&en*A@KL2" -decrypt '
alias nonreg='unexport TBX_REGRESS=; unsetenv TBX_REGRESSIONS'
alias nonreg_undo='export TBX_REGRESS=1; export TBX_REGRESSIONS=1'
alias u='unalias'
alias m='more'
alias cpr='cp -r'
alias g='gvim'
alias vim='gvim'
alias lo='logout'
