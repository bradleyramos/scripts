Version 0.1:
  Successfully makes one user account, transfers data to said account, and creates a printer
  with driver preloaded into witmac.

Version 0.2:
  setup.sh:
    Change colors to make actual prompts stand out a bit
    Update help documentation
    Reduce total number of echoes
    Allow for more than 1 printer to be added
    Change setup.sh to fully use only other commands
    Full help echoes not available from setup.sh's running of new_user.sh
  perm_move.bat allows settings of destination

Version 0.3
  setup.sh:
    Added support for browser profiles
    Check to install printers before first prompt
    Arguments for setup.sh expanded
    Sounds play when steps finish
    FileVault support finalized

Version 0.4
  setup.sh:
    Prompts if trying to transfer to somewhere in source folder
    Recommends a UID
    launch_update.sh created, launching applications to be updated
  new_user.sh:
    filevault set up depends on the model of computer used (BUT WHY WHHHHHHYYYY)

Version 1.0
  transfer.sh:
    Asks to transfer Library files
    Untars into transfer_library directory and deletes tar file
  launch_update.sh
    Removed Safari launch
    Launches system preferences and Microsoft AutoUpdate
    Updated box app launch
  Added simple_setup:
    Only asks user for First Name, Last Name, and location of source file
    Source must be another computer in transfer mode or an APFS+ Partition hard drive
    User creation, file transfer, and launch update included

Vestion 1.1
  crontab
    Job to keep github repo on witmac (reasonably) up to date
    Job to create printer driver archive for install_driver
  install_printer.sh:
    Asks only once for admin password
    Downloads faster by taking all from cron job
    repeats possible with just script

Version 2.0
  gui_setup.sh
    Essentially the same as simple_setup.sh, but allows you to input arguments before execution
  WITup BETA
    GUI application to run gui_setup.sh
    Only allows for setup WITH data transfer
    Cannot enable filevault automatically
  WITup
    xcode directory to edit code for WITup application
    
Version 2.1
  WITup BETA
    Options for setup only and transfer only
  gui_setup_notransfer.sh
    Commented out the transfer section of setup. Used in WITup BETA setup only.
