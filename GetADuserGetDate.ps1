#Get Date with Get-Aduser example
get-aduser -seachbase "ou=foobar,dc=domain,dc=com" -Filter * -properties lastlogondate | where-object lastlogondate -lt (get-date -month 5) | select name, givenname, surname
