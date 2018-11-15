rm C:\WIT_space_usage.txt
echo "Applications Usage ----------------------------------------" > C:\WIT_space_usage.txt
(Get-ChildItem -directory "C:\Program Files" | ForEach-Object {echo (("$($_.FullName)") + ": " + "{0:N2} MB" -f ((Get-ChildItem "$($_.FullName)" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB))}) >> C:\WIT_space_usage.txt
(Get-ChildItem -directory "C:\Program Files (x86)" | ForEach-Object {echo (("$($_.FullName)") + ": " + "{0:N2} MB" -f ((Get-ChildItem "$($_.FullName)" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB))}) >> C:\WIT_space_usage.txt
echo "Users Usage -----------------------------------------------" >> C:\WIT_space_usage.txt
(Get-ChildItem -directory -depth 1 C:\Users | ForEach-Object {echo (("$($_.FullName)") + ": " + "{0:N2} MB" -f ((Get-ChildItem "$($_.FullName)" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB))}) >> C:\WIT_space_usage.txt
