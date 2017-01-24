#We have "controlled assessment" accounts for students. However whoever set up these accounts didn't include any first names or surnames.
#Luckly the controlled assment accounts are named the same as their usual accounts, just with a prefix of "CA"
#This script references their normal account and pulls off their names.


$normalAccount = get-aduser -searchbase "OU=212,OU=Some Academy,OU=Students,OU=Users,OU=Some OU,DC=mydomain,DC=co,DC=uk" | select samaccountname

foreach ($normalAccount in $normalAccount)
{
$givenname    = get-aduser $normalAccount  | select givenname -ExpandProperty givenname
$surname      = get-aduser $normalAccount  | select surname -ExpandProperty surname
$examAccount  = $normalAccount | select samaccountname -ExpandProperty samaccountname
$examAccount  = "CA"+$examAccount

Set-ADUser -Identity $examAccount -Surname $surname -GivenName $givenname

write-host -BackgroundColor DarkRed -ForegroundColor White "`n" $userToUpdate "`n" $surname "`n"  $givenname "`n"
write-host "-------------------------- `n"

}
