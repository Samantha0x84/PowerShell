#Get Date with Get-Aduser example
get-aduser -searchbase "ou=foobar,dc=domain,dc=com" -Filter * -properties lastlogondate | where-object lastlogondate -lt (get-date -month 5) | select name, givenname, surname
