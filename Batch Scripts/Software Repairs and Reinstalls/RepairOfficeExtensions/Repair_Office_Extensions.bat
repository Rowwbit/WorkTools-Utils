cls
:: This batch file runs the powershell script in order to fix Office programs not opening because of file extension defaults are not properly set.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Repair Office Extensions
color 0a


:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

:: ----------------------------------------------------------------------------------------------------------------------
:: START POWERSHELL SCRIPT
ECHO Starting RepairOfficeExt powershell script.
ECHO --------------------------------------------
ECHO.

IF EXIST "%~dp0\RepairOfficeExt_REQUIRED_DO_NOT_RUN" (
   powershell.exe -ExecutionPolicy Bypass -File "%~dp0\Teams_Reinstall_PS_REQUIRED_DO_NOT_RUN.ps1"
) ELSE (
  ECHO.
  ECHO ERROR: Powershell script "RepairOfficeExt_REQUIRED_DO_NOT_RUN.ps1" was not found. Was the file moved or renamed?
  ECHO Please ensure the Powershell Script is in the same directory as this batch file and try again.
  ECHO Script aborted.

  PAUSE
  EXIT
)


:: END POWERSHELL SCRIPT
:: ----------------------------------------------------------------------------------------------------------------------
ECHO Done.
PAUSE
