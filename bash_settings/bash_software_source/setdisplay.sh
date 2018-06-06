#!/bin/bash
# Set DISPLAY environment

if  [[ `/bin/uname` == "HP-UX" ]]  ; then
    HUAMI=`/usr/bin/whoami`
    export DISPLAY=`cat ~/.display`
elif  [[ `/bin/uname` == "SunOS" ]]  ; then
    HUAMI=`/usr/ucb/whoami`
    if  [[ ! -z $VNCDESKTOP  ]]  ; then
        export DISPLAY=`echo $VNCDESKTOP|awk '{print $1}'`
        echo $DISPLAY > ~/.display
    elif  [[ $HUAMI == `ls -l /devices/pseudo/cn@0:console | awk '{print $3}'` ]]  ; then
        export DISPLAY=`hostname`:0.0
        touch ~/.display
        echo $DISPLAY > ~/.display
    elif  [[ -f ~/.display ]]  ; then
        export DISPLAY=`cat ~/.display`
    elif  [[ -d ~/.vnc ]]  ; then
        export DISPLAY=`ls -ltr ~/.vnc | nawk -v l=0 '{l=l+1; var[l]=$0} END {print var[l]}' | nawk '{print $NF}' | sed -e 's/\.log//g'`
        echo $DISPLAY > ~/.display
    else
        export DISPLAY=`source /ENV/getdisplay`
    fi
elif  [[ `/bin/uname` == "Linux" ]]  ; then
    HUAMI=`/usr/bin/whoami`
    if  [[ ! -z $VNCDESKTOP  ]]  ; then
        export DISPLAY=`echo $VNCDESKTOP|awk '{print $1}'`
        echo $DISPLAY > ~/.display
    elif  [[ !  -z $NX_SYSTEM  ]]  ; then
        #echo "$HOSTNAME$DISPLAY" > ~/.display
        echo "$HOSTNAME$DISPLAY" > ~/.displaytmp
        DIS=`cat ~/.displaytmp|cut -d':' -f2`
        echo `hostname`':'$DIS > ~/.display
        export DISPLAY=`cat ~/.display`
    elif  [[ $HUAMI == `ls -l /dev/console | awk '{print $3}'` ]]  ; then
        if  [[ `hostname` == localhost.localdomain ]]  ; then
            export DISPLAY=:0.0
        else
            export DISPLAY=`hostname`:0.0
            touch ~/.display
            echo $DISPLAY > ~/.display
        fi
        # elif  [[ -f ~/.display ]]  ; then
        #setenv DISPLAY `cat ~/.display`
    fi
fi
