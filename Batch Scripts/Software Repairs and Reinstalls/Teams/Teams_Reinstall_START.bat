cls
:: This batch file clears all cache folders and reinstalls Teams.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Teams Reinstall
color 0a


:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

:: ----------------------------------------------------------------------------------------------------------------------
:: START POWERSHELL SCRIPT
ECHO Starting Teams reinstall powershell script.
ECHO --------------------------------------------
ECHO.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0\Teams_Reinstall_PS_REQUIRED_DO_NOT_RUN.ps1"
:: powershell.exe -ExecutionPolicy Bypass -File "C:\Users\Ryan_\OneDrive\Desktop\Batch Scripts\Software Repairs and Reinstalls\Teams\Teams_Uninstall_PS_REQUIRED_DO_NOT_RUN.ps1"
:: END POWERSHELL SCRIPT
:: ----------------------------------------------------------------------------------------------------------------------
ECHO Done.
PAUSE
