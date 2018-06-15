#/bin/bash
old_ld_path=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress//rtlc/rtlcLib:/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress//lib/linux_el30_gnu45:/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress//lib/linux64_el30_gnu620:/in/tbx1/rtlc_behavc_builds/tbx_1703/package/TestBench-Xpress//lib/linux64_el30_gnu472:/usr/lib:/usr/local/lib:/usr/lib64:/usr/local/lib64
rc=`/in/scmtools/Linux3/bin/ikoscrypt_new -key "HJ-&en*A@KL2" -decrypt $1`
if [[ `echo $rc|grep -c -w Error ` > 0  ]]; then
    rc1=`/home/tbx/CRYPT/ikoscrypt -key "HJ-&en*A@KL2" -decrypt $1`
    if [[ `echo $rc1|grep -c -w Error ` > 0  ]]; then
        rc2=`/home/tbx/CRYPT/ikoscrypt -emul_platform D3 -key "HJ-&en*A@KL2" -decrypt $1`
        if [[ `echo $rc2|grep -c -w Error ` > 0  ]]; then
            rc3=`/home/angoyal/Precise_1703 -enfile $1 -dcfile $1.decrypt`
            if [[ `echo $rc3|grep -c -w "encrypted blowfish key" ` > 0  ]]; then
                rc4=`/in/inntbx9/tbx/vps/sandbox/builds/tbx_dev/src/rtlc/Applications/Decryptor/PreciseDecrypt -enfile $1 -dcfile $1.decrypt`
                if [[ `echo $rc4|grep -c "encrypted blowfish key"` > 0 ]]; then
                    echo "Error: Unable to decrypt file $1"
                else
                    echo "Successfully decrypted $1 to $1.decrypt"
                fi
            else
                echo "Successfully decrypted $1 to $1.decrypt"
            fi
        else
            echo "Successfully decrypted $1 to $1.decrypt"
        fi
    else
        echo "Successfully decrypted $1 to $1.decrypt"
    fi
else
    echo "Successfully decrypted $1 to $1.decrypt"
fi
export LD_LIBRARY_PATH=$old_ld_path
