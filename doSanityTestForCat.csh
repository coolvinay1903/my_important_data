#!/bin/csh -f

if ($1 != "") then
  set testcase = $1
else
  set testcase = "."
endif

if (! -e $testcase) then
  echo "$testcase doesn't exist."
  exit(-1)
endif

ls -Al $testcase/ | grep ^d | awk '{print $9}' | grep -wv CVS > /dev/null

if ($status == 0) then
  echo "TESTCASE '$testcase' CONTAINS THE FOLLOWING SUB_DIRECTORIES :"
  ls -Al $testcase | grep ^d | awk '{print $9}' | grep -wv CVS 

endif

if (!((-e $testcase/run.csh) || ((-e $testcase/compile.csh) && (-e $testcase/veloce_run.csh)))) then
  echo "\nTestcase must have either 'run.csh' or 'compile.csh' & 'veloce_run.csh'."
#  exit(-1)
endif

if (! -e $testcase/gold_files) then
  echo "File 'gold_files' doesn't exist."
#  exit(-1)
endif

if (! -e $testcase/diff_files) then
  echo "File 'diff_files' doesn't exist."
#  exit(-1)
endif

if (-e $testcase/CVS) then
  rm -rf $testcase/CVS >& /dev/null
endif

if (-e $testcase/.owner) then
  rm -rf $testcase/.owner >& /dev/null
endif

#echo $USER > $testcase/.owner

set LS_FILE = "ls_file"
set GOLD_DIFF_FILE = "gold_diff_file"

rm -rf ./$LS_FILE ./$GOLD_DIFF_FILE
ls -A $testcase/ | egrep -vw 'CVS|README|runnew.csh|compile_os3.csh|veloce_run_os3.csh|compile.csh|veloce_run.csh|run.csh|gold_files|diff_files|.branch|.owner|ls_file' >! ./$LS_FILE
cat $testcase/gold_files $testcase/diff_files | sort >! ./$GOLD_DIFF_FILE

comm -2 -3 $LS_FILE $GOLD_DIFF_FILE > .file1
if (-s .file1) then
  echo "\nWarning: File(s) with no entry in gold/diff files. Please remove these and re-run this script."
  cat .file1
#  exit(-1)
endif

comm -1 -3 $LS_FILE $GOLD_DIFF_FILE > .file2
if (-s .file2) then
  echo "\nError: File(s) mentioned in gold/diff files, which don't actually exist."
  cat .file2 
endif
rm -rf $LS_FILE $GOLD_DIFF_FILE .file1 .file2

if (-s $testcase/.branch) then
  set _BRANCH = `cat $testcase/.branch`
  echo "BRANCH file = $_BRANCH"
else
  echo "Note: No .branch file"
endif
