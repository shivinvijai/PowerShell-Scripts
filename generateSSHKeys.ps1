write-host "Generate Keys"
$PRIVATE_KEY="$PSScriptRoot\DEMO_NAME.key"
$PUBLIC_KEY="$PSScriptRoot\DEMO_NAME.key.pub"
write-host $PRIVATE_KEY
ssh-keygen -t rsa -b 4096 -f $PRIVATE_KEY -q -P """"
write-host "Generated SSH Keys"