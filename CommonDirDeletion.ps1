# This is designed to delete files common to every home directory in the event that old cached data needs to be purged



#start of the file path
$string1 = "\\mydomain.com\example\users\"

#end of the file path
$string2 = "\SettingsPackages\MicrosoftInternetExplorer.Version11"

#middle of the file path
$users = get-aduser -Filter { enabled -eq 'true'} -SearchBase "ou=department_name,ou=users,ou=Company Objects,dc=mydomain,dc=com" | select -expandproperty samaccountname

#join the strings and delete the item
foreach ($element in $users) {Remove-Item -Recurse -force $string1$element$string2}

