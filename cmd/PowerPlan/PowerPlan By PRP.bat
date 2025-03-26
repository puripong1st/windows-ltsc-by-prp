powercfg -import "PowerPlan By PRP.pow"
powercfg -setacvalueindex scheme_current sub_processor 11111111-1111-1111-1111-111111111111 1
powercfg -setactive scheme_current

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /t REG_SZ /d "PRP" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Model" /t REG_SZ /d "PRP | Boost FPS CMD | 1.0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportURL" /t REG_SZ /d "https://discord.gg/eHMmneSs3c" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "SupportPhone" /t REG_SZ /d "https://github.com/puripong1st" /f

bcdedit /set {current} description "PRP | Boost FPS CMD | 1.0"
