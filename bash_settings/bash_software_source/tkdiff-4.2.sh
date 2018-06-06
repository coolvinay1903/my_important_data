 #!/bin/bash
 pack=/in/tcl/tkdiff/4.2
 if  [[  `uname` == Linux  ]]  ; then
     export PATH=$pack:$PATH
 else
     echo "TKDIFF 4.2 can be sourced for Linux machines"
     exit 0
 fi
