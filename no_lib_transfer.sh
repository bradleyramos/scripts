#!/bin/bash
#Usage: sh no_lib_transfer.sh [destination directory] [username] [source directory]
#Use sudo sh no_lib_transfer.sh in most cases
#[destination directory] - optional, transfers non-library files to selected directory.
#Files will be put on the desktop of the admin account in a folder called Transfer

#This variable sets the destination of the files to be transferred
#and can be edited to be any path of your choosing (use sudo though).
#Note that you will have to use no spaces when you edit this (e.g. /Volumes/Macintosh\ HD\ 1/Users/and314).



if [-z "$3"]; then
  echo ""
  echo "Files will be placed in $destination (this is the first argument or default)"
  echo "Needs a full file path, such as /Volumes/Macintosh\ HD\ 1/Users/and314"
  echo "You must escape spaces: [\ ] instead of [ ]."
  echo "No Library files transferred except Firefox, Chrome, and Safari profiles"
  read -p "Type the source file path: " fileLoc
else
  fileLoc=$3
fi

if [ -z "$1" ]; then
  read -p "Type the destination file path" destination
else
  destination=$1
fi

mkdir -m777 -p "$destination"

for dir in "$fileLoc/"*; do
    if [[ "$dir" != *"/Library" ]]; then
	echo $dir
	cp -rp "$dir" "$destination"
    fi
done

mkdir -m777 -p "$destination/Library"
mkdir -m777 -p "$destination/Library/Safari"
mkdir -m777 -p "$destination/Library/Application Support"
mkdir -m777 -p "$destination/Library/Application Support/Google"
mkdir -m777 -p "$destination/Library/Application Support/Firefox"

cp -rp "$fileLoc/Library/Safari" "$destination/Library/Safari"
cp -rp "$fileLoc/Library/Application Support/Google" "$destination/Library/Application Support/Google"
cp -rp "$fileLoc/Library/Application Support/Firefox" "$destination/Library/Application Support/Firefox"

if [ -z "$2" ]; then
    read -p "Intended owner username (or Ctrl + C to skip): " fUser
else
    fUser=$2
fi

chown -R $fUser "$destination"
