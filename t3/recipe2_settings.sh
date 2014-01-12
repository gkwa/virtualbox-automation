set -o errexit
set -o nounset


vmname=$(echo $0 | sed -e 's,_settings,,' -e 's,\.sh,,')
# nic1_bridged_adapter="Intel(R) 82579V Gigabit Network Connection"
nic1_bridged_adapter="Citrix PV Ethernet Adapter #0"

basedir=$(pwd)
if test "z$(uname -s | grep -i cygwin)" != z
then
    basedir=$(cygpath --mixed -w "$(pwd)")
fi

virtio_net_version=0.1-74
virtio_net_iso=virtio-win-${virtio_net_version}.iso
virtio_net_iso_abspath=$basedir/$virtio_net_iso

wget -nv --timestamping http://alt.fedoraproject.org/pub/alt/virtio-win/latest/images/$virtio_net_iso

ostype=Windows7
vmbasedir=d:/vbox/$vmname
hdd="$vmname.vdi"
hdd_abspath=$vmbasedir/$hdd
hdd_size=$((100*1000)) #GB
iso1=c:/Users/Administrator/Downloads/mdt/win7_pro_oem.iso
iso1=$DATA_DRIVE/ds/Boot/LiteTouchPE_x86.iso
iso1=c:/Users/Administrator/Documents/v0.1-369-g2a6b4d0.iso
iso2=c:/Program\ Files/Oracle/VirtualBox/VBoxGuestAdditions.iso
iso3=$virtio_net_iso_abspath
