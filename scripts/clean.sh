#!/bin/bash

echo "Cleaning up..."

# Directory existence verification
if [ -d "build" ]; then
    echo "Removing build directory..."
    rm -rf build
else
    echo "Build directory does not exist."
fi

if [ -d "bin" ]; then
    echo "Removing binary files..."
    rm -rf bin/*
else
    echo "Binary files not founded."
fi

if [ -d "bin" ]; then
    echo "Removing binary files..."
    rm -rf bin/*
else
    echo "Binary files not found."
fi

if [ -d "logs" ]; then
    echo "Removing logs directory..."
    rm -rf logs
else
    echo "Logs directory does not exist."
fi

# Log removing
echo "Removing log files..."
find . -name "*.log" -type f -exec rm -f {} +

echo "Cleaning process finished."