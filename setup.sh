#!/bin/bash
#Usage: sudo sh setup.sh
#Creates a new user, transfers to that user, and installs printers.
#This file is dependent on all the other files in scripts,
#so download the whole bloody thing.
#Alternate usage: sudo sh setup.sh [fullname] [username] [uid] [password]

if [ -z "$1" ]; then
	username="$(sh new_user.sh|tail -n 1)"
else
	fullname=$1
	username=$2
	uid=$3
	changeme=$4

	sh new_user.sh "$fullname" "$username" "$uid" "$changeme"
fi


echo "User account created----------------------------------------"
sh no_lib_transfer.sh /Users/"$username" "$username"
echo "Data Transferred---------------------------------------------"
i=1
while [[ i=1 ]]; do
	sh install_printer.sh
	read -p "Add another printer? (y/n): " yesno
	if [ "$yesno" != "y" ]; then
		i=0
	fi
done
sh install_printer.sh
