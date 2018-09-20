#!/bin/bash
# Usage: sudo sh simple_setup.sh
# Asks for First Name, Last Name, and previous file loc and then proceeds with setup
# User creation, file transfer, launch update included.


RED='\033[0;31m'
RESET='\033[0m'
GREEN='\033[0;92m'

read -p "Type the Client's first name: " firstName
read -p "Type the Client's last name: " lastName
#Sends to lower case
username="$(echo "$lastName" | awk '{print tolower($0)}')"
#Replaces spaces with underscores
username="${username// /_}"


echo "Concerning the Data transfer: "
read -p "Is the old computer in Target mode and connected to this computer? (y/n): " noyes
if [[ "$noyes" == "y" ]]; then
    oldFile="/Volumes/Macintosh HD 1/Users"
    type="user accounts"
else
    read -p "Is the data on an external hard drive? (y/n): " noyes
    if [[ "$noyes" == "y" ]]; then
        #In this case, we need to check the HFS+ Partition specifically (no users folder in this case)
        oldFile="/Volumes/HFS+ Partition"
        type="folders"
    else
        while [[ "1" == "1" ]]; do
            #Must use not for dummies to customize source location
            read -p "You're doomed. Use setup.sh instead. Press Ctrl + C to exit. " noyes
        done
    fi
fi

#Next part is green to highlight part they need to read
echo "$GREEN"
ls "$oldFile"
echo "$RESET"

noyes==1
while [[ $noyes == 1 ]]; do
    read -p "$(echo "${RED}Which of the above $type do you want to transfer?\n(Typically their netID, Last Name, or First Name) $RESET"):" oldUser
    fileLoc="$oldFile/$oldUser"
    if [ ! -d "$oldFile/$oldUser" ]; then
        noyes==1
        echo "This is not a valid user"
    else
        noyes==0
    fi
done



#Copied from new_user.sh
n=503
for listuid in $(dscl . -list /Users UniqueID | awk '{print $2}'); do
    if [ $listuid -gt $n ] || [ $listuid == $n ]; then
        n=$(($listuid+1))
        # echo "ping"
    fi
        # echo "$listuid"
done

uid="$n"

sh new_user.sh "$firstName $lastName" "$username" "$uid" "change,me"

echo ${RED}"User account created----------------------------------------"${RESET}
printf \\a


sh transfer.sh /Users/"$username" "$username" "$fileLoc"
echo ${RED}"Data Transferred---------------------------------------------"${RESET}
say -v Thomas The Data Transfer Has Completed.
i=1

read -p "Launch Programs to be updated? (y/n): " noyes
if [[ "$noyes" == "y" ]]; then
	sh launch_update.sh
fi
