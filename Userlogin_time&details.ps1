# Copy paste this scrpt to the server.
# In one windows server, we have multiple users login. The scenario is a traing machine. We want to know how many users login to the server.
# Here you need to change the value from 4 to the one which you want
$startDate = (get-date).AddDays(-4)

# Store successful logon events from security logs with the specified dates and workstation/IP in an array
#foreach ($DC in $DCs){
$slogonevents = Get-Eventlog -LogName Security -ComputerName EC2AMAZ-VGJGQTC  -after $startDate | where {$_.eventID -eq 4624 }

# Crawl through events; print all logon history with type, date/time, status, account name, computer and IP address if user logged on remotely

  foreach ($e in $slogonevents){
    # Logon Successful Events
       # Remote (Logon Type 10)
    if (($e.EventID -eq 4624 ) -and ($e.ReplacementStrings[8] -eq 10)){
      write-host "Type: Remote Logon`tDate: "$e.TimeGenerated "`tStatus: Success`tUser: "$e.ReplacementStrings[5] "`tWorkstation: "$e.ReplacementStrings[11] "`tIP Address: "$e.ReplacementStrings[18]
    }}