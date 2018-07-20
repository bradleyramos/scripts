@echo off
echo Must be run as admin from the command line to be useful (or work)
echo Needs full path (e.g. D:\Users\tae829) and must be run from an elevated (admin) command prompt
echo Always grants admin access to the files. Use quotation marks if there are spaces (There shouldn't be)
set /p path= Full Source Path:
echo DO NOT MAKE THE DESTINATION THE USER'S HOME directory
echo This will never work. e.g. Do not type in C:\Users\tae829, instead try C:\Users\Transfer
echo and move the files yourself.
set /p destPath= Full Destination Path:
C:\Windows\System32\icacls %path% /grant admin:(CI)(OI)(F) /T
mkdir %destPath%
C:\Windows\System32\robocopy %path% %destPath% /xj /e /r:0
pause
