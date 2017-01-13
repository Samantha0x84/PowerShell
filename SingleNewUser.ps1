#single new user - intended to do everything that'd be done if I were to use the copy user function in the active directory console.

cd $PSScriptRoot

#Prompt for basic details
$name  = Read-Host "Account Name: "
$givenName     = Read-Host "Given Name: "
$surname       = Read-Host "Surname: "
$yearGroup     = Read-Host "Year Group (e.g. 218): "
$academySelect = Read-Host "w/l/r/p: "
$randomPassword= Read-Host "Randomly generate password? y/n: "

$samAccountName= $name+"@mydomain.co.uk"

#HomeDirectory
$homedir1 ="\\mydomain.co.uk\"
$homedir2 ="\students\"

#find and make the OU path + make homedir path + description
if ($academySelect = "w")
{
$pathStart = "OU=FooBar Delta Academy,OU=Students,OU=Users,OU=Federation Objects,DC=mydomain,DC=co,DC=uk"
$homedir = $homedir1+"Delta"+$homedir2+$yearGroup+"\"+$name
$description = "Student - The FooBar Delta Academy"
}
elseif ($academySelect = "l")
{
$pathStart = "OU=FooBar Gamma Academy,OU=Students,OU=Users,OU=Federation Objects,DC=mydomain,DC=co,DC=uk"
$homedir = $homedir1+"Lincoln"+$homedir2+$yearGroup+"\"+$name
$description = "Student - The FooBar City of LincolnAcademy"
}
elseif ($academySelect = "r")
{
$pathStart = "OU=FooBar Alpha Academy,OU=Students,OU=Users,OU=Federation Objects,DC=mydomain,DC=co,DC=uk"
$homedir = $homedir1+"Alpha"+$homedir2+$yearGroup+"\"+$name
$description = "Student - The FooBar Alpha Academy"
}
elseif ($academySelect = "p")
{
$pathStart = "OU=FooBar Academy Beta,OU=Students,OU=Users,OU=Federation Objects,DC=mydomain,DC=co,DC=uk"
$homedir = $homedir1+"FooBar"+$homedir2+$yearGroup+"\"+$name
$description = "Student - The FooBar Academy Beta"
}
else {Write-Host -BackgroundColor Red "invalid selection"}
$path = "OU="+$yearGroup+","+$pathStart

#Get a template of groups from an existing user
$groupTemplate = get-aduser -filter * -searchbase $path  –Properties MemberOf | Select-Object -first 1 | Get-ADPrincipalGroupMembership | Select-Object name


#Password generation
if ($randomPassword = "y") {
    $wordList1 = import-csv .\wordlist.csv | Select-Object Words -ExpandProperty Words | get-random
    $wordList2 = import-csv .\wordlist.csv | Select-Object Words -ExpandProperty Words | get-random
    $number1 = Get-Random -minimum 0 -maximum 9
    $number2 = Get-Random -minimum 0 -maximum 9
    $number3 = Get-Random -minimum 0 -maximum 9
    $newPassword = "$wordList1$wordList2$number1$number2$number3"
    write-host "new password: " $newPassword
    $password = $newPassword 
}

else {
$password = Read-Host "enter a password: "
}


#Make the user

New-ADUser -Name $name `
-AccountPassword (ConvertTo-SecureString -AsPlainText $password -force) `
-GivenName $givenName `
-Surname   $surname `
-SamAccountName $samAccountName `
-DisplayName $name `
-HomeDrive U:\ `
-HomeDirectory $homedir `
-Description $description 



#Add to groups
$lc=0
foreach ($groupTemplate in $groupTemplate)
{Write-Host $lc". Addeding to group: "$groupTemplate
Add-ADPrincipalGroupMembership -Identity $Name -MemberOf $groupTemplate
$lc++
}

#####
#TO DO: HOME DIR PERMISSIONS
#####

#Make exchange mailbox
$makeMailBox = Read-Host "Make a mailBox for this user? y/n" 
if ($makeMailBox = "y"){

    if ($session.ComputerName -ne "exc01.mydomain.co.uk")
        {
        Write-Host "Importing PSSession from pexc01"
        $connectExchange = "http://exc01.mydomain.co.uk/powershell"
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
    $mailboxdatabase = Read-Host "Enter the name of the mailbox "

    Enable-Mailbox -Identity $name -Database $mailboxdatabase




}
else {
write-host -BackgroundColor red "Mail box creation skipped" }
