#!/bin/bash
#Usage: sh no_lib_transfer.sh [user directory]
#Use sudo sh no_lib_transfer.sh in most cases
#[user directory] - optional, transfers non-library files from the selected directory. Should be of the form /Volumes/Macintosh\ HD\ 1/Users/and314"
#Files will be put on the desktop of the admin account in a folder called Transfer
#
#Changelog:
#7/10:  Fixed bug with (top-level) folders with name containing Library
#	Preserves attributes (ALL ATTRIBUTES, like permissions and timestamps)
#	Echos current (top-level) directory to track progress
#       Prompts to set owner after transfer is done to satisfy complainers





if [ -z "$1" ]; then
    echo ""
    echo "You probably want to use sudo, e.g: sudo sh transfer.sh. If you didn't, hit Ctrl + C to cancel."
    echo "Files will be placed in /Users/admin/Desktop/Transfer (even if none of this path is defined yet)"
    echo "Needs a full file path, such as /Volumes/Macintosh\ HD\ 1/Users/and314"
    echo "You must escape spaces: [\ ] instead of [ ]."
    echo "DO NOT TRY TO USE THIS WITH /Users/admin/* (Unlikely that you would be so dumb)"
    read -p "Type the file path: " fileLoc
else
    fileLoc=$1
fi

mkdir -m777 -p /Users/admin/Desktop/Transfer

for dir in "$fileLoc/"*; do
    if [[ "$dir" != *"/Library" ]]; then
	echo $dir
	cp -rp "$dir" /Users/admin/Desktop/Transfer
    fi
done

read -p "Intended owner username (or Ctrl + C to skip): " fUser

chown -R $fUser /Users/admin/Desktop/Transfer
