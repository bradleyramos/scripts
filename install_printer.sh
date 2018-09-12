#!/bin/bash
#Usage: sudo sh install_printer.sh
#You must run this as an admin (with sudo) or nothing will happen.
#Installs any number of printers whose model is already downloaded into witmac. Beware that model must
#exactly match the name of the driver. Will ask you for the admin password once.
RED='\033[0;31m'
RESET='\033[0m'
GREEN='\033[0;92m'

echo "Downloading printer drivers, you need the admin password below. Use Ethernet for insane speed."
scp admin@129.105.3.7:/Users/admin/printers.tar /Users/admin/printers.tar
mkdir -m777 /Users/admin/PPDS
tar -C "/Users/admin/PPDS" -xf "/Users/admin/printers.tar"

restart=y

while [[ "$restart" == "y" ]]; do
	echo "Do you wish to see a list of valid models and their names?"
	read -p "BEWARE, this list is long (y/n): " yesno
	if [ "$yesno" == "y" ]; then
		echo "----------------------------------------------------------------------"
		echo "Input admin password $GREEN"
		ls "/Users/admin/PPDS/Printers/PPDs/Contents/Resources"
		echo "$RESET"
	fi

	read -p "Name the printer (no spaces): " name
	read -p "IP address of printer: " ipAdd
	#Why is there -r here? I have no idea
	read -r -p "Model of printer (name of driver, e.g. RICOH MP C6004): " model
	echo "Moving driver, Input admin password"
	cp "/Users/admin/PPDS/Printers/PPDs/Contents/Resources/$model" "/Library/Printers/PPDs/Contents/Resources/$model"
	read -p "$(echo $RED"Manufacturer, Valid options: RICOH, Canon, KONICAMINOLTA, other: "$RESET)" manu

	case "$manu" in
	"RICOH")
		echo "Copying $manu dependencies."
		cp -r  /Users/admin/PPDS/Printers/RICOH /Library/Printers/Ricoh
		;;
	"Canon")
		echo "Copying $manu dependencies."
		cp -r  /Users/admin/PPDS/Printers/Canon /Library/Printers/Canon
		;;
	"KONICAMINOLTA")
		echo "Copying $manu dependencies."
		cp -r  /Users/admin/PPDS/Printers/KONICAMINOLTA /Library/Printers/KONICAMINOLTA
		;;
	*)
		echo "Not Copying manufacturer dependencies... hope it's an HP..."
		;;
	esac

	echo $RED"Installing printer"$RESET
	/usr/sbin/lpadmin -p $ipAdd -o printer-is-shared="False" -E -v lpd://"$ipAdd" -P /Library/Printers/PPDs/Contents/Resources/"$model" -D "$name"
	echo "Printer Installed"
	read -p "Install another printer? (y/n): " restart
done

echo "Deleting temp files"

rm -r /Users/admin/PPDS/
rm /Users/admin/printers.tar
