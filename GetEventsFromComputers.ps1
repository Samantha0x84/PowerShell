#quick script to find what computers have been impacted by an error with the EventID502

$computers = Import-Csv D:\computers.csv  -Delimiter ","

foreach ($computername in $computers) {

$co = $computername | select computername -ExpandProperty computername

write-host "attempting to pull logs from" $co

get-service -Name RemoteRegistry -ComputerName $co | Set-Service -Status Running -ErrorAction Ignore

Get-EventLog -LogName application -Newest 20 -ComputerName $co -EntryType Error | Where-Object {$_.EventID -eq 502} -ErrorAction Ignore
}
