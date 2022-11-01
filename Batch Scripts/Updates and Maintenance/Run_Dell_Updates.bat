cls
:: This batch file runs the Dell Command line utility to scan and then install updates. Reboots the PC after the updates.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Run Dell Updates
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

ECHO Preparing to Launch Dell Command-Line Utility Updater
ECHO ------------------------------------------------------
ECHO NOTICE: PC will automatically restart after updates are completed. 
ECHO Please SAVE and CLOSE any important work. Updates will start after scan.

cd C:\Program Files (x86)\Dell\CommandUpdate

ECHO Scanning for updates...
dcu-cli.exe /scan

ECHO Applying updates and rebooting once completed.
dcu-cli.exe /applyUpdates -reboot

ECHO.
ECHO.
ECHO Execution completed. Terminating.
timeout 10
shutdown -r -f -t 60