# How to rn -  .\installTerraform.ps1
$tflatestversion = "0.11.13"
$status = terraform -v

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
