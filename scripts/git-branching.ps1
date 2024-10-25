. "$PSScriptRoot/utilities/common-utilities.ps1"

# Variables
$branch = Read-Host "Enter the branch name you want to create and switch to"

Initialize-StartTime

# Git operations
$branchExists = git branch --list $branch

if ([string]::IsNullOrEmpty($branchExists)) {
    Log-Event -event "GitBranchCheck" -message "Branch $branch not found locally, checking remote..."
    
    $remoteBranchExists = git ls-remote --heads origin $branch

    if ([string]::IsNullOrEmpty($remoteBranchExists)) {
        Log-Event -level "ERROR" -event "GitBranchCheckError" -message "Branch $branch not found remotely"

        Write-Host "Error: Branch $branch does not exist locally or remotely" -ForegroundColor Red

        exit 1
    } else {
        Log-Event -event "GitBranchCreate" -message "Branch $branch found remotely. Creating branch locally."
        
        git fetch origin

        git checkout -b $branch origin/$branch
    }
} else {
    Log-Event -event "GitCheckout" -message "Switching to branch $branch."

    git checkout $branch
}

Log-Event -event "GitPull" -message "Pulling latest changes from $branch."

git pull origin $branch

Log-Event -event "GitOperationEnd" -message "Branch switch completed."

Calculate-Duration "GitSwitchDuration"