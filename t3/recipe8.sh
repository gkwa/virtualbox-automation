set -o errexit
set -o nounset

MY_DIR=`dirname $0`
source $MY_DIR/recipe8_settings.sh
if [ $? -ne 0 ]
then
    $MY_DIR/recipe8_settings.sh exitted with nonzero exit status, quitting
    exit 1
fi
source $MY_DIR/common.sh

delete_vm "$vmname"
VBoxManage createhd --filename "$hdd_abspath" --size $hdd_size --format VDI
VBoxManage createvm --name "$vmname" --ostype $ostype --register
VBoxManage modifyvm "$vmname" --vram 80 # Fixes warning "Non-Optimal settings detected", 20 MB ram, set more for windows of course
VBoxManage modifyvm "$vmname" --memory 1500
VBoxManage modifyvm "$vmname" --acpi on
VBoxManage modifyvm "$vmname" --usb on
VBoxManage modifyvm "$vmname" --mouse usb
VBoxManage modifyvm "$vmname" --boot4 none
VBoxManage modifyvm "$vmname" --boot3 none
VBoxManage modifyvm "$vmname" --boot2 dvd
VBoxManage modifyvm "$vmname" --boot1 disk
VBoxManage modifyvm "$vmname" --clipboard bidirectional
VBoxManage modifyvm "$vmname" --draganddrop hosttoguest
VBoxManage modifyvm "$vmname" --ioapic on
VBoxManage modifyvm "$vmname" --pae on # I need this on.  It took me a long time to disover this PAE should be on
VBoxManage modifyvm "$vmname" --nic1 bridged \
    --bridgeadapter1 "$nic1_bridged_adapter" --nictype1 virtio
VBoxManage modifyvm "$vmname" --vcpenabled on

# #############################
# IDE Controller
# #############################
VBoxManage storagectl "$vmname" --name IDE --add ide

if test ! -z "$iso1"
then
    VBoxManage storageattach "$vmname" --storagectl IDE \
    	--port 0 --device 0 --type hdd --medium "$vmbasedir/$vmname.vdi"
fi

# #############################
# Sata Controller
# #############################
VBoxManage storagectl "$vmname" --name "SATA Controller" --add sata --portcount 3
VBoxManage storageattach "$vmname" --storagectl "SATA Controller" \
	--port 0 --device 0 --type dvddrive --medium "$iso1"







exit
















if test ! -z "$iso2"
then
    VBoxManage storageattach "$vmname" --storagectl "SATA Controller" \
	--port 1 --device 0 --type dvddrive --medium "$iso2"
fi

if test ! -z "$iso3"
then
    VBoxManage storageattach "$vmname" --storagectl "SATA Controller" \
	--port 2 --device 0 --type dvddrive --medium "$iso3"
fi
