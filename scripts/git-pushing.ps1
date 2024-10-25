. "$PSScriptRoot\utilities\common-utilities.ps1"

# Variables
Initialize-StartTime

# Git operations
Log-Event -event "GitPushStart" -message "Git push begin"

$branch = git symbolic-ref --short HEAD

$commitTypes = @("feat", "fix", "docs", "style", "refactor", "perf", "test", "ci", "build", "revert", "chore")

Write-Host "Select the commit type:" -ForegroundColor Yellow

$commitTypes | ForEach-Object { Write-Host "$_" }

do {
    $commitType = Read-Host "Enter commit type"

    if (-not ($commitTypes -contains $commitType)) {
        Write-Host "Invalid commit type. Please select from the list." -ForegroundColor Red
    }
} until ($commitTypes -contains $commitType)

$commitMessage = Read-Host "Enter commit message"

$fullCommitMessage = "${commitType}: ${commitMessage}"

Write-Host "Commit message: $fullCommitMessage" -ForegroundColor Green

Write-Host "Are you sure you want to push branch '$branch' with the following commit message: '$fullCommitMessage'?" -ForegroundColor Yellow

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
    Log-Event -level "WARNING" -event "GitPushCancel" -message "User cancelled the push operation"
    Write-Host "Push operation cancelled by user" -ForegroundColor Yellow
    exit 0
}

Log-Event -event "GitAdd" -message "Adding changes"

git add .

Log-Event -event "GitCommit" -message "Committing changes"

git commit -m $fullCommitMessage

Log-Event -event "GitPush" -message "Pushing changes"

git push origin $branch

if ($LASTEXITCODE -ne 0) {
    Log-Event -level "ERROR" -event "GitPushError" -message "Failed to push changes"
    exit 1
} else {
    Log-Event -event "GitPushSuccess" -message "Successfully pushed changes"
}

Log-Event -event "GitPushEnd" -message "Git push finished"

Calculate-Duration