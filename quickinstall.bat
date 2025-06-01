@echo off
setlocal enabledelayedexpansion

set "defaultPath=C:\Program Files (x86)\Steam\steamapps\common\LOCKDOWN Protocol"

if exist "%defaultPath%" (
    set "gameDir=%defaultPath%"
    echo Found default game path: %gameDir%
) else (
    echo Default path not found.
    echo Enter the full path to the LOCKDOWN Protocol folder (e.g., D:\SteamLibrary\steamapps\common\LOCKDOWN Protocol):
    set /p gameDir=
    if not exist "%gameDir%" (
        echo The specified path does not exist.
        goto end
    )
)

set "win64Path=%gameDir%\LockdownProtocol\Binaries\Win64"
set "logicModsPath=%gameDir%\LockdownProtocol\Content\Paks\LogicMods"

if exist "%logicModsPath%" (
    echo Deleting old LogicMods folder...
    rmdir /S /Q "%logicModsPath%"
)
mkdir "%logicModsPath%"

set "ue4ssFolder="
for /d %%f in ("UE4SS-*") do (
    set "ue4ssFolder=%%f"
)
if not defined ue4ssFolder (
    echo Error: UE4SS folder not found.
    goto end
)
echo Copying UE4SS files...
xcopy "!ue4ssFolder!\*" "%win64Path%\" /E /I /Y
if errorlevel 1 (
    echo Error copying UE4SS files.
    goto end
)

set "pppFolder="
for /d %%f in ("PlayerPlusPlus-*") do (
    if exist "%%f\LogicMods\player++" (
        set "pppFolder=%%f\LogicMods\player++"
    )
)
if not defined pppFolder (
    echo Error: LogicMods\player++ folder not found.
    goto end
)
echo Copying player++ files...
xcopy "!pppFolder!\*" "%logicModsPath%\player++\" /E /I /Y
if errorlevel 1 (
    echo Error copying player++ files.
    goto end
)

set "gtmFolder="
for /d %%f in ("GhostTeleportMod-*") do (
    set "gtmFolder=%%f"
)
if not defined gtmFolder (
    echo Error: GhostTeleportMod folder not found.
    goto end
)
echo Copying GhostTeleportMod files...
xcopy "!gtmFolder!\*" "%logicModsPath%\GhostTeleportMod\" /E /I /Y
if errorlevel 1 (
    echo Error copying GhostTeleportMod files.
    goto end
)

echo All done.
echo Credit ~Kenz
:end
pause
