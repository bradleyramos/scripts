#!/bin/bash
#Usage: sh valid_drivers.sh
#Shows you what drivers are available on witmac, but more importantly
#provides an example of SSH usage.

ssh admin@129.105.3.7 "cd /Library/Printers/PPDs/Contents/Resources; ls"
exit
