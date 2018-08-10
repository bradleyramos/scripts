#!/bin/bash
#Usage: sudo sh new_user.sh
#Creates a new user, prompted on command line.
#Alternate usage: sudo sh new_user.sh [fullname] [username] [uid] [password]

#The credentials at the very end it wants are the admin password and the user
#password set just prior.

RED='\033[0;31m'
RESET='\033[0m'

n=503
for listuid in $(dscl . -list /Users UniqueID | awk '{print $2}'); do
	if [ $listuid -gt $n ] || [ $listuid == $n ]; then
		n=$(($listuid+1))
		# echo "ping"
	fi
	# echo "$listuid"
done

if [ -z "$1" ]; then
	read -p "$(echo "Define a full name, can be pretty long (30 characters) \nType the user's full name, (e.g. John Wu): ")" fullname
	read -p "$(echo "Define a Username: No special characters or spaces alowed.\nType the username (e.g. wurules): ")" username
	read -p "$(echo "Select a user ID. This is a UNIQUE number between 503 and 1000\nMac sets the first account (admin) 501, second (jamfadmin) 502, etc.$RED \nI recommend that you pick $n $RESET\nType the user ID (Unique, 503-1000): ")" uid
	read -p "$(echo "Set the password. In plain text, so use change,me\nType the password (plain text, e.g. change,me): ")" changeme
else
	fullname=$1
	username=$2
	uid=$3
	changeme=$4
fi

#Create account
dscl . -create /Users/$username
#Activate the shell (bash RULES tcsh DROOLS)
dscl . -create /Users/$username shell /bin/bash
#Set user ID
dscl . -create /Users/$username uid "$uid"
#Set primary group to Staff (default behavior)
dscl . -create /Users/$username gid 20
#Set full name
dscl . -create /Users/$username realname "$fullname"
#Set home directory
dscl . -create /Users/$username NFSHomeDirectory /Users/$username
#Set password
dscl . -passwd /Users/$username $changeme
#Elevate to admin
dscl . -append /Groups/admin GroupMembership $username

read -p "$(echo "Allow user to unlock by Filevault? \nIf you pick yes (DEFINITELY PICK YES) then you will \nenter different information depending on the operating system\n but you will only need the admin username, admin password, \nand account password (change,me).")" neyo
#Allows user to unlock by filevault, needs admin password
fdesetup add -usertoadd $username

#Final output for setup.sh
echo "$username"
