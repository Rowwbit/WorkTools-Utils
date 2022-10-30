cls
:: This batch file cancels a timer reboot/restart that is currently scheduled. (Meant to use to abort Force_Reboot script) Does not require admin.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Cancel Shutdown/Restart
color 0a


ECHO Shutdown/Restart aborted.
shutdown -a

PAUSE
