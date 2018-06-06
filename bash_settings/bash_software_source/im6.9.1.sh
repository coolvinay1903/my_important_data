#!/bin/bash
pack=/in/ImageMagick/6.9.1-5
hosts=`/in/scmtools/generic/sbin/machtype.sh -o|cut -d. -f1`
ver=`uname -p`
if  [[ $ver == x86_64 ]]  ; then
    if  [[  $hosts == Linux5  ]]  ; then
        export PATH=$pack/$hosts/$ver/bin:$PATH
        export LD_LIBRARY_PATH=$pack/$hosts/$ver/lib:$LD_LIBRARY_PATH
    fi
else
    echo "ImageMagick can be sourced for only RHEL5 machines OS"
    exit 0
fi
