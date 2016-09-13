#Import modules from the exchange server
$connectExchange = "http://server.domain.co.uk/powershell"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $connectExchange -Authentication Kerberos
Import-PSSession $Session -ErrorAction silentlycontinue -Verbose


#Get a list of MailBox databases
Get-MailboxDatabase

#Make the mailbox
Enable-Mailbox -Identity [foobar] -Database [foobar]

