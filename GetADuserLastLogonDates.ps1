# Made so we can find who hasn't logged on since when.

#FileSave dialog
Function Set-Filename
# Set file name for saving export
{
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.Filter = "Text files (*.txt)|*.txt"
   
    $SaveFileDialog.initialDirectory = "c:\"
    
    if ($SaveFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK)
    { $SaveFileDialog.FileName }
}

# Date Picker picker UI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object Windows.Forms.Form 
$form.Text = "Select a Date" 
$form.Size = New-Object Drawing.Size @(243,230) 
$form.StartPosition = "CenterScreen"
$calendar = New-Object System.Windows.Forms.MonthCalendar 
$calendar.ShowTodayCircle = $False
$calendar.MaxSelectionCount = 1
$form.Controls.Add($calendar) 
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(38,165)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(113,165)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$form.Topmost = $True

$result = $form.ShowDialog() 

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $date = $calendar.SelectionStart

    # Get the users
    $SiteXstudents   = "OU=SiteA Academy,OU=Students,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteYstudents   = "OU=SiteB Academy ,OU=Students,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteZstudents   = "OU=SiteY Academy,OU=Students,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteAstudents  = "OU=SiteZ Academy,OU=Students,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $allstudents      = "OU=Students,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"

    $SiteXstaff      = "OU=SiteA Academy,OU=Staff,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteYstaff      = "OU=SiteB Academy ,OU=Staff,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteZstaff      = "OU=SiteY Academy,OU=Staff,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $SiteAstaff     = "OU=SiteZ Academy,OU=Staff,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
    $allstaff         = "OU=Staff,OU=Users,OU=Org Objects,DC=domain,DC=co,DC=uk"
 

 write-host -BackgroundColor DarkRed  "                       "
 write-host -BackgroundColor DarkBlue "   1. SiteA Students  "
 write-host -BackgroundColor DarkCyan "   2. SiteB Students  "
 write-host -BackgroundColor DarkBlue "   3. SiteY Students  "
 write-host -BackgroundColor DarkCyan "   4. SiteZ Students "
 write-host -BackgroundColor DarkBlue "   5. All Students     "
 write-host -BackgroundColor DarkCyan "   6. SiteA Staff     "
 write-host -BackgroundColor DarkBlue "   7. SiteB Staff     "
 write-host -BackgroundColor DarkCyan "   8. SiteY Staff     "
 write-host -BackgroundColor DarkBlue "   9. SiteZ Staff    "
 write-host -BackgroundColor DarkCyan "   10. All Staff       "
 write-host -BackgroundColor DarkRed  "                       "
 $Selection = Read-Host "select an OU (pick a number): "

 if ($Selection -eq 1) {$ou = $SiteAstudents}
  elseif ($Selection -eq 2) {$ou = $SiteBstudents}
   elseif ($Selection -eq 3) {$ou = $SiteYstudents}
    elseif ($Selection -eq 4) {$ou = $SiteZstudents}
     elseif ($Selection -eq 5) {$ou = $allstudents}
      elseif ($Selection -eq 6) {$ou = $SiteAstaff}
       elseif ($Selection -eq 7) {$ou = $SiteBstaff}
        elseif ($Selection -eq 8) {$ou = $SiteYstaff}
         elseif ($Selection -eq 9) {$ou = $SiteZstaff}
          elseif ($Selection -eq 10) {$ou = $allstaff}
 else {write-host "invalid selection"}
 
    $DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
    $exportname = $DesktopPath+"\lastlogondates.csv"
    $export = Read-Host "Export to CSV? y/n "
    
     get-aduser -searchbase $ou -Filter {Enabled -eq $true} -properties lastlogondate  | where-object lastlogondate -lt (get-date $date -hour 0 )| select samaccountname, givenname, surname, lastlogondate | Sort-Object lastlogondate
    if ($export = "y")
    {
     get-aduser -searchbase $ou -Filter {Enabled -eq $true} -properties lastlogondate  | where-object lastlogondate -lt (get-date $date -hour 0 )| select samaccountname, givenname, surname, lastlogondate | Sort-Object lastlogondate | Export-Csv $exportname 
    }


}
