# Very simple script. 
# The purpose for this is that, on very rare occasions, users won't get their home directory applied for any number of reasons. 
# E.g. the file server isn't available 
# This script loads up a list of all the server desktops we run from a csv, then checks the local user area which Windows reverts to by default. 

$username = Read-Host "enter the username: "
cd $PSScriptRoot
$servers = Import-Csv .\serverList.csv | Select-Object Name -ExpandProperty Name


foreach ($servers in $servers) {
$Filepath = "\\"+$servers+"\c$\users\"+$username
Get-ChildItem $Filepath -ErrorAction SilentlyContinue

}

