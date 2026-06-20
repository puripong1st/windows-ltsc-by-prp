# Run this script as Administrator to uninstall MicVolLocker
Stop-Process -Name "MicVolLocker" -Force -ErrorAction SilentlyContinue
Unregister-ScheduledTask -TaskName "MicVolLocker" -Confirm:$false -ErrorAction SilentlyContinue

Write-Host "MicVolLocker Scheduled Task has been removed." -ForegroundColor Green
