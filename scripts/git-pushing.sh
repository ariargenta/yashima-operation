#!/bin/bash

# Variables
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# Push changes to current branch
read -p "Enter commit message: " COMMIT_MESSAGE

if [ -z "$COMMIT_MESSAGE" ]; then
    echo "Error: Commit message is required."
    exit 1
fi

git add .
git commit -m "${COMMIT_MESSAGE}"
git push origin "$BRANCH_NAME"

# Check if the push was successful
if [ $? -ne 0 ]; then
    echo "Error while pushing to branch: ${BRANCH_NAME}"
    exit 1
else
    echo "Changes pushed successfully to branch: ${BRANCH_NAME}"
fi