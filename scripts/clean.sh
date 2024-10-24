#!/bin/bash

# Path definitions
SCRIPT_DIR=$(dirname "$0")
BUILD_DIR="$SCRIPT_DIR/build"
LOGS_DIR="$SCRIPT_DIR/logs"

# Cleanup compilation directories
start_time=$(date +%s)
echo "Cleaning up compilation directories..."

if [ -d "$BUILD_DIR" ]; then
    echo "Removing 'build' directory..."
    rm -rf "$BUILD_DIR"
fi

if [ -d "$LOGS_DIR" ]; then
    echo "Removing 'logs' directory..."
    rm -rf "$LOGS_DIR"
fi

end_time=$(date +%s)

duration=$((end_time - start_time))

echo "Successfully cleaned up directories in $duration seconds. [ $(date) ]"