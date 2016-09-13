get-aduser  -Filter {Name -like "*iPads*"} ` 
-searchbase "ou=System,ou=Users,ou=witham,ou=Federation Objects,dc=prioryacademies,dc=co,dc=uk" `
| Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -AsPlainText "VAWw3v%$sd&" -force) -Reset
