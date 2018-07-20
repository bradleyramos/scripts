@echo off
echo Must be run as admin from the command line to be useful (or work)
echo Needs full path (e.g. D:\Users\tae829) and must be run from an elevated (admin) command prompt
echo Always grants admin access to the files.
set /p path= Full Source Path:
set /p destPath= Full Destination Path:
C:\Windows\System32\icacls %path% /grant admin:(CI)(OI)(F) /T
mkdir %destPath%
C:\Windows\System32\robocopy %path% %destPath% /xj /e /r:0
pause
