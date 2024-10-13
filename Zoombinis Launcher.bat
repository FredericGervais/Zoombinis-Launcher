

SET mypath=%~dp0
SET launcher=%mypath:~0,-1%\%~n0.ps1
echo %launcher%

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%launcher%'"
