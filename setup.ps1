write-host ""
write-host "###################################################"
write-host "# Setting up Java and OCI environments in Windows #"
write-host "###################################################"
write-host ""

$tflatestversion = "0.11.13"
$status = terraform -v

#Write-Host $output

if ($? -eq "True") {
		write-host "Terraform Already Installed, version is :" $status
	}
Else {
		write-host "Going to install Terraform"
		$url = "https://releases.hashicorp.com/terraform/$tflatestversion/terraform_$($tflatestversion)_windows_amd64.zip"
		$output = "$PSScriptRoot\terraform_$($tflatestversion)_windows_amd64.zip"
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Invoke-WebRequest -Uri $url -OutFile $output
		expand-archive -path terraform_$($tflatestversion)_windows_amd64.zip -destinationpath 'terraform'
		$env:Path += ";$PSScriptRoot\terraform"
		$status = terraform -v
		write-host "Terraform Installed, version is :" $status
	}
	
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

$fpath = "$PSScriptRoot\oci-java-sdk.zip"
$isfile = Test-Path $fpath
if($isfile -eq "True") {
	write-host "OCI SDK for Java Exists"
}
Else {
	write-host "Going to install OCI SDK for Java"
	$ocisdkversion = "1.5.0"
	$url = "https://github.com/oracle/oci-java-sdk/releases/download/v$($ocisdkversion)/oci-java-sdk.zip"
	$output = "$PSScriptRoot\oci-java-sdk.zip"
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	Invoke-WebRequest -Uri $url -OutFile $output
	expand-archive -path oci-java-sdk.zip -destinationpath 'oci-java-sdk'
	write-host "OCI SDK for Java Installed"
}

	
write-host "Generate Keys"
$PRIVATE_KEY="$PSScriptRoot\DEMO_NAME.key"
$PUBLIC_KEY="$PSScriptRoot\DEMO_NAME.key.pub"
write-host $PRIVATE_KEY
ssh-keygen -t rsa -b 4096 -f $PRIVATE_KEY -q -P """"
write-host "Generated SSH Keys"

write-host ""
write-host "##############################"
write-host "# ENVIRONMENT SETUP COMPLETE #"
write-host "##############################"
write-host ""