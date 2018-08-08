@echo off
setlocal EnableDelayedExpansion

set COUNTER=0
FOR /L %%G IN (1,-1,255) DO (
	set /A COUNTER=COUNTER+1
)
pause
