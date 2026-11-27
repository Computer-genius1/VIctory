@echo off
setlocal
title VIctory Setup and Launcher
cd /d "%~dp0"
echo.
echo  VIctory - Windows Setup
echo  ---------------------
echo  This launcher keeps the window open and reports errors.
echo  It does not include GTA VI game files.
echo.
if not exist "victory.exe" (
  echo ERROR: victory.exe was not found beside this launcher.
  echo Please extract the entire VIctory package first.
  pause
  exit /b 1
)
set "GAME_DIR="
set /p "GAME_DIR=Enter your game folder path (or press Enter to skip setup): "
if not "%GAME_DIR%"=="" (
  set "GAME_DIR=%GAME_DIR:"=%"
  if not exist "%GAME_DIR%\*" (
    echo ERROR: That folder does not appear to exist.
    pause
    exit /b 1
  )
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = $env:GAME_DIR; $p = $p.Replace('\\','\\\\').Replace('\"','\\\"'); Set-Content -Encoding UTF8 -Path 'victory.local.toml' -Value ('[paths]' + [Environment]::NewLine + 'game_dir = \"' + $p + '\"')"
  if errorlevel 1 (
    echo ERROR: Could not write the local configuration file.
    pause
    exit /b 1
  )
  set "VICTORY_CONFIG=%CD%\victory.local.toml"
  echo Saved your game-folder setting locally.
)
echo.
echo Running configuration check...
"victory.exe" config
if errorlevel 1 (
  echo.
  echo Configuration check reported a problem. Read the message above.
) else (
  echo.
  echo Configuration check passed.
  echo This is not a one-click game launcher yet.
  echo Shader translation and the experimental run command remain manual.
  echo Please consult README.md for the documented commands and limitations.
)
echo.
pause
endlocal
