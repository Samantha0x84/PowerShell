if ($session.ComputerName -ne "exchangeserver.mydomain.co.uk")
{
Write-Host "Importing PSSession from exchangeserver.mydomain.co.uk"
$connectExchange = "http://exchangeserver.mydomain.co.uk/powershell"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $connectExchange -Authentication Kerberos
Import-PSSession $Session -ErrorAction silentlycontinue -Verbose
}
else
{
Write-Host "PSSession from exchangeserver.mydomain.co.uk already imported \n"
}

Write-Host "Avaliable mailbox databases: "
Get-MailboxDatabase | Select-Object Name

$username = Read-Host "Enter the username: "
$mailboxdatabase = "Enter the name of the mailbox: "

Enable-Mailbox -Identity $username -Database $mailboxdatabase
