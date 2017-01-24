#We have "controlled assessment" accounts for students. However whoever set up these accounts didn't include any first names or surnames.
#Luckly the controlled assment accounts are named the same as their usual accounts, just with a prefix of "CA"
#This script references their normal account and pulls off their names.


$normalAccount = get-aduser -searchbase "OU=212,OU=Some Academy,OU=Students,OU=Users,OU=Some OU,DC=mydomain,DC=co,DC=uk" | select samaccountname

foreach ($normalAccount in $normalAccount)
{
$examAccount  = $normalAccount | select samaccountname -ExpandProperty samaccountname
$givenname    = get-aduser $examAccount  | select givenname -ExpandProperty givenname
$surname      = get-aduser $examAccount  | select surname -ExpandProperty surname
$examAccount  = "CA"+$examAccount
$userToUpdate = get-aduser -filter {name -like $examAccount} | select samaccountname -ExpandProperty samaccountname

Set-ADUser -Identity $userToUpdate -Surname $surname -GivenName $givenname

write-host -BackgroundColor DarkRed -ForegroundColor White "`n" $userToUpdate "`n" $surname "`n"  $givenname "`n"
write-host "-------------------------- `n"

}
