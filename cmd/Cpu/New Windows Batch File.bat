@echo off

:: ปิดบริการ Windows Error Reporting
sc config WerSvc start= disabled
net stop WerSvc

:: ปิด Remote Assistance เพื่อไม่ให้ทำงานพื้นหลัง
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f

:: ปิดการทำงานของ Superfetch และ SysMain เพื่อประหยัดทรัพยากร
sc config SysMain start= disabled
net stop SysMain

:: ลดเวลาในการโหลด DLL ให้เร็วขึ้น
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AlwaysUnloadDll" /t REG_SZ /d 1 /f

:: ปิดการทำงานของ Windows Defender Antivirus
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f

:: ตั้งค่า Timeout ต่ำสุดเพื่อให้โหลดบริการที่จำเป็นเท่านั้น
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 100 /f
reg add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_SZ /d 0 /f

:: ลบไฟล์ชั่วคราวที่ไม่จำเป็น
rd /s /q %temp%
rd /s /q C:\Windows\Temp
