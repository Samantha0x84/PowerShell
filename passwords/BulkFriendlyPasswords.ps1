# This script was made to generate friendly passwords for student users aged 6-11

cd $PSScriptRoot

# The users to target
$Users = get-aduser -filter * -searchbase "OU=Users,OU=Example.DC=myDomain,DC=co,DC=uk" 

$lc=0

foreach ($Users in $users){

#a csv containing a list of words - in this case it was kept to 3-4 character words due to the age of the students
$wordList = import-csv .\wordlist.csv | Select-Object Words -ExpandProperty Words | get-random

$number1 = Get-Random -minimum 1 -maximum 9
$number2 = Get-Random -minimum 1 -maximum 9
$number3 = Get-Random -minimum 1 -maximum 9


$newPassword = "$wordList$number1$number2$number3"


# Generate a list of the user's name and their password so it can be passed along to staff - could be improved by exporting to a csv or html

$usernames = $Users | Select-Object samaccountname -ExpandProperty samaccountname
$givenames = $Users | Select-Object givenname -ExpandProperty givenname
$surnames = $Users | Select-Object surname -ExpandProperty surname

write-host $givenames "," $surnames "," $usernames "," $newPassword


# Set the new password
Set-ADAccountPassword -Identity $Users -NewPassword (ConvertTo-SecureString -AsPlainText $newPassword -force) -Reset



$lc += 1
}
