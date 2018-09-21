#!/bin/bash
#Usage: sh scanall.sh [subnet]
#[subnet] - optional, will scan for all active dhcp and static ip
#addresses on the subnet.
#Example: sh scanall.sh 129.105.3
#List all static IPs and DHCP with the form 129.105.3.xxx

if [ -z "$1" ]
  then
    read -p "Enter subnet (e.g. 129.105.3): " subnet
  else
    subnet=$1
fi

for i in {1..255}; do
  nslookup "$subnet.$i"
done | grep 'name = ' | awk -F '[.=]' '{print $1 $7}'
