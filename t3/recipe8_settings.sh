set -o nounset

MY_DIR=`dirname $0`
source $MY_DIR/common.sh

DATA_DRIVE=$(printenv DATA_DRIVE)
if test -z "$DATA_DRIVE"
then
    echo "set DATA_DRIVE environment variable first (eg DATA_DRIVE=D:)"
    exit 1
fi

vmname=$(echo $0 | sed -e 's,_settings,,' -e 's,\.sh,,')
download_devcon
nic1_bridged_adapter=$(devcon/i386/devcon.exe hwids =net PCI\\VEN* | sed -ne '/Name:/{s,^[[:blank:]]*Name: ,,;p;q;}')

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
vmbasedir=$DATA_DRIVE/vbox/$vmname
hdd="$vmname.vdi"
hdd_abspath=$vmbasedir/$hdd
hdd_size=$((25*1000)) #GB
iso1=$(ls -1dt $DATA_DRIVE/MDTDS[Tt]est* | head -1 | xargs -I@ find @ -iname "*.iso" | xargs ls -t | head -1 | xargs cygpath --mixed)
iso2="`cygpath --mixed "$(cygpath -u -F 42)/Oracle/VirtualBox/VBoxGuestAdditions.iso"`"
iso3=$virtio_net_iso_abspath
