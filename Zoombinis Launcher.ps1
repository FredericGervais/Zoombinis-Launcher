
$StatePath = "$($env:LOCALAPPDATA)\Packages\WD1EncoreSoftwareLLC.Zoombinis_935h8e1rcf9ej\LocalState"

# Find the latest save file
$LastSaveFile = Get-ChildItem $StatePath\* -Attributes Archive | Where-Object {$_.Length -gt 1024} | Sort-Object -Property LastWriteTime | Select-Object -Last 1

# If the last save file is not named "playerprefs.dat" rename it so that it is so
if ("playerprefs.dat" -ne $LastSaveFile.Name){
    if (Test-Path "$StatePath\playerprefs.dat" -PathType Leaf) {
        Remove-Item "$StatePath\playerprefs.dat"
    }
    Rename-Item -Path $LastSaveFile -NewName "playerprefs.dat"
}

# Remove the old save files
Get-ChildItem $StatePath\* -Include *.tmp -Attributes Archive | Remove-Item

Start-Process shell:AppsFolder\WD1EncoreSoftwareLLC.Zoombinis_935h8e1rcf9ej!App

