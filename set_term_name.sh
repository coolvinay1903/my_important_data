#!/bin/bash
input_string=$1;
if [[ -z $input_string ]]; then
  echo -ne "\033]0;${USER}@${HOSTNAME}\007"
else
  echo -ne "\033]0;${input_string}\007"
fi
