# ปิดใช้งานบริการ 'Windows Update'
Stop-Service -Name 'wuauserv' -Force
Set-Service -Name 'wuauserv' -StartupType Disabled

# ปิดใช้งานบริการ 'Delivery Optimization'
Stop-Service -Name 'DoSvc' -Force
Set-Service -Name 'DoSvc' -StartupType Disabled

# ปิดใช้งานบริการ 'Background Intelligent Transfer Service'
Stop-Service -Name 'BITS' -Force
Set-Service -Name 'BITS' -StartupType Disabled

# ปิดใช้งานบริการ 'Remote Registry'
Stop-Service -Name 'RemoteRegistry' -Force
Set-Service -Name 'RemoteRegistry' -StartupType Disabled

# ปิดใช้งานบริการ 'Windows Error Reporting'
Stop-Service -Name 'WerSvc' -Force
Set-Service -Name 'WerSvc' -StartupType Disabled

# ปิดใช้งานบริการ 'Diagnostic Policy Service'
Stop-Service -Name 'DPS' -Force
Set-Service -Name 'DPS' -StartupType Disabled

# ปิดใช้งานบริการ 'Program Compatibility Assistant Service'
Stop-Service -Name 'PcaSvc' -Force
Set-Service -Name 'PcaSvc' -StartupType Disabled

# ปิดใช้งานบริการ 'Windows Search'
Stop-Service -Name 'WSearch' -Force
Set-Service -Name 'WSearch' -StartupType Disabled
# ปิดใช้งานบริการ 'Connected User Experiences and Telemetry'
Stop-Service -Name 'DiagTrack' -Force
Set-Service -Name 'DiagTrack' -StartupType Disabled

# ปิดใช้งานบริการ 'dmwappushsvc'
Stop-Service -Name 'dmwappushservice' -Force
Set-Service -Name 'dmwappushservice' -StartupType Disabled

# ปิดใช้งาน 'Windows Error Reporting'
Stop-Service -Name 'WerSvc' -Force
Set-Service -Name 'WerSvc' -StartupType Disabled

# ปิดใช้งาน 'Remote Registry'
Stop-Service -Name 'RemoteRegistry' -Force
Set-Service -Name 'RemoteRegistry' -StartupType Disabled

# ปิดใช้งาน 'Windows Update'
Stop-Service -Name 'wuauserv' -Force
Set-Service -Name 'wuauserv' -StartupType Disabled

# ปิดใช้งาน 'Delivery Optimization'
Stop-Service -Name 'DoSvc' -Force
Set-Service -Name 'DoSvc' -StartupType Disabled

# ปิดใช้งาน 'Background Intelligent Transfer Service'
Stop-Service -Name 'BITS' -Force
Set-Service -Name 'BITS' -StartupType Disabled

# ปิดใช้งาน 'Superfetch'
Stop-Service -Name 'SysMain' -Force
Set-Service -Name 'SysMain' -StartupType Disabled
# ปิดใช้งานบริการที่ไม่จำเป็น
$services = @(
    'DiagTrack', # Connected User Experiences and Telemetry
    'dmwappushservice', # dmwappushsvc
    'WSearch', # Windows Search
    'SysMain' # Superfetch
)

foreach ($service in $services) {
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service -Name $service -ErrorAction SilentlyContinue
}
