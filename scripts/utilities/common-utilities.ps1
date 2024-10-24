# Functions
function Get-KeyValue-Timestamp {
    return ((Get-Date).ToString("yyyy-MM-dd HH:mm:ss"))
}

function Log-event {
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