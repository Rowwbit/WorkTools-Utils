cls
:: This batch file forces a hard restart in 2 minutes, giving time to save/close apps as needed. Will not ask to save/close apps once 2m timer triggers. Does not require admin.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Force Restart
color 0a

ECHO Forcing restart in 2 minutes.
timeout /t 3
shutdown -r -f -t 120 -c "NOTICE: Forcing a restart in 2 minutes. Please save and close any important documents."
