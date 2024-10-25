if (-not (Test-Path $PSScriptRoot)) {
    Write-Host "Error: This script requires specific permissions to execute. Please adjust the permissions if necessary." -ForegroundColor Red
    exit 1
}

# Functions
function Get-KeyValue-Timestamp {
    return ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss"))
}

function Initialize-StartTime {
    $global:StartTime = Get-Date

}

function Calculate-Duration {
    param (
        [string]$eventName = "OperationDuration"
    )

    $endTime = Get-Date
    $duration = $endTime - $global:StartTime

    Log-Event -event $eventName  -message "Processing time: $($duration.TotalSeconds) seconds."
}

function Log-Event {
    param (
        [string]$level = "INFO",
        [string]$event,
        [string]$branch = $global:BRANCH_NAME,
        [string]$message
    )

    switch ($level) {
        "INFO" { $color = "Green" }
        "ERROR" { $color = "Red" }
        "WARNING" { $color = "Yellow" }
        default { $color = "White" }
    }

    $timestamp = Get-KeyValue-Timestamp

    Write-Host "timestamp=$timestamp level=$level event=$event branch=$branch message='$message'"
}