$source = @"
using System;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Windows.Forms;
namespace KeySends
{
    public class KeySend
    {
        [DllImport("user32.dll")]
        public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);
        private const int KEYEVENTF_EXTENDEDKEY = 1;
        private const int KEYEVENTF_KEYUP = 2;
        public static void KeyDown(Keys vKey)
        {
            keybd_event((byte)vKey, 0, KEYEVENTF_EXTENDEDKEY, 0);
        }
        public static void KeyUp(Keys vKey)
        {
            keybd_event((byte)vKey, 0, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, 0);
        }
    }
}
"@
Add-Type -TypeDefinition $source -ReferencedAssemblies "System.Windows.Forms"
Function WinKey ($Key)
{
    [KeySends.KeySend]::KeyDown("LWin")
    [KeySends.KeySend]::KeyDown("ShiftKey")
    [KeySends.KeySend]::KeyDown("$Key")
    [KeySends.KeySend]::KeyUp("LWin")
    [KeySends.KeySend]::KeyUp("ShiftKey")
    [KeySends.KeySend]::KeyUp("$Key")
}

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

# Make the app full screen
Start-Sleep -Milliseconds 750
WinKey("Enter")
