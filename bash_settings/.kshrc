#!/bin/ksh
#
# .kshrc:  Commands executed for each new ksh
#
umask 022
#
# the foll line will prevent core file to be generated
ulimit -c 0
set hn=`hostname`
alias cp='cp -i'
alias mv='mv -i'
PS1='`pwd -P` >> '

#          skip remaining setup if not an interactive shell
#if ($?USER == 0 || $?prompt == 0) exit
#set prompt = "`whoami`@`hostname`[\!] "
#alias setprompt='echo -n ]0\;${host}:${cwd} '

#alias cd='cd \!* ; setprompt'
#alias chdir='chdir \!* ; setprompt'

#######   ****SETENV***   ########
#
# set up search path
#
if [[ -e ~/.alias.kshrc ]]
then
  ENV=~/.alias.kshrc
  export ENV;
fi
export XENVIRONMENT=~/.Xdefaults
export EDITOR=vi
export SHELL=/bin/ksh
export MBOX=~/Mail/mbox
export GCC_LD_LIBRARY_PATH="/usr/local/lib:"
export LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
export PATH=/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin:./sbin

# Emacs keybindings
set -o emacs
