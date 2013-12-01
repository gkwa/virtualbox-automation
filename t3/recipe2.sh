set -o errexit
set -o nounset

MY_DIR=`dirname $0`
source $MY_DIR/recipe2_settings.sh

set +o errexit #when vmname doesn't exist
VBoxManage controlvm "$vmname" poweroff 2>/dev/null
VBoxManage unregistervm "$vmname" --delete 2>/dev/null
set -o errexit

VBoxManage createvm --name "$vmname" --ostype $ostype --register
VBoxManage createhd --filename "$vmbasedir/$vmname.vdi" --size $hdd_size --format VDI
VBoxManage modifyvm "$vmname" --memory 1500
VBoxManage modifyvm "$vmname" --acpi on
VBoxManage modifyvm "$vmname" --usb on
VBoxManage modifyvm "$vmname" --mouse usbtablet
VBoxManage modifyvm "$vmname" --boot4 none
VBoxManage modifyvm "$vmname" --boot3 none
VBoxManage modifyvm "$vmname" --boot2 dvd
VBoxManage modifyvm "$vmname" --boot1 disk
VBoxManage modifyvm "$vmname" --clipboard bidirectional
VBoxManage modifyvm "$vmname" --draganddrop hosttoguest
VBoxManage modifyvm "$vmname" --nic1 bridged --bridgeadapter1 "$nic1_bridged_adapter"
VBoxManage modifyvm "$vmname" --ioapic on

# I need this on.  It took me a long time to disover this PAE should be on
VBoxManage modifyvm "$vmname" --pae on


# #############################
# IDE Controller
# #############################
VBoxManage storagectl "$vmname" --name IDE --add ide

if test ! -z "$iso1"
then
    VBoxManage storageattach "$vmname" --storagectl IDE \
	--port 0 --device 0 --type dvddrive --medium "$iso1"
fi

#VBoxManage storageattach "$vmname" --storagectl IDE \
#    --port 1 --device 0 --type dvddrive --medium emptydrive

# #############################
# Sata Controller
# #############################
VBoxManage storagectl "$vmname" --name "SATA Controller" --add sata
VBoxManage storageattach "$vmname" --storagectl "SATA Controller" \
    --port 0 --device 0 --type hdd --medium "$vmbasedir/$vmname.vdi"

if test ! -z "$iso2"
then
    VBoxManage storageattach "$vmname" --storagectl "SATA Controller" \
	--port 1 --device 0 --type dvddrive --medium "$iso2"
fi
