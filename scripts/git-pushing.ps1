. "$PSScriptRoot\utilities\common-utilities.ps1"

# Variables
$global:startTime = Get-Date
$global:BRANCH_NAME = git symbolic-ref --short HEAD
$startTime = Get-KeyValue-Timestamp

# Git operations
Log-Event -event "GitOperationStart" -message "Operation started"

$COMMIT_MESSAGE = Read-Host "Please enter commit message"

if([string]::IsNullOrEmpty($COMMIT_MESSAGE)) {
   Log-Event -level "ERROR" -event "GitCommitError" -message "Commit message not provided"
    exit 1
}

Log-Event -event "GitAdd" -message "Adding changes"

git add .

Log-Event -event "GitCommit" -message "Committing changes"

git commit -m $COMMIT_MESSAGE

Log-Event -event "GitPush" -message "Pushing changes"

git push origin $global:BRANCH_NAME

if ($LASTEXITCODE -ne 0) {
    Log-Event -level "ERROR" -event "GitPushError" -message "Failed to push changes"
    exit 1
} else {
    Log-Event -event "GitPushSuccess" -message "Successfully pushed changes"
}

Log-Event -event "GitPushSuccess" -message "Operation ended"

$duration = (Get-Date) - (Get-Date $global:startTime)

Log-Event -event "GitOperationDuration" -message "Processing time: $($duration.TotalSeconds) seconds."