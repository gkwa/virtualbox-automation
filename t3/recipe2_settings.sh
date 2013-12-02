vmname=t10
nic1_bridged_adapter="Intel(R) 82579V Gigabit Network Connection"

wget -nc http://alt.fedoraproject.org/pub/alt/virtio-win/latest/images/virtio-win-0.1-74.iso

ostype=Windows7
vmbasedir=d:/vbox/$vmname
hdd="$vmname.vdi"
hdd_abspath=$vmbasedir/$hdd
hdd_size=$((100*1000)) #GB
iso1=c:/Program\ Files/Oracle/VirtualBox/VBoxGuestAdditions.iso
iso2=$(cygpath --mixed $(pwd)/virtio-win-0.1-74.iso)
iso3=
