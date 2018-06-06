alias pss='/usr/bin/ps -ef -o vsz -o pid -o user -o stime -o comm | sort -nr | head'
alias phone="/in/local/phone"
alias ph="/in/local/phone"
alias library="/in/local/inv/db library"
alias db="/in/local/inv/db"
alias dbl="/in/local/inv/db linux"
alias dblw="/in/local/inv/db linwin"
alias dbs="/in/local/inv/db sun"
alias dbh="/in/local/inv/db hp"
alias host="ypcat -k hosts | grep -i -w"
alias home="ypcat -k auto.home | grep -i -w"
alias ui="ypcat -k passwd | grep -i -w"
alias gr="ypcat -k group | grep -i -w"
alias topdu="du -sk ./* | sort -nr | head"
alias lin='db linux | grep -i'
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'
alias s=suspend
alias h=history
alias newxterm="xterm -bg black -fg green -fn 9x15bold &"
alias topr='top -b -i -n1'

if  [[ ! -z $ECHOENV ]]  ; then
    echo "senv => Setup environment for various software"
    echo "pss => Top ten swap using processes"
    echo "phone <search str> => Search phone database"
    echo "library <search str> => Search library"
    echo "host <machinename> => IP address of machine"
    echo "home <username> => Locate home directory of user"
    echo "topdu => Top ten disk space using directories"
fi
