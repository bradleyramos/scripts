#!/bin/bash
#Usage: sh launch_update.sh
#Updates applications that need to be updated.
#This needs to be changed every time the image has its applications changed (!!)

#move this to the end after testing
./Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/MacOS/msupdate --install

open /Applications/Firefox.app
open /Applications/Safari.app
open /Applications/Google\ Chrome.app

open /Applications/Box\ Sync.app
open /Applications/CrashPlan.app
open /Applications/EndNote\ X8/EndNote\ X8.app
open /Applications/Symantec\ Solutions/Symantec\ Endpoint\ Protection.app
open /Applications/Adobe\ Acrobat\ DC/Adobe\ Acrobat.app
