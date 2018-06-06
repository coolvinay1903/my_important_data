#!/bin/bash
GCC=/in/gcc/4.7.2
hosts=`/in/scmtools/generic/sbin/machtype.sh -o | cut -d . -f1`
ver=`uname -p`
if  [[  $ver == x86_64  ]]  ; then
    if  [[ $hosts == Linux5 ]]  ||  [[ $hosts == Linux4 ]]; then
	export PATH=$GCC/$hosts/$ver/bin:$PATH
	export LD_LIBRARY_PATH=$GCC/$hosts/$ver/lib:$LD_LIBRARY_PATH
    fi
else
    echo "GCC 4.7.2 can be sourced for only RHEL5 and RHEL4 machines with 64bit OS"
    exit 0
fi
