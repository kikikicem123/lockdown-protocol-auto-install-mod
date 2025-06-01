@echo off
setlocal enabledelayedexpansion

echo === Lockdown Protocol Mod Installer ===

set "installerDir=%cd%"
for %%i in ("%installerDir%") do set "gameDir=%%~dpi"
set "gameDir=%gameDir:~0,-1%"

if not exist "%gameDir%\LockdownProtocol\" (
    echo Error: Could not find LockdownProtocol folder in parent directory.
    echo Please put this installer folder inside the LOCKDOWN Protocol game folder.
    goto end
)

set "win64Path=%gameDir%\LockdownProtocol\Binaries\Win64"
set "paksPath=%gameDir%\LockdownProtocol\Content\Paks"
set "logicModsPath=%paksPath%\LogicMods"

if not exist "!win64Path!" (
    echo Error: Missing folder: !win64Path!
    goto end
)

if not exist "!paksPath!" (
    echo Error: Missing folder: !paksPath!
    goto end
)

set "ue4ssFolder="
for /d %%f in ("UE4SS-*") do (
    if exist "%%f\dwmapi.dll" if exist "%%f\ue4ss" (
        set "ue4ssFolder=%%f"
    )
)

if not defined ue4ssFolder (
    echo Error: UE4SS folder not found.
    goto end
)

echo Installing UE4SS from !ue4ssFolder!...
xcopy /Y "!ue4ssFolder!\dwmapi.dll" "!win64Path!\" >nul
rmdir /S /Q "!win64Path!\ue4ss" >nul 2>&1
xcopy /Y /E "!ue4ssFolder!\ue4ss" "!win64Path!\ue4ss\" >nul
if errorlevel 1 (
    echo Error: Failed to install UE4SS.
    goto end
)

if exist "!logicModsPath!" (
    echo Deleting old LogicMods...
    rmdir /S /Q "!logicModsPath!"
)

echo Creating LogicMods folder...
mkdir "!logicModsPath!"

set "pppSource="
for /d %%f in ("PlayerPlusPlus-*") do (
    if exist "%%f\LogicMods\player++" (
        set "pppSource=%%f\LogicMods\player++"
    )
)

if not defined pppSource (
    echo Error: player++ folder not found.
    goto end
)

echo Installing player++...
xcopy /Y /E "!pppSource!" "!logicModsPath!\player++\" >nul
if errorlevel 1 (
    echo Error: Failed to copy player++.
    goto end
)

set "ghostModFolder="
for /d %%f in ("GhostTeleportMod-*") do (
    if exist "%%f" (
        set "ghostModFolder=%%f"
    )
)

if not defined ghostModFolder (
    echo Error: GhostTeleportMod folder not found.
    goto end
)

echo Installing GhostTeleportMod...
xcopy /Y /E "!ghostModFolder!" "!logicModsPath!\GhostTeleportMod\" >nul
if errorlevel 1 (
    echo Error: Failed to copy GhostTeleportMod.
    goto end
)

echo All done.
echo Credit ~Kenz
goto end

:end
pause
