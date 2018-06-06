###### Setup Environment for Cadence IUS 13.20.002 ######

###### Setup CDS_ROOT ######

if  [[  `/bin/uname` == SunOS  ]]  ; then
    #setenv CDS_ROOT /in/ius5.4/sun4v
    #setenv CDS_INST_DIR /in/ius5.4/sun4v
    echo "this version of software is not installed for Solaris 0E"
elif  [[  `/bin/uname` == HP-UX  ]]  ; then
    # export CDS_ROOT=/in/ius5.4/hppa
    # export CDS_INST_DIR=/in/ius5.4/hppa
    echo "this version of software is not installed for hp-ux"
elif  [[  `/bin/uname` == Linux  ]]  ; then
    export CDS_ROOT=/in/vip/external/IUS/13.20.020
    export CDS_INST_DIR=/in/vip/external/IUS/13.20.020
fi

###########

source /home/vinays/bash_settings/bash_software_source/cadence-include.new.sh
