cls
:: This batch file will reset winsock and TCP adapters/settings to default and ping DCHP server for a new IP address. This file should not be used unless internet is just completely broke and nothing else is working. It will prompt if you want to continue. If so press Y, if not press N.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Reset Internet Adapters
color 06

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

:: Advise the user if they really want to continue and route accordingly
ECHO Warning: This script will reset all TCP/IP and Winsock configurations to default and rebuild them.
choice /c yn /m "Are you sure you wish to continue?"
ECHO --------------------------------------------
if "%ERRORLEVEL%" == "1" goto RESET
if "%ERRORLEVEL%" == "2" goto ABORT



:RESET
ECHO Releasing IP address.
ipconfig /release

ECHO Flushing DNS.
ipconfig /flushdns

ECHO Renewing IP address.
ipconfig /renew

ECHO Rebuilding WINSOCK and TCP Protocol.
netsh int ip reset
netsh winsock reset


ECHO.
ECHO --------------------------------------------
ECHO Network settings reset.
ECHO.
PAUSE
exit

:ABORT
ECHO.
ECHO --------------------------------------------
ECHO Program aborted. No changes have been made.
ECHO.
PAUSE
