reg add "HKCU\Software\Microsoft\Windows\Dwm" /v "EnableMMCSS" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\Dwm" /v "MaxMemoryForColorCache" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f
