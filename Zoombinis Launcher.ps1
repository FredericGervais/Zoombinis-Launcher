
$StatePath = "$($env:LOCALAPPDATA)\Packages\WD1EncoreSoftwareLLC.Zoombinis_935h8e1rcf9ej\LocalState"


if (Test-Path "$StatePath\playerprefs.dat" -PathType Leaf) {
    # The Save file is fine
} else {
    $LastSaveFile = Get-ChildItem $StatePath\* -Include *.tmp | Select-Object -Last 1
    Rename-Item -Path $LastSaveFile -NewName "playerprefs.dat"
    Get-ChildItem $StatePath\* -Include *.tmp | Remove-Item
}

Start-Process shell:AppsFolder\WD1EncoreSoftwareLLC.Zoombinis_935h8e1rcf9ej!App

