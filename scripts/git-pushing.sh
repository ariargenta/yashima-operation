#!/bin/bash

source "./utilities/common-utilities.sh"

# Variables
start_time=$(date +%s)
branch_name=$(git symbolic-ref --short HEAD)
start_time_readable=$(get_keyvalue_timestamp)

# Git operations
log_event "INFO" "GitOperationStart" "$branch_name" "Operation started"

read -p "Please enter commit message: " commit_message

if [ -z "$commit_message" ]; then
    log_event "ERROR" "GitCommitError" "$branch_name" "Commit message not provided"
    exit 1
fi

log_event "INFO" "GitAdd" "$branch_name" "Adding changes"

git add .

log_event "INFO" "GitCommit" "$branch_name" "Committing changes"

git commit -m "${COMMIT_MESSAGE}"

log_event "INFO" "GitPush" "$branch_name" "Pushing changes"

git push origin "$branch_name"

if [ $? -ne 0 ]; then
    log_event "ERROR" "GitPushError" "$branch_name" "Failed to push changes"
    exit 1
else
    log_event "INFO" "GitPushSuccess" "$branch_name" "Successfully pushed changes"
fi

log_event "INFO" "GitPushSuccess" "$branch_name" "Operation ended"

end_time=$(date +%s)
duration=$((end_time - start_time))

log_event "INFO" "GitOperationDuration" "$branch_name" "Processing time: $duration seconds."