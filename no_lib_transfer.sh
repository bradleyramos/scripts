#!/bin/bash
#Usage: sh no_lib_transfer.sh [destination directory]
#Use sudo sh no_lib_transfer.sh in most cases
#[destination directory] - optional, transfers non-library files to selected directory.
#Files will be put on the desktop of the admin account in a folder called Transfer

#This variable sets the destination of the files to be transferred
#and can be edited to be any path of your choosing (use sudo though).
#Note that you will have to use no spaces when you edit this (e.g. /Volumes/Macintosh\ HD\ 1/Users/and314).


if [ -z "$1" ]; then
    destination=/Users/admin/Desktop/Transfer
else
    destination=$1
fi

echo ""
echo "You probably want to use sudo, e.g: sudo sh transfer.sh. If you didn't, hit Ctrl + C to cancel."
echo "Files will be placed in /Users/admin/Desktop/Transfer or the destination set in code (you can set this)"
echo "Needs a full file path, such as /Volumes/Macintosh\ HD\ 1/Users/and314"
echo "You must escape spaces: [\ ] instead of [ ]."
echo "DO NOT TRY TO USE THIS WITH /Users/admin/* (Unlikely that you would be so dumb)"
read -p "Type the file path: " fileLoc

mkdir -m777 -p "$destination"

for dir in "$fileLoc/"*; do
    if [[ "$dir" != *"/Library" ]]; then
	echo $dir
	cp -rp "$dir" "$destination"
    fi
done

if [-z "$2" ]; then
    read -p "Intended owner username (or Ctrl + C to skip): " fUser
else
    fUser=$2
fi

chown -R $fUser "$destination"
