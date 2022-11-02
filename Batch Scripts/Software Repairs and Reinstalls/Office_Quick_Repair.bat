cls
:: This batch file does a quick repair on MS office 15.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Office Quick Repair
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

ECHO Sending request for repair.
cd C:\Program Files\Microsoft Office 15\ClientX64\
OfficeClickToRun.exe scenario=Repair culture=en-us RepairType=QuickRepair DisplayLevel=True


ECHO Done. Quick repair launcher triggered.
PAUSE
