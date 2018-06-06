#!/bin/bash -f
export PATH=/tools/linux64/gcc-4.7.2/bin:$PATH
if  [[ ! -z MAN_PATH ]]; then
    MAN_PATH=/usr/man
fi
export MAN_PATH=/tools/linux64/gcc-4.7.2/man/:$MAN_PATH
export LD_LIBRARY_PATH=/tools/linux64/gcc-4.7.2/lib64:$LD_LIBRARY_PATH
