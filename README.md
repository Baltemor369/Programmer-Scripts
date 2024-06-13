# Script Batch

A repository to push some useful scripts for git, python or java projects.

## Features

All script have a -help to explain you the command if arguments can be asked.
You can launch a script with the CMD or the folder explorer, arguments will always be requested if necssary.

You can get this scripts as Powershell command (like cd, del, etc, avaible every where and every time). 
Download "Microsoft.PowerShell_profile.ps1" and put it in this directory: C:/Users/$username/Documents/WindowsPowerShell/

## Issues

1. If you can't run scripts, it's because you have to change ExecutionPolicy on your computer, so run a powershell as admin and enter this : 

```
Get-ExecutionPolicy
```
That gives you your current policy. 

If you have "Restricted", you have to change it into another state like "RemoteSigned" :

```
Set-ExecutionPolicy RemoteSigned
```
