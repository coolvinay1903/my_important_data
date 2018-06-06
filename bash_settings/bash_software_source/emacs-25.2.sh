#!/bin/bash
EMACS=/in/emacs/25.2
hosts=`/in/scmtools/generic/sbin/machtype.sh -o| cut -d. -f1`
ver=`uname -p`
if  [[ $ver == x86_64 ]]  &&  [[ $hosts == Linux6 ]]  ; then
    export PATH=$EMACS/$hosts/$ver/bin:$PATH
    echo "Environment sourced for EMACS 25.2 "
else
    echo "EMACS 25.2 can be sourced for only RHEL6 64bit machines OS"
    exit 0
fi
