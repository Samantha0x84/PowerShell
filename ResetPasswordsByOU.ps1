#password generator v0.1
#ToDo: Export results to CSV
#Using numbers 1-5 only due to the passwords being for children under 8

cd $PSScriptRoot

$Users = get-aduser -filter * -searchbase "ou=example,dc=mydomain,dc=com" 

$lc=0

foreach ($Users in $users){

$wordList = import-csv .\wordlist.csv | Select-Object Words -ExpandProperty Words | get-random
$number1 = Get-Random -minimum 1 -maximum 5
$number2 = Get-Random -minimum 1 -maximum 5
$number3 = Get-Random -minimum 1 -maximum 5


$newPassword = "$wordList$number1$number2$number3"


$usernames = $Users | Select-Object samaccountname -ExpandProperty samaccountname
$givenames = $Users | Select-Object givenname -ExpandProperty givenname
$surnames = $Users | Select-Object surname -ExpandProperty surname


write-host $givenames "," $surnames "," $usernames "," $newPassword

Set-ADAccountPassword -Identity $Users -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -force) -Reset



$lc += 1
}
