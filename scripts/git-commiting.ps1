. "$PSScriptRoot\utilities\common-utilities.ps1"

# Variables
Initialize-StartTime
$COMMIT_TYPES = @("build", "chore", "ci", "docs", "feat", "fix", "merge", "ops", "perf", "revert", "refactor", "style", "test")

# Git operations
Log-Event -event "GitCommitStart" -message "Git commit begin"
$branch = git symbolic-ref --short HEAD
$commitTypesString = $COMMIT_TYPES -join ", "
Write-Host "Select the commit type: [$commitTypesString]" -ForegroundColor Yellow

do {
    $commitType = Read-Host "Enter commit type"

    if (-not ($COMMIT_TYPES -contains $commitType)) {
        Write-Host "Invalid commit type. Please select from the list." -ForegroundColor Red
    }
} until ($COMMIT_TYPES -contains $commitType)

do {
    $commitMessage = Read-Host "Enter commit message"

    if ([string]::IsNullOrEmpty($commitMessage)) {
        Write-Host "Commit message cannot be empty" -ForegroundColor Red
    }
} until (-not [string]::IsNullOrEmpty($commitMessage))

$fullCommitMessage = "${commitType}: ${commitMessage}"
Write-Host "Are you sure you want to push branch '$branch' with the following commit message '$fullCommitMessage'?" -ForegroundColor Yellow
$confirmation = Read-Host "Enter 'Y/y' to confirm or 'N/n' to cancel"

switch ($confirmation) {
    "Y" { $CONFIRMED = $true }
    "y" { $CONFIRMED = $true }
    "N" { $CONFIRMED = $false }
    "n" { $CONFIRMED = $false }
    default {
        Write-Host "Invalid input. Please enter 'Y/y' to confirm or 'N/n' to cancel" -ForegroundColor Red
    }
}

if (-not $CONFIRMED) {
    Log-Event -level "WARNING" -event "GitCommitCancel" -message "User cancelled the commit operation"
    Write-Host "Commit operation cancelled by user" -ForegroundColor Yellow
    exit 0
}

Log-Event -event "GitAdd" -message "Adding changes"
git add .
Log-Event -event "GitCommit" -message "Committing changes"
git commit -m $fullCommitMessage
Log-Event -event "GitCommitEnd" -message "Git commit finished"
Calculate-Duration