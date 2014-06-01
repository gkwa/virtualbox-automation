delete_vm()
{
    VBoxManage list runningvms |
    cut -d\" -f2 |
    while read vm
    do
	if test "z$vm" = "z$vmname"
	then
	    VBoxManage controlvm "$vm" poweroff
	fi
    done

    VBoxManage list vms |
    cut -d\" -f2 |
    while read vm
    do
	if test "z$vm" = "z$vmname"
	then
	    VBoxManage unregistervm "$vmname" --delete
	fi
    done

    if test -s $hdd_abspath
    then
	VBoxManage -q closemedium disk "$hdd_abspath"
	VBoxManage -q closemedium disk "$hdd_abspath" --delete
	rm -f "$hdd_abspath"
    fi
}

download_devcon()
{
    if test ! -x devcon/i386/devcon.exe
    then
	wget -nv --timestamping http://download.microsoft.com/download/1/1/f/11f7dd10-272d-4cd2-896f-9ce67f3e0240/devcon.exe
	7z x -odevcon devcon.exe >/dev/null
	chmod -R 777 devcon
    fi
}
