#!/bin/csh
if ( $1 == "" ) then
	echo "\033]30;`whoami`@`hostname`\007"
else
	echo "\033]30;$1@`hostname`\007"
endif

exit
