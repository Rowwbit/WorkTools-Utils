cls
:: This batch file removes IPV6 from all network adapters
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Disable IPV6
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

:: ----------------------------------------------------------------------------------------------------------------------
:: START POWERSHELL SCRIPT
ECHO Starting DisableIPV6 powershell script.
ECHO --------------------------------------------
ECHO.

IF EXIST "%~dp0\Disable_IPV6_REQUIRED_DO_NOT_RUN.ps1" (
   powershell.exe -ExecutionPolicy Bypass -File "%~dp0\Disable_IPV6_REQUIRED_DO_NOT_RUN.ps1"
) ELSE (
  ECHO.
  ECHO ERROR: Powershell script "Disable_IPV6_REQUIRED_DO_NOT_RUN.ps1" was not found. Was the file moved or renamed?
  ECHO Please ensure the Powershell Script is in the same directory as this batch file and try again.
  ECHO Script aborted.

  PAUSE
  EXIT
)
