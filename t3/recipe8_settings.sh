set -o errexit
set -o nounset

vmname=$(echo $0 | sed -e 's,_settings,,' -e 's,\.sh,,')
nic1_bridged_adapter="Intel(R) 82579V Gigabit Network Connection"

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
hdd_size=$((25*1000)) #GB
iso1=$(ls -1dt /c/MDTDStest* | head -1 | xargs -I@ find @ -iname "*.iso" | xargs ls -t | head -1 | xargs cygpath --mixed)
iso1=$(ls -1dt /c/media/MDTDStest* | head -1 | xargs -I@ find @ -iname "*.iso" | xargs cygpath --mixed)
iso2=c:/Program\ Files/Oracle/VirtualBox/VBoxGuestAdditions.iso
iso3=$virtio_net_iso_abspath
