#!/bin/bash
#usage: sudo sh disk_usage.sh [log place]
#Lists data usage for Applications, Users, and all folders 1 level under Users
#Helpful to determine why someone is complaining about too much disk usage
#Stores data to /space_usage.txt (Top Level). Date in YYYY-MM-DD format
#Stupidly, this only works for Macs
#Don't necessarily have to run as sudo, but if you do then you'll get Permission
#Denied errors

today=$(date +%F)
if [ -z $1 ]; then
  log="/WIT_space_usage.txt"
else
  log=$1
fi
rm -f "$log"

echo "Applications Usage -----------------------" > "$log"
du -h -d 1 /Applications >> "$log"
echo "Users Usage ------------------------------" >> "$log"
du -h -d 2 /Users >> "$log"
