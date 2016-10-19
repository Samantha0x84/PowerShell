#This was made to be used by another technician who doesn't know powershell.
#He was asked to bulk upload some 1000+ files to SharePoint but some of the characters were invalid and had to be replaced.

Add-Type -AssemblyName Microsoft.VisualBasic

$welcomebox = Read-MessageBoxDialog -WindowTitle "PowerShell File Name Fixer" -Message "This tool is to replace characters in all filesnames contained within a folder and all subfolders. Press OK to continue"
$directoryPath = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the directory path') 
$CharacterToReplace = [Microsoft.VisualBasic.Interaction]::InputBox('Type the character you wish to replace')
$ReplacementCharacter = [Microsoft.VisualBasic.Interaction]::InputBox('Replace with what character?') 

Get-ChildItem $directoryPath -Recurse | Where-Object {$_.Name -match $CharacterToReplace } | rename-Item -NewName { $_.Name -replace $CharacterToReplace, $ReplacementCharacter}
