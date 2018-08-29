#!/bin/bash
#Usage: sh no_lib_transfer.sh [destination directory] [username] [source directory]
#Use sudo sh no_lib_transfer.sh in most cases
#[destination directory] - optional, transfers non-library files to selected directory.
#Files will be put on the desktop of the admin account in a folder called Transfer

#This variable sets the destination of the files to be transferred
#and can be edited to be any path of your choosing (use sudo though).

#The credentials at the very end it wants are the admin password and the user
#password set just prior.

nos=1
while [[ $nos == 1 ]]; do
  nos=0
  if [ -z "$3" ]; then
    echo "Needs a full file path, such as /Volumes/Macintosh\ HD\ 1/Users/and314"
    echo "You do not need to escape spaces, but this will break autofill."
    echo "No Library files transferred except Firefox, Chrome, and Safari profiles... unless you want it to"
    read -e -p "Type the source file path: " fileLoc
  else
    fileLoc=$3
  fi

  if [ -z "$1" ]; then
    read -e -p "Type the destination file path: " destination
  else
    destination=$1
  fi

  while [[ "$destination" == "$fileLoc"* ]]; do
    if [ -z "$3" ]; then
      nos=1
      break
    fi
    read -p "Press ctrl + c to cancel this process. Destination cannot be in Source. " dummy
  done

  if [[ "$destination" == "$fileLoc"* ]]; then
    read -p "$(echo "Are you sure you want to move files from within the source? \nThis will almostly certainly go very badly (y/n): ")" yoes
    if [[ "$yoes" == "y" ]]; then
      nos=0
    else
      nos=1
    fi
  fi
done
# Used later to create transfer_library file
read -p "Would you like to transfer Library files? (y/n): " yoes


mkdir -m777 -p "$destination"

for dir in "$fileLoc/"*; do
    if [[ "$dir" != *"/Library" ]]; then
	     echo $dir
	     cp -rp "$dir" "$destination"
    fi
done

mkdir -m777 -p "$destination/Library"
mkdir -m777 -p "$destination/Library/Application Support"

echo "Transferring internet profiles... "
cp -rp "$fileLoc/Library/Safari" "$destination/Library"
cp -rp "$fileLoc/Library/Application Support/Google" "$destination/Library/Application Support"
cp -rp "$fileLoc/Library/Application Support/Firefox" "$destination/Library/Application Support"

# Creates tar file containing Library, untars the file into "transfer_library" and deletes the tar

if [[ "$yoes" == "y" ]]; then
    echo "Archiving Library files... "
    tar -cf "$destination/library.tar" "$fileLoc/Library"

    echo "Extracting Library files to transfer_library... "
    mkdir -m777 -p "$destination/transfer_library"
    tar -C "$destination/transfer_library" -xf "$destination/library.tar"
    chflags -R nohidden "$destination/transfer_library"

    echo "Deleting library.tar... "
    rm "$destination/library.tar"
fi

if [ -z "$2" ]; then
    read -p "Intended owner username (or Ctrl + C to skip): " fUser
else
    fUser=$2
fi

chown -R $fUser "$destination"
