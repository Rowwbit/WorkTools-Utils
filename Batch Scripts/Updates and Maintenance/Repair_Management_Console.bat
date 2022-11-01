cls
:: This batch file allows for repair options of all types.
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

TITLE Repair Management Console
color 0a

:: Check if Admin - if not do not continue
net.exe session 1>NUL 2>NUL || (Echo ERROR: This script requires elevated rights. Exiting... & PAUSE & Exit /b 1)

goto HELP
:: --------------------------------------------------------------------------------------------------------------------
::					START MAIN LOOP
:: --------------------------------------------------------------------------------------------------------------------

:START
cls
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

ECHO --------------------------------------------------
ECHO -           Repair Management Console            -
ECHO --------------------------------------------------
ECHO Welcome to the Repair Management Console
ECHO Please select from the following options below:
ECHO.
ECHO.
ECHO 1. SFC
ECHO 2. CHKDSK
ECHO 3. DISM
ECHO 4. HELP
ECHO.
ECHO 0. EXIT
PAUSE

:: --------------------------------------------------------------------------------------------------------------------
::					SFC
:: --------------------------------------------------------------------------------------------------------------------

:SFC
cls
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

ECHO -----------------------
ECHO -         SFC         -
ECHO -----------------------
ECHO 
ECHO Welcome to the System File Checker utility.
ECHO.
ECHO SFC is an easy quick scan but relies on information gathered from DISM. 
ECHO This utility can be used first as a quick check but you should complete a DISM RestoreHealth first before running SFC.
ECHO.
ECHO Please select from the following options below.
ECHO 1. Scan
ECHO 2. MAIN MENU
ECHO.
ECHO 0. EXIT
PAUSE

:: --------------------------------------------------------------------------------------------------------------------
::					CHKDSK
:: --------------------------------------------------------------------------------------------------------------------

:CHKDSK
cls
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

ECHO -----------------------
ECHO -       CHKDSK        -
ECHO -----------------------
ECHO 
ECHO Welcome to the Check Disk utility.
ECHO.
ECHO Please select from the following options below.
ECHO.
ECHO Notice: 
ECHO This utility is only configured to check the C drive. No other drives are supported.
ECHO The computer will have to have the drive off for options 2 and 3 so a restart will be required.
ECHO
ECHO WARNING: CHKDSK may take a long time. A 1TB drive could take anywhere from over a few hours to a day. 
ECHO          Smaller drives are faster. A Quick scan is recommended before proceeding further.
ECHO 
ECHO 1. Quick Scan (Fast)
ECHO 2. Scan & Fix Errors (Slow)
ECHO 3. Scan & Fix Errors & Repair Sectors (Christmas)
ECHO 4. MAIN MENU
ECHO.
ECHO 0. EXIT
PAUSE

:: --------------------------------------------------------------------------------------------------------------------
::					DISM (Deployment Image Servicing and Management) 
:: --------------------------------------------------------------------------------------------------------------------

:CHKDSK
cls
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.

ECHO -----------------------------------------------------------------
ECHO -      DISM (Deployment Image Servicing and Management)         -
ECHO -----------------------------------------------------------------
ECHO 
ECHO Welcome to the Deployment Image Servicing and Management utility.
ECHO.
ECHO Please select from the following options below.
ECHO.
ECHO WARNING: Please see help section for more on this utility.
ECHO This tool requires a specific process to complete and works in conjunction with SFC.
ECHO After completing the DISM process you should run SFC again. DISM Requires internet access.
ECHO 
ECHO Run in order 1, 2, 3. Do not skip.  
ECHO If corruption is found in option 1 or 2 re-run the same command again before proceeding.
ECHO
ECHO 1. Check Health
:: Dism /Online /Cleanup-Image /CheckHealth

ECHO 2. Scan Health
:: Dism /Online /Cleanup-Image /ScanHealth

ECHO 3. Restore Health
:: Dism /Online /Cleanup-Image /RestoreHealth
ECHO 4. MAIN MENU
ECHO.
ECHO 0. EXIT
PAUSE

:: --------------------------------------------------------------------------------------------------------------------
::					HELP PAGE 
:: --------------------------------------------------------------------------------------------------------------------

:HELP
cls
ECHO --------------------------
ECHO -  Script Author: R.F.   -
ECHO --------------------------
ECHO.


ECHO.
color 04
ECHO !!!!!!!!!! THIS FILE IS WORK IN PROGRESS AND IS NOT USABLE. !!!!!!!!!! 
ECHO.

ECHO SFC (System File Checker)
ECHO ----------------------------
ECHO The SFC tool grabs backup files stored from the %WinDir%\WinSxS directory (windows folder for backup system files)
ECHO Keep in mind its possible these files may be old/bad/corrupted files and SFC doesn't care. It just replaces the files regardless.
ECHO DISM process will update the %WinDir%\WinSxS folder with new backups grabbed from the internet. Then you can run SFC with newer files.
ECHO You can run SFC as just a quick test to see if it helps before beginning bigger repairs as well.
ECHO Its unlikely to cause more issues than whats already present.
ECHO -----------------------------
ECHO. 
ECHO CHKDSK (Check Disk)
ECHO ----------------------------
ECHO CHKDSK will check the hard drive for errors. This is probably the last option that should be considered.
ECHO The checking process can be relatively fast if using the "Quick Scan" option but that wont repair anything.
ECHO The "Scan & Fix Errors" does Chkdsk /f which can take a long time, especially with a bigger hard drive.
ECHO The "Scan & Fix Errors & Repair Sectors" does Chkdsk /r and will take a long time. 
ECHO The Repair option fixes drive errors like the first option and attempts to rebuild/repair the data and sectors that had errors. 
ECHO Either of the repair options can disable a machine for many hours until completed. 
ECHO Theres no easy way to determine how long the process would take ahead of time.
ECHO -----------------------------
ECHO. 
ECHO DISM (Deployment Image Servicing and Management)
ECHO ----------------------------
ECHO DISM is the core utility for Windows imagine services. DISM enumerates, installs, uninstalls, configures, and updates features and packages in Windows images.
ECHO. 
ECHO This should technically be used before SFC to ensure that the backup files located in %WinDir%\WinSxS are up to date. SFC depends on those files.
ECHO Use CheckHealth to check whether the image has been flagged as corrupted by a failed process and whether the corruption can be repaired.
ECHO Use ScanHealth to scan the image for component store corruption.
ECHO Finally use RestoreHealth to scan the image for component store corruption, and then perform repair operations automatically.
ECHO.
ECHO Rerun CheckHealth or ScanHealth again if corruption is found on the first attempt. 
ECHO You might have to run both 1 and 2 twice (if they both say corrupted) before running RestoreHealth.
ECHO -----------------------------

ECHO.
color 04
ECHO !!!!!!!!!! THIS FILE IS WORK IN PROGRESS AND IS NOT USABLE. !!!!!!!!!! 
ECHO.

PAUSE


