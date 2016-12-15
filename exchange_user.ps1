if ($session.ComputerName -ne "pexc01.prioryacademies.co.uk")
{
Write-Host "Importing PSSession from pexc01"
$connectExchange = "http://pexc01.prioryacademies.co.uk/powershell"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $connectExchange -Authentication Kerberos
Import-PSSession $Session -ErrorAction silentlycontinue -Verbose
}
else
{
Write-Host "PSSession from pexc01 already imported \n"
}

Write-Host "Avaliable mailbox databases: "
$mailboxes = Get-MailboxDatabase | Select-Object Name -ExpandProperty Name
Echo "-------------" $mailboxes "-------------"
$username = Read-Host "Enter the username: "
$mailboxdatabase = "Enter the name of the mailbox: "

Enable-Mailbox -Identity $username -Database $mailboxdatabase
