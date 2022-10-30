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


ECHO Disable Teredo tunneling
netsh interface teredo set state disabled

ECHO Disable the 6to4 tunnels that support communication with IPv6 internet
netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled

ECHO Disable all IPv6 transition technologies
netsh interface ipv6 isatap set state state=disabled

ECHO DISABLED IPV6 ON ALL ADAPTERS
PAUSE
