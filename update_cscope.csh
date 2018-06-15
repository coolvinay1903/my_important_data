#!/bin/csh -bf
cd /in/TBX_SANDBOXES/vinays/test_sandbox_2017_11_10/1703/tbx/src/behavc/source;
cvs update;
find -name '*.c*' -o -name '*.h*' | grep -v "~" > cscope.files;
cscope -q -k -b -i cscope.files;
cd -
exit;
