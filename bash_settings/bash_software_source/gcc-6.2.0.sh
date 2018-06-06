#!/bin/bash
GCC=/in/gcc/6.2.0
hosts=`/in/scmtools/generic/sbin/machtype.sh -o | cut -d . -f1`
ver=`uname -p`
if  [[ $ver == x86_64 ]]  ; then
    if [[ $hosts == Linux5 ]]  ||  [[ $hosts == Linux6 ]] ; then
	export PATH=$GCC/$hosts/$ver/bin:$PATH
	if [[ ! -z $LD_LIBRARY_PATH ]]; then
	    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH':'$GCC/$hosts/$ver/lib
	    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH':'$GCC/$hosts/$ver/lib64
	else
	    export LD_LIBRARY_PATH=$GCC/$hosts/$ver/lib
	fi
    fi
else
    echo "GCC 6.2.0 can be sourced for only RHEL6 and RHEL5 64bit machines OS"
    exit 0
fi
