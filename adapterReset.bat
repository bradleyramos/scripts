@echo off

set ADAPTER="ETHERNET"

netsh interface set interface %ADAPTER% disable
netsh interface set interface %ADAPTER% enable
