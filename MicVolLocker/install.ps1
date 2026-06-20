# Run this script as Administrator to install MicVolLocker as a Scheduled Task
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($scriptDir -eq "") { $scriptDir = "." }
$exePath = Join-Path $scriptDir "MicVolLocker.exe"

if (-not (Test-Path $exePath)) {
    Write-Host "Error: MicVolLocker.exe not found in $scriptDir" -ForegroundColor Red
    return
}

# Stop existing process if running
Stop-Process -Name "MicVolLocker" -Force -ErrorAction SilentlyContinue

$action = New-ScheduledTaskAction -Execute $exePath
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Days 0)

Register-ScheduledTask -TaskName "MicVolLocker" -Action $action -Trigger $trigger -Settings $settings -Force
Start-ScheduledTask -TaskName "MicVolLocker"

Write-Host "MicVolLocker has been successfully registered and started as a Scheduled Task!" -ForegroundColor Green
