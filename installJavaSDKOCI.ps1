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
}