. "$PSScriptRoot/utilities/common-utilities.ps1"

# Variables
Initialize-StartTime

# Git operations
Log-Event -event "GitMergeStart" -message "Git merge begin"
$sourceBranch = git symbolic-ref --short HEAD
$destinationBranch = Read-Host "Enter the destination branch"
Log-Event -event "GitCheckout" -message "Switching to $destinationBranch"
git checkout $destinationBranch
Log-Event -event "GitPull" -message "Pulling latest changes from $destinationBranch"
git pull origin $destinationBranch
Log-Event "GitMerge" -message "Merging $sourceBranch into $destinationBranch"
git merge --no-ff $sourceBranch

if ($LASTEXITCODE -ne 0) {
    Log-Event -level "ERROR" -event "GitMergeError" -message "Merge conficts occurred"
    Write-Host "Merge conflicts detected. Please resolve them manually." -ForegroundColor Red
    exit 1
} else {
    Log-Event -event "GitMergeSuccess" -message "Successfully merged $sourceBranch into $destinationBranch"
}

Log-Event -event "GitMergeEnd" -message "Git merge finished"
Calculate-Duration