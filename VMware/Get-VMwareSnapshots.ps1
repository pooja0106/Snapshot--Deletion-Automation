
# Project: OS Upgrade Automation
# Script: Get-VMwareSnapshots.ps1
# Purpose: Retrieve VMware VM snapshots
# Retention: 74 Hours

# Connect to vCenter
$VCenter = "YOUR-VCENTER-NAME"

Connect-VIServer -Server $VCenter

# Retrieve all VM snapshots
$Snapshots = Get-VM | Get-Snapshot

# Display snapshot information
$Snapshots | Select-Object `
    VM,
    Name,
    Created,
    SizeGB

# Calculate 74-hour expiry time
$ExpiryTime = (Get-Date).AddHours(-74)

# Identify expired snapshots
$ExpiredSnapshots = $Snapshots |
    Where-Object {
        $_.Created -lt $ExpiryTime
    }

# Display expired snapshots
Write-Host "Snapshots older than 74 hours:" -ForegroundColor Yellow

$ExpiredSnapshots | Format-Table VM, Name, Created, SizeGB

# Disconnect from vCenter
Disconnect-VIServer -Server $VCenter -Confirm:$false
