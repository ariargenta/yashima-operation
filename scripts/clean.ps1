# Path definitions
$BUILD_DIR = Join-Path -Path $PSScriptRoot -ChildPath "build"
$LOGS_DIR = Join-Path -Path $PSScriptRoot -ChildPath "logs"

# Clean up compilation directories
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

$duration = $endTime - $startTime

Write-Output "Successfully cleaned up directories in $(duration.TotalSeconds) seconds. [ $endTime ]"