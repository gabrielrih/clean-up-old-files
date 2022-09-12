# clean-up-old-files
Automation to clean old files on a list of folders.

## How to use it?
```
.\clean.ps1 -DaysBack -15 -Pathes "C:\temp", "$HOME\Desktop\temp"
```

## Task Scheduler
On Windows, you can schedule the execution:
```
PowerShell -File C:\automation-scripts\clean.ps1 -Pathes "C:\Users\myUsers\Desktop\temp"
```
