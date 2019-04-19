$gitlatestversion = "2.21.0"
$url = "https://github.com/git-for-windows/git/releases/download/v$($gitlatestversion).windows.1/Git-$($gitlatestversion)-64-bit.exe"

#write-host $url

$status = git --version

if ($? -eq "True") {
		write-host "Git Already Installed, version is :" $status
	}
Else {
		write-host "Going to install Git"
		$Installer = "Git-$gitlatestversion-64-bit.exe"
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Invoke-WebRequest $url -OutFile $Path\$Installer
		Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer
		$env:Path += ";C:\Program Files\Git\bin\"
		$env:Path += ";C:\Program Files\Git\cmd\"
		$status = git --version
		write-host "Git Installed, version is :" $status
	}