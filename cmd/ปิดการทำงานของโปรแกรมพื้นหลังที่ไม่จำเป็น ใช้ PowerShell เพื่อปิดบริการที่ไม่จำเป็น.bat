Get-Service | Where-Object { $_.StartType -eq "Automatic" -and $_.Status -eq "Running" } | Stop-Service
