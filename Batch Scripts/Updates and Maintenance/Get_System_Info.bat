cls
:: This batch file gives details on Windows OS, Device name (PC ID), IPV4 and IPV6. Does not require admin.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.


TITLE System Info
color 0a

:: Windows 10 information
ECHO ============================
ECHO WINDOWS INFO
ECHO ============================
ECHO Please wait... Checking system information.
ECHO.
ECHO.


ECHO -------------------------------------------------
ECHO Computer ID (Device Name) - Copied to Clipboard
hostname | clip
hostname
ECHO -------------------------------------------------

systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"OS Version"
ECHO ---
ECHO Computer Uptime
net statistics Workstation | findstr /c:"Statistics since"

ECHO.
:: Lists all IPV4 and IPV6 Network information

ECHO =============================================================
ECHO NETWORK INFO
ECHO =============================================================

ECHO ---
ECHO Network Errors/Reconnects since last restart
net statistics Workstation | findstr /c:"Network errors"
net statistics Workstation | findstr /c:"Connections made"
net statistics Workstation | findstr /c:"Reconnections made"
net statistics Workstation | findstr /c:"Server disconnects"
ECHO ---
ipconfig | findstr IPv4
ipconfig | findstr IPv6

PAUSE
