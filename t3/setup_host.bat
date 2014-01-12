set PATH=c:\Program Files\Oracle\VirtualBox;%PATH%

cmd /c setx.exe -m DATA_DRIVE C:
cmd /c mkdir %DATA_DRIVE%\vbox
cmd /c VBoxManage setproperty machinefolder %DATA_DRIVE%\vbox
pause
