. "$PSScriptRoot/utilities/common-utilities.ps1"

# Variables
$sourceBranch = Read-Host "Enter the source branch:"
$destinationBranch = Read-Host "Enter the destination branch:"

# Git operations
Initialize-StartTime

Log-Event -event "GitCheckout" -message "Switching to $destinationBranch"

git checkout $destinationBranch

Log-Event -event "GitPull" -message "Pulling latest changes from $destinationBranch"

git pull origin $destinationBranch

Log-Event "GitMerge" -message "Merging $sourceBranch into $destinationBranch"

git merge $sourceBranch

if ($LASTEXITCODE -ne 0) {
    Log-Event -level "ERROR" -event "GitMergeError" -message "Merge conficts occurred"
    Write-Host "Merge conflicts detected. Please resolve them manually." -ForegroundColor Red
    exit 1
} else {
    Log-Event -event "GitMergeSuccess" -message "Successfully merged $sourceBranch into $destinationBranch"
}

Log-Event -event "GitPush" -message "Pushing merged changes to origin/$destinationBranch"

git push origin $destinationBranch

Log-Event -event "GitOperationEnd" -message "Merge operation completed"

Calculate-Duration -event "GitMergeDuration"