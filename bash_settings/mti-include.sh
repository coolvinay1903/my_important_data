######Setting up PATH ######

pa=`echo ${PATH} | sed -e 's/\/in\/modeltech_[0-9].[0-9a-zA-Z]*\/bin//g' | sed -e 's/\/in\/questasim_[0-9].[0-9a-zA-Z]*\/bin//g' | sed -e 's@/u/release/[0-9].[0-9a-zA-Z]*/modeltech/bin@@' | sed -e 's@/u/release/[0-9]*.[0-9a-zA-Z_]*/questasim/bin@@'|sed -e 's@/u/release/[0-9][0-9]*.[0-9a-zA-Z_]*/questasim/bin@@'|sed -e 's@/in/release1/[0-9][0-9]*.[0-9a-zA-Z_].*/questasim/bin@@'`
unset PATH
unset path
export PATH=$pa:$MGC_HOME/bin

###### Setting up LM_LICENSE_FILE ######

if [[ ! -z $LM_LICENSE_FILE ]]  ; then
    LM1=`echo $LM_LICENSE_FILE | sed -e 's/\/LICENSES\/mti.ferrari//g' | sed -e 's/\/LICENSES\/mgc.innnis1//g'`
    LM=`echo $LM1 | sed -e 's@/LICENSES/mgc.innnis2/@@g'| sed -e 's/^://' | sed -e 's/:$//g' | sed -e 's/:*//'`
    unset LM_LICENSE_FILE
    unset LM_LICENSE_FILE
    export LM_LICENSE_FILE=$LM

    if  [[ `echo $LM | /usr/bin/wc -m` > 3 ]] ; then
        export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2:$LM_LICENSE_FILE
    else
        export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2
    fi
else
    export LM_LICENSE_FILE=/LICENSES/mgc.innnis1:/LICENSES/mgc.innnis2
fi

echo MGC_HOME $MGC_HOME
echo MGC_TMPDIR $MGC_TMPDIR
echo MGC_CVE_LOG $MGC_CVE_LOG
unset pa LM LM1
