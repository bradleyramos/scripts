@echo off
setlocal EnableDelayedExpansion

set COUNTER=0
:start
	set /A COUNTER=COUNTER+1
goto start
