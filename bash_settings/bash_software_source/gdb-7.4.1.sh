#!/bin/bash
GDB=/in/gdb/7.4.1
hosts=`/in/scmtools/generic/sbin/machtype.sh -o|cut -d. -f1`
ver=`uname -p`
if  [[  $ver == x86_64  ]]  ; then
    if  [[ $hosts == Linux5 ]] || [[ $hosts == Linux4 ]] || [[ $hosts == Linux6 ]]; then
	export PATH=$GDB/$hosts/$ver/bin:$PATH
	if  [[ ! -z $LD_LIBRARY_PATH  ]]  ; then
	    export LD_LIBRARY_PATH=$GDB/$hosts/$ver/lib64:/lib:$LD_LIBRARY_PATH
	else
	    export LD_LIBRARY_PATH=$GDB/$hosts/$ver/lib64:/lib
	fi
    fi
else
    echo "GDB 7.4.1 can be sourced for only RHEL5 or RHEL4 or RHEL6 machines with 64bit OS"
    exit 0
fi
