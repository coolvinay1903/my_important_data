#!/bin/bash
function get_disk_usage_profile () {
    id="[update_and_setup_cscope]:";
    current_dir=`pwd`
    if [[ -d $1 ]]; then
        cd $1;
    else
        echo "$id (E) $1 doesn't exist or permission denied."
        return 1;
    fi
    du -m -c `pwd` | sort -n -r  > disk_usage 2>&1
    if [[ $? -eq 0 ]]; then
        echo "$id Successfully profiled `pwd` ."
        cd $current_dir
        return 0;
    else
        echo "$id (E) There was some issue with profiling for `pwd` ."
        cd $current_dir
        return 1;
    fi
}
get_disk_usage_profile /home/vinays
get_disk_usage_profile /nobackup/vinays/dump
get_disk_usage_profile /in/TBX_SANDBOXES/vinays
