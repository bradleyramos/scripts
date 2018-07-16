@echo off
setlocal EnableDelayedExpansion

set /p subnet= What subnet? 
FOR /L %%G IN (1,1,255) DO (
	echo |set /p=IP:    %%G:    
	nslookup %subnet%.%%G | findstr "Name:"
)
pause