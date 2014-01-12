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
