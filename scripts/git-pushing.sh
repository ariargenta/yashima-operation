#!/bin/bash

echo "Pushing to git..."

# Add all files to git
git add .

# Request commit message
echo "Please, enter the commit message:"
read commit_message

# Commit all files
git commit -m "$commit_message"

# Get the current branch
current_branch=$(git branch --show-current)

# Push to the current branch
if [ -z "$current_branch" ]; then
    echo "Error: Could not get the current branch."
    exit 1
fi

git push -u origin "$current_branch"

if [ $? -eq 0 ]; then
    echo "Pushed to git successfully in the branch: $current_branch"
else
    echo "Error: Could not push to git."
    exit 1
fi