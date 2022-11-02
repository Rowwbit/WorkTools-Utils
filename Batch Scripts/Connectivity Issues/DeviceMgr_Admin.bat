cls
:: This batch file runs Device Manager as admin in order to access driver properties. It simplifies geting someone to Device Manager as quick as possible if you can't remote in to their machine. 
:: Doesn't really do anything useful if you can already access their machine since you can launch Device Mgr normally then use admin creds on whichever adapter properties you need access too.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Device Manager as Admin
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)
ECHO.
ECHO ---

cmd /c start devmgmt.msc
EXIT
