
# Project: OS Upgrade Automation
# Script: Get-HyperVCheckpoints.ps1
# Purpose: Retrieve Hyper-V VM checkpoints

# Define Hyper-V host
$HyperVHost = "YOUR-HYPERV-HOST"

# Get all VM checkpoints
$Checkpoints = Get-VM -ComputerName $HyperVHost |
    Get-VMSnapshot

# Display checkpoint information
$Checkpoints | Select-Object `
    VMName,
    Name,
    CreationTime

# Identify checkpoints older than 74 hours
$ExpiryTime = (Get-Date).AddHours(-74)

$ExpiredCheckpoints = $Checkpoints |
    Where-Object {
        $_.CreationTime -lt $ExpiryTime
    }

Write-Host "Checkpoints older than 74 hours:" -ForegroundColor Yellow

$ExpiredCheckpoints | Format-Table VMName, Name, CreationTime
