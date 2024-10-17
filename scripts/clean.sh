#!/bin/bash

echo "Cleaning up..."

# Verify if the build directory exists
if [ -d "build" ]; then
    echo "Removing build directory..."
    rm -rf build
else
    echo "Build directory does not exist."
fi

# Verify if there are binary files
if [ -d "bin" ]; then
    echo "Removing binary files..."
    rm -rf bin/*
else
    echo "Binary files not founded."
fi

# Verify if there are log files
echo "Removing log files..."
find . -name "*.log" -type f -exec rm -f {} +
echo "Cleaning process finished."