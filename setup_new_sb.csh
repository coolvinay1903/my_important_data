    #!/bin/csh -b
    set rel_path="/in/tbx1/rtlc_behavc_builds/"
    set rel_level=$1;
    set tbx_release_path="$rel_path/$rel_level/package/TestBench-Xpress/";
    set source_path="$rel_path/$rel_level/src/"
    set sandbox="$2_$rel_level";
    set curr_wd=`pwd -P`;
    set sandbox_top="$sandbox/$rel_level/tbx/src";
    set sandbox_pkg_top="$sandbox/$rel_level/tbx/packages"
    set debug=0;

    mkdir -p $sandbox_top;
    cd $sandbox_top;
    set sandbox_top=`pwd -P`;
    echo "Currently in `pwd -P`"
    cd $curr_wd
    echo "back to `pwd -P`"
    mkdir -p $sandbox_pkg_top;
    cd $sandbox_pkg_top;
    set sandbox_pkg_top=`pwd -P`;
    echo "Currently in `pwd -P`"

    #Setup a new TBX package in the source of sandbox
    /in/scmtools/x86_64/Linux4/bin/pbox -start $tbx_release_path $sandbox_pkg_top;
    cd $curr_wd
    echo "back to `pwd -P`"
    #Unlink stuff
    cd "$sandbox_pkg_top/TestBench-Xpress/"
    echo "Currently in `pwd -P`"
    /in/scmtools/x86_64/Linux4/bin/pbox rtlc/bin/linux64

    ## Now copy the source-code, build it and then link it to the tbx package
    cd $sandbox_top
    source /ENV/gcc-4.7.2
    echo "Currently in `pwd -P`"
    # Copy the source-code and start a release build
    if ( -d $source_path/behavc) then
	cp -prf $source_path/behavc behavc;
	ln -sf $source_path/LINKS . ;
	cd behavc/source;
	makefast.grid Support=behav;
	makefast.grid Support=rtl;
	if ( $debug == 1) then
		makefast.grid Optimize=debug Support=behav;
		makefast.grid Optimize=debug Support=rtl;
	endif
	cd -;
    endif
    if ( -d behavc ) then
	#Link the binaries from sandbox
	cd behavc/source/bin
	echo "Currently in `pwd -P`"
	set full_wd=`pwd -P`
	cd -
	echo "back to `pwd -P`"
       	ln -sf $full_wd/behavc_sis--linux-gcc472-64-vle-release $sandbox_pkg_top/TestBench-Xpress/rtlc/bin/linux64/behavc-vle
        ln -sf $full_wd/rtlc_sis--linux-gcc472-64-vle-release $sandbox_pkg_top/TestBench-Xpress/rtlc/bin/linux64/rtlc-vle
	ln -sf $full_wd/behavc_sis--linux-gcc472-64-vle-release $sandbox_pkg_top/TestBench-Xpress/rtlc/bin/linux64/postproc-vle
    endif
    # Copy the source-code and start a release build
    if ( -d $source_path/Driver.4.1 ) then
	cp -prf $source_path/Driver.4.1 Driver.4.1;
	cd Driver.4.1/source/;
	makefast.grid;
	if ( $debug == 1) then
		makefast.grid Optimize=debug;
	endif
	cd -;
    endif
    if ( -d Driver.4.1 ) then
	#Link the binaries from sandbox
	cd Driver.4.1/source_bin
	echo "Currently in `pwd -P`"
	set full_wd=`pwd -P`
	cd -
	echo "back to `pwd -P`"
	ln -sf $full_wd/rtlc-elaborate--linux-gcc472-64-vle-release $sandbox_pkg_top/TestBench-Xpress/rtlc/bin/linux64/rtlc-driver
    endif
    cd $curr_wd
    exit;
