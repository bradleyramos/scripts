#!/bin/bash
#Usage: sudo sh install_printer.sh
#You must run this as an admin (with sudo) or nothing will happen.
#Installs a single printer whose model is already downloaded into witmac. Beware that model must
#exactly match the name of the driver. Will ask you for the admin password twice (lol).

echo "Do you wish to see a list of valid models and their names?"
read -p "BEWARE, this list is long (y/n): " yesno
echo "---------------------------------------------------------------------------------"
if [ "$yesno" == "y" ]; then
	sh valid_drivers.sh
fi

read -p "Name the printer (no spaces): " name
read -p "IP address of printer: " ipAdd
read -r -p "Model of printer (name of driver, e.g. RICOH MP C6004): " model
echo "Downloading driver, Input admin password"
sftp admin@129.105.3.7:/Library/Printers/PPDs/Contents/Resources/\""$model"\" /Library/Printers/PPDs/Contents/Resources/\""$model"\"
read -p "Manufacturer, Valid options: RICOH, Canon, KONICAMINOLTA, other " manu

case "$manu" in
"RICOH")
	echo "Downloading $manu dependencies, Input admin password:"
	scp -r  admin@129.105.3.7:/Library/Printers/RICOH /Library/Printers/Ricoh
	;;
"Canon")
	echo "Downloading $manu dependencies, Input admin password:"
	scp -r  admin@129.105.3.7:/Library/Printers/Canon /Library/Printers/Canon
	;;
"KONICAMINOLTA")
	echo "Downloading $manu dependencies, Input admin password:"
	scp -r  admin@129.105.3.7:/Library/Printers/KONICAMINOLTA /Library/Printers/KONICAMINOLTA
	;;
*)
	echo "Not downloading manufacturer dependencies... hope it's an HP..."
	;;
esac

echo "Installing printer"
/usr/sbin/lpadmin -p $ipAdd -o printer-is-shared="False" -E -v lpd://"$ipAdd" -P /Library/Printers/PPDs/Contents/Resources/"$model" -D \""$name"\"
echo "It's over"
