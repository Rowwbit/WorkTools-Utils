cls
:: This batch file re-enables Wifi, Ethernet, and Cisco Network adapters.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Enable Network Adapters
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)
ECHO.
ECHO ---
ECHO Enabling VPN adapter...
netsh interface set interface "Cisco AnyConnect Secure Mobility Client Connection" enable | findstr /v "No more data is available."
ECHO Enabling Ethernet adapter...
netsh interface set interface "Ethernet" enable  | findstr /v "No more data is available."
ECHO Enabling Wifi adapter...
netsh interface set interface "Wifi" enable  | findstr /v "No more data is available."

ECHO Enabled network adapters.
PAUSE
