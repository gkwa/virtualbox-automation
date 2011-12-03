vmname=wxp3

# ~/VirtualBox VMs/



ostype=Windows7
isopath = ~/Downloads/isos/win7/win7.iso

ostype=WindowsXP
isopath = ~/Downloads/isos/WinXP/xp.iso


t3: t1 ~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi configure
	vboxmanage storagectl $(vmname) --name "IDE Controller" --add ide
	vboxmanage storageattach $(vmname) --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi
#	 vboxmanage storagectl $(vmname) --name "SATA Controller" --add sata
#	 vboxmanage storageattach $(vmname) --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium $(isopath)
#	vboxmanage storagectl $(vmname) --name "IDE Controller" --add sata
	vboxmanage storageattach $(vmname) --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $(isopath)
	vboxmanage startvm $(vmname)

t3a: t3
	rm -rf /tmp/t3a
	find ~/VirtualBox\ VMs/$(vmname) -name "*.vdi" -prune -o -print | cpio -pamvd /tmp/t3a

info:
	vboxmanage showvminfo $(vmname)

t2: t1 	~/VirtualBox\ VMs/w7.1/w7.1.vdi
	$(show)
#	vboxmanage startvm $(vmname)
	vboxmanage showvminfo $(vmname)

.PHONY: t2

t1:
	-$(clean)
	-$(show)
.PHONY: t1




# vboxmanage createhd iso
# vboxmanage modifyvm boot disk

# vboxmanage createhd iso
# vboxmanage modifyvm boot disk
# vboxmanage storagectl "IDE Controller" add ide

# VBoxManage storagectl $(vmname) --name "IDE Controller" --add ide
# VBoxManage storageattach $(vmname) --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi
# VBoxManage storageattach $(vmname) --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ~/Downloads/isos/win7/win7.iso

hdd: ~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi
~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi: ~/VirtualBox\ VMs/$(vmname)/$(vmname).vbox
	vboxmanage createhd \
		--filename ~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi \
		--size 10000

configure: ~/VirtualBox\ VMs/$(vmname)/$(vmname).vbox
	vboxmanage modifyvm $(vmname) \
		--memory 868 \
		--acpi on \
		--usb on \
		--audio coreaudio \
		--mouse usbtablet \
		--boot1 dvd \
		--nic1 nat \
		--bridgeadapter1 eth0 \
		--vrdeport 3389
	vboxmanage modifyvm $(vmname) --pae off

.PHONY: configure

~/VirtualBox\ VMs/$(vmname)/$(vmname).vbox:
	vboxmanage createvm \
		--name $(vmname) \
		--ostype $(ostype) \
		--register

lo: list_ostypes
list_ostypes:
	vboxmanage list ostypes
.PHONY: list_ostypes
.PHONY: lo

manual: vmboxmanage.txt
vmboxmanage.txt:
	lynx -dump http://www.virtualbox.org/manual/ch08.html > vmboxmanage.txt

# google search "vboxmanage unregistervm delete" is not deleting my hard disk
# vboxmanage unregistervm delete

clean:
	$(clean)
.PHONY: clean

show:
	-$(show)
.PHONY: show

show = \
	find ~/VirtualBox\ VMs/$(vmname)

clean = \
	rm -f vmboxmanage.txt; \
	vboxmanage closemedium disk \
		~/VirtualBox\ VMs/$(vmname)/$(vmname).vdi \
		--delete; \
	vboxmanage unregistervm $(vmname) --delete
