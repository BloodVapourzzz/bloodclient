@echo off
REM ============================================================
REM  Blood Client - one-time certificate installer
REM  Makes Windows read the publisher name from the Blood Client
REM  installer instead of showing "Unknown publisher".
REM
REM  It installs ONE public certificate file:
REM      signing\BloodClient-Root-CA.cer
REM  into:
REM      Trusted Root Certification Authorities
REM      Trusted Publishers
REM  No private key is involved, nothing is downloaded, and this
REM  can be undone with the Remove line at the bottom.
REM ============================================================
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "CER=%~dp0BloodClient-Root-CA.cer"
set "EXE=%~dp0BloodClientLauncher-Setup-2.0.0-signed.exe"

if not exist "%CER%" (
  echo [X] Could not find BloodClient-Root-CA.cer next to this file.
  echo     Keep this .bat in the same folder as the installer.
  pause & exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
  echo Asking Windows for administrator rights...
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b 0
)

echo.
echo [1/4] Removing any old BloodVapourzzz certificate from the Root store...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-ChildItem Cert:\LocalMachine\Root | Where-Object { $_.Subject -like '*BloodVapourzzz*' } | Remove-Item -ErrorAction SilentlyContinue; Write-Host '   done'"

echo [2/4] Installing Blood Client Root CA into Trusted Root...
certutil -addstore -f "Root" "%CER%" >nul && echo    added || echo    failed
if not errorlevel 1 (echo    Trusted Root OK)

echo [3/4] Installing it into Trusted Publishers...
certutil -addstore -f "TrustedPublisher" "%CER%" >nul && echo    added || echo    failed

echo [4/4] Checking the installer's signature with Windows...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$s = Get-AuthenticodeSignature -FilePath '%EXE%';" ^
  "Write-Host ('   Status : ' + $s.Status);" ^
  "if ($s.SignerCertificate) { Write-Host ('   Publisher: ' + $s.SignerCertificate.Subject) } else { Write-Host '   Publisher: (none)' }"

echo.
echo If Status says Valid and Publisher mentions BloodVapourzzz, Windows now
echo knows who made the file. Double-click the installer - it should no longer
echo say "Unknown publisher".
echo.
echo To undo later, run this in an admin PowerShell:
echo   certutil -delstore Root  "Blood Client Root CA"
echo   certutil -delstore TrustedPublisher  "Blood Client Root CA"
echo.
pause
