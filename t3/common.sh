delete_vm()
{
    vboxmanage list vms |
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

    vboxmanage list runningvms |
    cut -d\" -f2 |
    while read vm
    do
	if test "z$vm" = "z$vname"
	then
	    VBoxManage controlvm "$vm" poweroff
	fi
    done
}
