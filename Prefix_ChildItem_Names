#Append 0's to start of file names to make them compatible with Capita SIMs import.
#The photography company failed to do this (or their software culled leading 0's)

cd "D:\2016 All Student Photos"
$items = Get-ChildItem

foreach ($items in $items)
{
    if ($items.name.Length -eq 9) #if filename =5 (excluding the .bmp)
    {
    $NewName = "0"+ $items.Name 
    Rename-Item $items -NewName $NewName
    write-host $items "renamed to 000"$items.Name 
    }

    if ($items.name.Length -eq 8) #if filename =4 (excluding the .bmp)
    {
    $NewName = "00"+ $items.Name 
    Rename-Item $items -NewName $NewName
    write-host $items "renamed to 000"$items.Name 
    }


    if ($items.name.Length -eq 7) #if filename =3 (excluding the .bmp)
    {
    $NewName = "000"+ $items.Name 
    Rename-Item $items -NewName $NewName
    write-host $items "renamed to 000"$items.Name 
    }

    if ($items.name.Length -eq 6) #if filename =2 (excluding the .bmp)
    {
    $NewName = "0000"+ $items.Name 
    Rename-Item $items -NewName $NewName
    write-host $items "renamed to 000"$items.Name 
    }

        if ($items.name.Length -eq 5) #if filename =1 (excluding the .bmp)
    {
    $NewName = "00000"+ $items.Name 
    Rename-Item $items -NewName $NewName
    write-host $items "renamed to 000"$items.Name 
    }
} 
