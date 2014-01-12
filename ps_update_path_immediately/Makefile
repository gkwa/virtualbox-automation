test:
	mkdir -p 'c:\windows\temp\test'
#	powershell -ExecutionPolicy unrestricted -file env-path-permanently.ps1 'c:\windows\temp\test' true
	powershell -ExecutionPolicy unrestricted -file env-path-permanently.ps1 'c:\windows\temp\test1'

check:
	reg query 'hkcu\environment' /v PATH | tr ';' '\\n'
	cmd /c reg query 'HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
