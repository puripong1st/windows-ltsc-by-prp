@echo off
title Windows LTSC Activation By PRP
color 70
mode con: cols=79 lines=20

cscript.exe %windir%\system32\slmgr.vbs /rilc
cscript.exe %windir%\system32\slmgr.vbs /upk >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /ckms >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /cpky >nul 2>&1
cscript.exe %windir%\system32\slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
cscript.exe %windir%\system32\slmgr.vbs /skms kms9.msguides.com
cscript.exe %windir%\system32\slmgr.vbs /ato 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /t REG_SZ /d "PRP | Windows LTSC" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /t REG_SZ /d "PRP | Windows LTSC | 1.0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportURL" /t REG_SZ /d "https://discord.gg/eHMmneSs3c" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportPhone" /t REG_SZ /d "https://github.com/puripong1st" /f

bcdedit /set {current} description "PRP | Windows LTSC | 1.0"


call set /p menu="You need to restart (Y/N):"

if %menu%==Y goto :start
if %menu%==y goto :start  
if %menu%==N goto :terminate
if %menu%==n goto :terminate
if %menu%==exit goto :terminate  
cls && echo Unknown Input Detected Please Use Correct Input. && timeout 3 >nul && cls 

:start
shutdown.exe /r /t 00

:terminate
exit
