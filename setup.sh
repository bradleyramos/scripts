#!/bin/bash
#Usage: sudo sh setup.sh
#Creates a new user, transfers to that user, and installs printers.
#This file is dependent on all the other files in scripts,
#so download the whole bloody thing.
#Alternate usage: sudo sh setup.sh [fullname] [username] [uid] [password] [source]


RED='\033[0;31m'
RESET='\033[0m'

if [ -z "$1" ]; then
	username="$(sh new_user.sh|tail -n 1)"
else
	fullname=$1
	username=$2
	uid=$3
	changeme=$4
	fileLoc=$5
	echo "Executing promode"

	sh new_user.sh "$fullname" "$username" "$uid" "$changeme"
fi

echo ${RED}"User account created----------------------------------------"${RESET}
printf \\a
sh transfer.sh /Users/"$username" "$username" "$fileLoc"
echo ${RED}"Data Transferred---------------------------------------------"${RESET}
printf \\a
i=1


read -p "Add a printer? (y/n): " noyes
while [[ "$noyes" == "y" ]]; do
	sh install_printer.sh
	read -p "Add a printer? (y/n): " noyes
done

read -p "Launch Programs to be updated? (y/n): " noyes
if [[ "$noyes" == "y" ]]; then
	sh launch_update.sh
fi
