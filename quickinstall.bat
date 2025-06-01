@echo off
setlocal enabledelayedexpansion

echo Enter the full path to the LOCKDOWN Protocol folder (e.g., D:\SteamLibrary\steamapps\common\LOCKDOWN Protocol):
set /p gameDir=

if not exist "%gameDir%" (
    echo The specified path does not exist.
    pause
    exit /b
)

set "win64Path=%gameDir%\LockdownProtocol\Binaries\Win64"
set "logicModsPath=%gameDir%\LockdownProtocol\Content\Paks\LogicMods"

if not exist "%logicModsPath%" (
    mkdir "%logicModsPath%"
)

set "ue4ssFolder="
for /d %%f in ("UE4SS-*") do (
    set "ue4ssFolder=%%f"
)
if defined ue4ssFolder (
    echo Copying UE4SS from !ue4ssFolder! to %win64Path%...
    xcopy "!ue4ssFolder!\*" "%win64Path%\" /E /I /Y
) else (
    echo UE4SS folder not found.
)

set "pppFolder="
for /d %%f in ("PlayerPlusPlus-*") do (
    set "pppFolder=%%f"
)
if defined pppFolder (
    echo Copying PlayerPlusPlus from !pppFolder! to %logicModsPath%...
    xcopy "!pppFolder!\*" "%logicModsPath%\!pppFolder!\" /E /I /Y
) else (
    echo PlayerPlusPlus folder not found.
)

set "gtmFolder="
for /d %%f in ("GhostTeleportMod-*") do (
    set "gtmFolder=%%f"
)
if defined gtmFolder (
    echo Copying GhostTeleportMod from !gtmFolder! to %logicModsPath%...
    xcopy "!gtmFolder!\*" "%logicModsPath%\!gtmFolder!\" /E /I /Y
) else (
    echo GhostTeleportMod folder not found.
)

echo All done.
echo Credit ~Kenz
pause
