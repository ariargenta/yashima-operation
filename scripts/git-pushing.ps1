. "$PSScriptRoot\utilities\common-utilities.ps1"

# Variables
Initialize-StartTime

# Git operations
Log-Event -event "GitPushStart" -message "Git push begin"
$currentBranch = git symbolic-ref --short HEAD
git push origin $currentBranch

if ($LASTEXITCODE -ne 0) {
    Log-Event -level "ERROR" -event "GitPushError" -message "Failed to push changes"
    exit 1
} else {
    Log-Event -event "GitPushSuccess" -message "Successfully pushed changes"
}

Log-Event -event "GitPushEnd" -message "Git push finished"
Calculate-Duration