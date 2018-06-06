############# Tcl 8.5.4 ######################
os=`uname`
tclpath=/in/tcl/8.5.4
if  [[  $os == Linux  ]]  ; then
    if  [[  `cat /etc/issue|grep -c -i enterprise`  -lt 1  ]]  ; then
	echo "The Environment can be source only for RHEL or Solaris Machines."
	exit 1
    else
	if  [[  `cat /etc/issue|grep -c -i taroon` -gt 0  ]]  ; then
	    ver=rhel3
	else
	    ver=rhel4
	fi
	arch=`uname-p`
	export PATH=$tclpath/$ver/$arch/bin:$PATH
    fi
else if  [[  $os == SunOS  ]]  ; then
    export PATH=$tclpath/$os/bin:$PATH
else
    echo "The Environment can be source only for RHEL or Solaris Machines."
fi
