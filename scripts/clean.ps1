. "$PSScriptRoot\utilities\common-utilities.ps1"

# Variables
$parentDir = Split-Path $PSScriptRoot -Parent
$build_dir = Join-Path $parentDir "build"
$logs_dir = Join-Path $parentDir "logs"

# Clean up previous compilation folders
$startTime = Get-Date
Write-Output "Cleaning up compilation directories. [ $startTime ]"

if(Test-Path $BUILD_DIR) {
    Write-Output "Removing build directory..."
    Remove-Item -Recurse -Force $BUILD_DIR
}

if(Test-Path $LOGS_DIR) {
    Write-Output "Removing logs directory..."
    Remove-Item -Recurse -Force $LOGS_DIR
}

$endTime = Get-Date

Calculate-Duration