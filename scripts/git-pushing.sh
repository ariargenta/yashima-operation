#!/bin/bash

# Variables
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# Prompt for commit message
read -p "Enter commit message: " COMMIT_MESSAGE

# Verify if a commit message was provided
if [ -z "$COMMIT_MESSAGE" ]; then
    echo "Error: Commit message is required."
    exit 1
fi

# Stage all changes
git add .

# Commit changes
git commit -m "${COMMIT_MESSAGE}"

# Push changes to the current branch
git push origin "$BRANCH_NAME"

# Check if the push was successful
if [ $? -ne 0 ]; then
    echo "Error while pushing to branch: ${BRANCH_NAME}"
    exit 1
else
    echo "Changes pushed successfully to branch: ${BRANCH_NAME}"
fi