#!/bin/bash
pa=`echo $PATH | sed -e 's@/in/graphviz-2.28/[a-zA-Z0-9._/-]* @@g'`
export PATH=$pa
export KDE_PLATFORM=`/in/scmtools/generic/sbin/machtype.sh -p`
export KDE_OPSYS=`/in/scmtools/generic/sbin/machtype.sh -o|cut -d '.' -f1`
echo $KDE_PLATFORM, $KDE_OPSYS
if [[ $KDE_OPSYS == 'Linux5' ]]; then
    export PATH=/in/graphviz-2.28/Linux5/bin:$PATH
    if  [[ ! -z $LD_LIBRARY_PATH  ]]  ; then
	if  [[  `/bin/uname -p` == x86_64  ]]  ; then
	    export LD_LIBRARY_PATH=/in/graphviz-2.28/Linux5/lib:$LD_LIBRARY_PATH
	fi
    else
	export LD_LIBRARY_PATH=/in/graphviz-2.28/Linux5/lib
    fi
else 
    if [[ $KDE_OPSYS == 'Linux4' ]]; then
	export PATH=/in/graphviz-2.28/Linux4/bin:$PATH
	if  [[ ! -z $LD_LIBRARY_PATH  ]]  ; then
	    if  [[  `/bin/uname -p` == x86_64  ]]  ; then
		export LD_LIBRARY_PATH=/in/graphviz-2.28/Linux4/lib:$LD_LIBRARY_PATH
	    fi
	else
	    export LD_LIBRARY_PATH=/in/graphviz-2.28/Linux4/lib
	fi
    else
	echo "Graphviz can only be sourced for only Linux 64 bit machines"
    fi
fi
