@echo off
setlocal
chcp 65001 >nul

set "PORT=4173"
set "SITE_URL=http://127.0.0.1:%PORT%/"
set "SITE_DIR=%~dp0dist"

if not exist "%SITE_DIR%\index.html" (
  echo [ERROR] Website files were not found in: %SITE_DIR%
  pause
  exit /b 1
)

curl.exe --silent --fail --max-time 1 "%SITE_URL%" >nul 2>&1
if not errorlevel 1 (
  echo The website is already running. Opening it now...
  start "" "%SITE_URL%"
  exit /b 0
)

where python >nul 2>&1
if not errorlevel 1 (
  echo Starting Tuwaiq Tech Lab at %SITE_URL%
  start "" "%SITE_URL%"
  python -m http.server %PORT% --directory "%SITE_DIR%"
  exit /b %errorlevel%
)

where py >nul 2>&1
if not errorlevel 1 (
  echo Starting Tuwaiq Tech Lab at %SITE_URL%
  start "" "%SITE_URL%"
  py -m http.server %PORT% --directory "%SITE_DIR%"
  exit /b %errorlevel%
)

echo [ERROR] Python is required to run the local website.
echo Install Python, then run this file again.
pause
exit /b 1
