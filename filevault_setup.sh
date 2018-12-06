#!bin/bash
# Uses arguments to run fdesetup from WITUP
# Does, in fact, add user to filevault.
# Usage: sudo sh filevault_setup.sh [user's name] [admin password]

echo "Adding user to FileVault 2 list."

userName=$1
adminPass=$2


## This "expect" block will populate answers for the fdesetup prompts that normally occur while hiding them from output
expect -c "
log_user 0
spawn fdesetup add -usertoadd $userName
expect \"Enter the user name:\"
send admin\r
expect \"Enter the password for user 'admin':\"
send ${adminPass}\r
expect \"Enter the password for the added user '$userName':\"
send change,me\r
log_user 1
expect eof
"
