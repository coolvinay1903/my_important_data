#!/bin/bash

pgm=${0##*/}
behavc=0;
rtlc=0;
opt=0;
debug=0;
clean=0;
fpga=0;
vf=0;
extra_args="";
make_options="";
make_cmd="make";
help() {
    echo "This script starts a build for behav or rtlc."
    echo "Usage: $pgm -b -r -c -o -d -f -vf"
    echo " -b = compile behavc"
    echo " -r = compile rtlc"
    echo " -o = optimized/release build"
    echo " -d = debug build"
    echo " -c = clean build"
    echo " -f = Build for fpga flow"
    echo " -vf = MakeVeryFast"
    echo " -h|-help = Print this help"
}
echo_eval() {
    echo "$@"
    eval $@;
}
clean() {
    echo_eval "make clean $@"
}
clean_debug() {
    echo_eval "make clean Optimize=debug $@"
}
make_opt() {
    echo_eval "$make_cmd $@"
}
make_debug() {
    echo_eval "$make_cmd Optimize=debug $@"
}

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -b)
            behavc=1;
            #make_options="$make_options Support=behav"
            shift # past argument
            ;;
        -r)
            rtlc=1;
            #make_options="$make_options Support=rtl"
            shift # past value
            ;;
        -o)
            opt=1;
            shift # past value
            ;;
        -vf)
            vf=1;
            make_cmd="makeVeryFast.64"
            if [[ -z $DISPLAY ]]; then
                echo "Warning: DISPLAY is not set. Trying to set it to the following";
                echo `cat ~/.display`;
                export DISPLAY=`cat ~/.display`;
            fi
            shift # past value
            ;;
        -d)
            debug=1;
            #make_options="$make_options Optimize=debug"
            shift # past value
            ;;
        -c)
            clean=1;
            #make_options="$make_options clean"
            shift # past argument
            ;;
        -f)
            fpga=1;
            make_options="$make_options FpgaProto=yes"
            shift # past argument
            ;;
        -h|-help)
            help;
            exit 0;
            shift
            ;;
        *)    # unknown option
            extra_args="$extra_args $key"
            shift # past argument
            ;;
    esac
done
# if [[ $behavc == 0 ]] && [[ $rtlc == 0 ]]; then
#     echo "ERROR: Please pass -b or -r for behav or rtlc"
#     help;
#     exit -1;
# fi
if [[ $opt == 0 ]] && [[ $debug == 0 ]] && [[ $clean == 0 ]]; then
    echo  "ERROR: One of the tasks must be passed."
    help;
    exit -1;
fi
make_options="$make_options $extra_args"
echo "Make Options = $make_options";
if [[ $debug == 1 ]]; then
    if [[ $behavc == 1 ]]; then
        if [[ $clean == 1 ]]; then
            clean_debug "Support=behav $make_options"
        fi
        make_debug "Support=behav $make_options"
    fi
    if [[ $rtlc == 1 ]]; then
        if [[ $clean == 1 ]]; then
            clean_debug "Support=rtl $make_options"
        fi
        make_debug "Support=rtl $make_options"
    fi
    if [[ $behavc == 0 ]] && [[ $rtlc == 0 ]]; then
        if [[ $clean == 1 ]]; then
            clean_debug "$make_options"
        fi
        make_debug "$make_options"
    fi
fi

if [[ $opt == 1 ]]; then
    if [[ $behavc == 1 ]]; then
        if [[ $clean == 1 ]]; then
            clean "Support=behav $make_options"
        fi
        make_opt "Support=behav $make_options"
    fi
    if [[ $rtlc == 1 ]]; then
        if [[ $clean == 1 ]]; then
            clean "Support=rtl $make_options"
        fi
        make_opt "Support=rtl $make_options"
    fi
    if [[ $behavc == 0 ]] && [[ $rtlc == 0 ]]; then
        if [[ $clean == 1 ]]; then
            clean "$make_options"
        fi
        make_opt "$make_options"
    fi
fi
exit 1;
