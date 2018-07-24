#!/bin/bash
#Usage: sudo sh setup.sh
#Creates a new user, transfers to that user, and installs printers.
#This file is dependent on all the other files in scripts,
#so download the whole bloody thing.
#Alternate usage: sudo sh setup.sh [fullname] [username] [uid] [password]

RED='\033[0;31m'
RESET='\033[0m'

if [ -z "$1" ]; then
	username="$(sh new_user.sh|tail -n 1)"
else
	fullname=$1
	username=$2
	uid=$3
	changeme=$4

	sh new_user.sh "$fullname" "$username" "$uid" "$changeme"
fi

echo ${RED}"User account created----------------------------------------"${RESET}
sh no_lib_transfer.sh /Users/"$username" "$username"
echo ${RED}"Data Transferred---------------------------------------------"${RESET}
i=1


# What's wrong here? who knows, but it works now (LOL)
noyes='y'
while [ "$noyes" = "y" ]; do
	read -p "Add a printer? (y/n): " no
	if [ "$no" == "n" ]; then
		break
	fi
	sh install_printer.sh
done
