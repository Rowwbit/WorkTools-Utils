cls
:: This batch file maps drives for a specific org
@ECHO OFF
ECHO --------------------------
ECHO -  Script Author: M.G.   -
ECHO --------------------------
ECHO.

TITLE Drive Mapping for DAYT
color 0a

net use K: \\dpidata2\kshare
net use I: \\dpicadinv\I
net use M: \\dpicadinv\engsys
net use N: \\dpiindata.daytonparts.lcl\sys
net use o: \\dpidata2\odrive
net use r: \\esi-ts\production
net use s: \\esi-ts\engineering
net use L: \\dpidata1.daytonparts.lcl\lshare

PAUSE
