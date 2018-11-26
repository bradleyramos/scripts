#!/bin/bash
#Usage: sh transfer.sh [destination directory] [username] [source directory] [lib_switch]
#Use sudo sh transfer.sh in most cases
#[destination directory] - optional, transfers non-library files to selected directory.
#Files will be put in Users folder of destination directory in "Transfer"

#This variable sets the destination of the files to be transferred
#and can be edited to be any path of your choosing (use sudo though).

#The credentials at the very end it wants are the admin password and the user
#password set just prior.

nos=1
while [[ $nos == 1 ]]; do
  nos=0
  if [ -z "$3" ]; then
    echo "Needs a full file path, such as /Volumes/Macintosh HD 1/Users/and314"
    echo "You do not need to escape spaces, but do not touch your tab key (autofill breaks)."
    echo "Firefox, Chrome, and Safari profiles are automatically transferred."
    read -e -p "Type the source file path: " fileLoc
  else
    fileLoc=$3
  fi

  if [ -z "$1" ]; then
    read -e -p "Type the destination file path: " destination
  else
    destination=$1
  fi

  while [[ "$destination/"* == "$fileLoc" ]]; do
    if [ -z "$3" ]; then
      nos=1
      break
    fi
    read -p "Press ctrl + c to cancel this process. Destination cannot be in Source. " dummy
  done

  if [[ "$destination" == "$fileLoc/"* ]]; then
    read -p "$(echo "Are you sure you want to move files to within the source? \nThis will almostly certainly go very badly (y/n): ")" yoes
    if [[ "$yoes" == "y" ]]; then
      nos=0
    else
      nos=1
    fi
  fi
done
# Used later to create transfer_library file

if [ -z "$4" ]; then
  if [ -d "$fileLoc/Library" ]; then
    echo "You probably want to transfer Library files just in case."
    echo "However, if this is the second transfer on the same dataset, use no."
    read -p "Would you like to transfer Library files? (y/n): " yoes
  else
    yoes="n"
  fi
else
  yoes=$4
fi

tdate=$(date +%F)

mkdir -m777 -p "$destination"
echo "Data Transfer Started" > "$destination/WITtransferlog_$tdate"

for dir in "$fileLoc/"*; do
  if [[ "$dir" != *"/Library" ]] && [[ "$dir" != *"/Box Sync" ]] && [[ "$dir" != *"/Dropbox" ]]; then
   echo $dir
   cp -Rpv "$dir" "$destination" >> "$destination/WITtransferlog_$tdate"
 fi
done

if [ -d "$fileLoc/Library" ]; then
  mkdir -m777 -p "$destination/Library"
  mkdir -m777 -p "$destination/Library/Application Support"
fi

echo "Transferring internet profiles... "
echo "Transferring internet profiles... " >> "$destination/WITtransferlog_$tdate"
if [ -d "$fileLoc/Library/Safari" ]; then
  cp -Rpv "$fileLoc/Library/Safari" "$destination/Library" >> "$destination/WITtransferlog_$tdate"
fi

if [ -d "$fileLoc/Library/Application Support/Google" ]; then
  cp -Rpv "$fileLoc/Library/Application Support/Google" "$destination/Library/Application Support" >> "$destination/WITtransferlog_$tdate"
fi

if [ -d "$fileLoc/Library/Application Support/Firefox" ]; then
  cp -Rpv "$fileLoc/Library/Application Support/Firefox" "$destination/Library/Application Support" >> "$destination/WITtransferlog_$tdate"
fi

#-R handles symbolic and hard links properly (Old blocker on Library files)
#Files still not put in ~/Library for compatibility issues
if [[ "$yoes" == "y" ]]; then
  echo "Moving Library folder to transfer_library"
  echo "Moving Library folder to transfer_library" >> "$destination/WITtransferlog_$tdate"
  cp -Rpv "$fileLoc/Library" "$destination/transfer_library" >> "$destination/WITtransferlog_$tdate"
  chflags -R nohidden "$destination/transfer_library"
  chmod -R 777 "$destination/transfer_library"
fi

# Tar creation disabled
# Creates tar file containing Library, untars the file into "transfer_library" and deletes the tar
# if [[ "$yoes" == "y" ]]; then
#     echo "Archiving Library files... "
#     tar -cf "$destination/library.tar" "$fileLoc/Library"
#
#     echo "Extracting Library files to transfer_library... "
#     mkdir -m777 -p "$destination/transfer_library"
#     tar -C "$destination/transfer_library" -xf "$destination/library.tar"
#     chflags -R nohidden "$destination/transfer_library"
#
#     echo "Deleting library.tar... "
#     rm "$destination/library.tar"
#     # Grants permissions to all staff users (including admin account) on computer
#     chmod -R 770 "$destination/transfer_library"
# fi

if [ -z "$2" ]; then
    read -p "Intended owner username (or Ctrl + C to skip): " fUser
else
    fUser=$2
fi

chown -R $fUser "$destination"
