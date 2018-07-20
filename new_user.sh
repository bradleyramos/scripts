#!/bin/bash
#Usage: sudo sh new_user.sh
#Creates a new user, prompted on command line.
#Alternate usage: sudo sh new_user.sh [fullname] [username] [uid] [password]

if [ -z "$1" ]; then
	echo "Define a full name, can be pretty long (30 characters)"
	echo "Does nothing but set a display name. Don't go crazy, though"
	read -p "Type the user's full name (e.g. John Wu): " fullname
	echo "Create a username. No special characters or spaces alowed. Keep it short but unique."
	read -p "Type the username (e.g. wurules): " username
	echo "Select a user ID. This is a number between 503 and 1000 and MUST BE UNIQUE."
	echo "Be default, Mac makes the first account at 501 and the second at 503 then increments by 1/"
	echo "You should do the same (first account is already taken, so start with 503."
	echo "group id is 20, btw. No questions please, but you can change it in the code."
	read -p "Type the user ID: " uid
	echo "You should set the password to change,me, but I won't force you to."
	read -p "Type the password: " changeme
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

echo "Created User: $username"
