get-adobject -searchbase "CN=Deleted Objects, DC=mydomain, DC=com" -IncludeDeletedObjects -Filter {name -like "[GivenName Surname]*"} -Properties * | Restore-ADObject -TargetPath "ou=off
ice clerks,ou=users,ou=my company,dc=mydomain,dc=com" -NewName "[GivenName Surname]"
