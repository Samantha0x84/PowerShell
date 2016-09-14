get-aduser  -Filter {Name -like "*iPads*"} ` 
-searchbase "ou=Users,ou=Objects,dc=mydomain,dc=co,dc=uk" `
| Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -AsPlainText "VAWw3v%$sd&" -force) -Reset
