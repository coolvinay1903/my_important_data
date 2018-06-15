#!/bin/csh -f

#setenv VMW_HOME /distrib/Diamond_RD/qa/v3100_latest/rnd/software/
#setenv MED_TBX_HOME /home/tbx/tbx_regressions/product/tbx_dev/TestBench-Xpress/

setenv VMW_HOME /distrib/Diamond_RD/qa/v1703_latest/rnd/software
setenv MED_TBX_HOME /in/TBX_SANDBOXES/vinays/1703/tbx_1703/src/TestBench-Xpress
setenv MY_DUMP_AREA /nobackup/vinays/dump
setenv TIME_CONTROL 1
setenv BEHAVC_REG_HOME /home/tbxreg/regressions/TBX_REGRESSIONS
setenv USER_MAIL_LIST "vinays@mentor.com"
setenv TBXREGINFRA /home/tbxreg/GIT_REGRESSION_SCRIPTS/tbxreg
#set cat_list="XRTL_CALLER XRTL_ASYNC_CALLER"
#/bin/rm -rf category_file
#echo $cat_list > category_file
#setenv USER_CATEGORY_LIST /home/vinays/public/util_scripts/reg_categories
unsetenv USER_CATEGORY_LIST

#printf "Firing tbx_dev regressions with $VMW_HOME and with\n	\
#MED_TBX_HOME = $MED_TBX_HOME\n									\
#VMW_HOME = $VMW_HOME\n											\
#BEHAVC_HOME = $BEHAVC_HOME\n									\
#RTLC_HOME = $RTLC_HOME\n										\
#BEHAVC_EXEC = $BEHAVC_EXEC\n									\
#RTLC_EXEC = $RTLC_EXEC\n										\
#MY_DUMP_AREA = $MY_DUMP_AREA\n									\
#BEHAVC_REG_HOME = $BEHAVC_REG_HOME\n							\
#USER_CATEGORY_LIST = $USER_CATEGORY_LIST\n						\
#USER_MAIL_LIST = $USER_MAIL_LIST\n								\
#"
### Unit Cview Regression 32 bit runtime
#setenv MY_GCC_HOME /tools/linux/gcc-4.3.3/
echo "Regress command = $TBXREGINFRA/scripts/OS3/xrtl_distributed_reg_norerun_dev.all -64 -release $VMW_HOME -productTree tbx_dev -veloce -dump_area $MY_DUMP_AREA/behavc_unit_testcases/pdev_64bit_linux_dump -mw_home $MED_TBX_HOME"

echo "Type yes/Yes/Y/y to continue"
set answer = $<
if ( $answer == "yes" || $answer == "Yes" || $answer == "YES" || $answer == "Y" || $answer == "y" ) then
	$TBXREGINFRA/scripts/OS3/xrtl_distributed_reg_norerun_dev.all -64 -release $VMW_HOME -productTree tbx_dev -veloce -dump_area $MY_DUMP_AREA/behavc_unit_testcases/pdev_64bit_linux_dump -mw_home $MED_TBX_HOME
endif
