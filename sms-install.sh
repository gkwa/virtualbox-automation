set -e
set -x

vmname=xp


set +e
vboxmanage controlvm $vmname poweroff
set -e
vboxmanage snapshot $vmname restorecurrent
vboxmanage startvm $vmname

sleep 5
vboxmanage guestcontrol exec $vmname 'c:\windows\system32\cmd.exe' --username administrator --password "demo" --arguments '/c copy /y e:\sms-1.60-full-c65e194.exe c:\\'
sleep 5
vboxmanage guestcontrol exec $vmname 'c:\windows\system32\cmd.exe' --username administrator --password "demo" --arguments '/c c:\sms-1.60-full-c65e194.exe /S'
