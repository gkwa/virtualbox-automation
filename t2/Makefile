name=wxp3

# ~/VirtualBox VMs/



ostype=Windows7
isopath = ~/Downloads/isos/win7/win7.iso

ostype=WindowsXP
isopath = ~/Downloads/isos/WinXP/xp.iso


t3: t1 ~/VirtualBox\ VMs/$(name)/$(name).vdi configure
	vboxmanage storagectl $(name) --name "IDE Controller" --add ide
	vboxmanage storageattach $(name) --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$(name)/$(name).vdi
#	 vboxmanage storagectl $(name) --name "SATA Controller" --add sata
#	 vboxmanage storageattach $(name) --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium $(isopath)
#	vboxmanage storagectl $(name) --name "IDE Controller" --add sata
	vboxmanage storageattach $(name) --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $(isopath)
	vboxmanage startvm $(name)

t3a: t3
	rm -rf /tmp/t3a
	find ~/VirtualBox\ VMs/$(name) -name "*.vdi" -prune -o -print | cpio -pamvd /tmp/t3a

info:
	vboxmanage showvminfo $(name)

t2: t1 	~/VirtualBox\ VMs/w7.1/w7.1.vdi
	$(show)
#	vboxmanage startvm $(name)
	vboxmanage showvminfo $(name)

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

# VBoxManage storagectl $(name) --name "IDE Controller" --add ide
# VBoxManage storageattach $(name) --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$(name)/$(name).vdi
# VBoxManage storageattach $(name) --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ~/Downloads/isos/win7/win7.iso

hdd: ~/VirtualBox\ VMs/$(name)/$(name).vdi
~/VirtualBox\ VMs/$(name)/$(name).vdi: ~/VirtualBox\ VMs/$(name)/$(name).vbox
	vboxmanage createhd \
		--filename ~/VirtualBox\ VMs/$(name)/$(name).vdi \
		--size 20000

configure: ~/VirtualBox\ VMs/$(name)/$(name).vbox
	vboxmanage modifyvm $(name) \
		--memory 868 \
		--acpi on \
		--usb on \
		--audio coreaudio \
		--mouse usbtablet \
		--boot1 dvd \
		--nic1 nat \
		--bridgeadapter1 eth0 \
		--vrdeport 3389
	vboxmanage modifyvm $(name) --pae off

start:
	-vboxmanage controlvm $(name) poweroff
	vboxmanage startvm $(name)
.PHONY: start

tmp:add_tmp_mount
.PHONY: add_tmp_mount
add_tmp_mount:
	vboxmanage sharedfolder add $(name) --name tmp --hostpath /private/tmp --automount

.PHONY: configure

~/VirtualBox\ VMs/$(name)/$(name).vbox:
	vboxmanage createvm \
		--name $(name) \
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
	find ~/VirtualBox\ VMs/$(name)

clean = \
	rm -f vmboxmanage.txt; \
	vboxmanage closemedium disk \
		~/VirtualBox\ VMs/$(name)/$(name).vdi \
		--delete; \
	vboxmanage unregistervm $(name) --delete
