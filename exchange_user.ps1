$connectExchange = "http://server.domain.co.uk/powershell"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $connectExchange -Authentication Kerberos
Import-PSSession $Session -ErrorAction silentlycontinue -Verbose

while ($continue -eq "y") {
#Make new mailbox
$identity = read-host "enter username: "
Get-MailboxDatabase
$database = read-host "enter database name: "
 
Enable-Mailbox -Identity $identity -Database $database
 
 
$continue = read-host "`n do another? y/n"
}