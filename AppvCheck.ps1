#Simple script to check if appv package is being deployed to clients

$simsPath = "\c$\ProgramData\App-V\DC224736-BBA2-438D-B71E-B96C7A3A0EDE\23A7D3BE-F375-4659-B639-F7F4D23B145C\"
$prePath = "\\"
$computers = Get-ADComputer -Filter * -SearchBase "<OU=example,DC=domain,DC=co,DC=uk>" | Sort-Object name | select name -ExpandProperty name
$compiledPath= $prepath+"WA21"+$simsPath
$MissingArray = [System.Collections.ArrayList]@()
$missingSimsCount = 0
Write-Host "`n `n `n `n `n `n"
foreach ($computers in $computers) { 
    $isOnTest = Test-NetConnection $computers -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | select pingSucceeded
    if ($isOnTest.PingSucceeded -eq $true) {
         $compiledPath=$prepath+$computers+$simsPath
         $simsCheck = Get-ChildItem $compiledPath -ErrorAction Ignore -WarningAction Ignore
         if ($simsCheck.Name.Length -gt 0)  {
               Write-Host " ----- AppV Sims Package Data is Present on: " $computers " ----" -BackgroundColor DarkGreen -ForegroundColor white
         }
         else {
          Write-Host " !!!!! AppV Sims Package Data is Missing on:" $computers " !!!!!" -BackgroundColor Red
          $missingSimsCount++
          $MissingArray.Add($computers) | Out-Null
        }
    }
    else { 
    Write-Host " -----            " $computers "is offline" "             ----"  -BackgroundColor DarkMagenta
    $offline++
    }
}
write-host "`n                                                        " -BackgroundColor black
Write-Host "sims is missing from " $missingSimsCount " computers." $MissingArray -BackgroundColor White -ForegroundColor Black
write-host "                                                        " -BackgroundColor black
Read-Host "press any key to quit"
