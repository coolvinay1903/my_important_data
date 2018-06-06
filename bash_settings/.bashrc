#!/bin/bash
if [ -f ~/bash_settings/.mybashrc.new ]; then
    . ~/bash_settings/.mybashrc.new
fi
if [ -f ~/bash_settings/.settings_from_csh ]; then
    . ~/bash_settings/.settings_from_csh
fi
if [ -f ~/bash_settings/.bash_aliases ]; then
    . ~/bash_settings/.bash_aliases
fi
if [ -f ~/bash_settings/.bash_functional_aliases ]; then
    . ~/bash_settings/.bash_functional_aliases
fi
