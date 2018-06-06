#!/bin/csh -b
#
# .cshrc:  Commands executed for each new csh
#
if ( ${?prompt} != 0 ) then
	set osname = `uname -s`
	set version = `uname -r`
	if ( -e /ENV/alias) then
		source /ENV/alias
	endif
	if ( -e /ENV/setdisplay ) then
		source /ENV/setdisplay
	endif
	set backslash_quote
	switch ($osname)
			case HP-UX:
				switch ($version)
						case B.*:
							source $HOME/.cshrc.hp
							breaksw
					endsw	
				breaksw
			case SunOS:
				switch ($version)
						case 5.*:
								source ~$USER/.cshrc.solaris
								breaksw
						endsw
				breaksw
			case Linux:
				switch ($version)
                        case 2.*:
                                source ~$USER/.cshrc.linux
								breaksw
						endsw
				breaksw
		  	default:
				echo "Unable to Source Environment"
				exit 1
	endsw
	if (-e ~/.mycshrc) then
		source ~/.mycshrc
	endif
	if (-e ~/.alias) then
		source ~/.alias
	endif
endif
