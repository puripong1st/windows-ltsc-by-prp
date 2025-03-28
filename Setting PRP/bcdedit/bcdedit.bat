cd C:\Windows\system32
bcdedit /export C:\bcd_backup

bcdedit / deletevalue useplatformclock
bcdedit /deletevalue disabledynamictick
bcdedit /set useplatformtick Yes
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set firstmegabytepolicy UseAll
bcdedit /set avoidlowmemory 0x8000000
bcdedit /set nolowmem yes
bcdedit /set x2apicpolicy Enable
bcdedit /set configaccesspolicy Default
bcdedit /set MSI Default
bcdedit /set usephysicaldestination No
bcdedit /set usefirmwarepcisettings No
bcdedit /set allowedinmemorysettings 0x0
bcdedit /set isolatedcontext No
bcdedit /set vsmlaunchtype Off
bcdedit /set vm No
bcdedit /set disableelamdrivers Yes
bcdedit /set pae ForceEnable
bcdedit /set nx optout
bcdedit /set highestmode Yes
bcdedit /set forcefipscrypto No
bcdedit /set noumex Yes
bcdedit /set uselegacyapicmode No
bcdedit /set ems No
bcdedit /set extendedinput Yes
bcdedit /set debug No
bcdedit /set hypervisorlaunchtype Off
