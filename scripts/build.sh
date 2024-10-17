#!/bin/bash

# Define route to root directory
PROJECT_ROOT="$(dirname "$(dirname "$(realpath "$0")")")"

# Clean the build directory
if [ -d "$PROJECT_ROOT/build" ]; then
    echo "Cleaning the build directory..."
    rm -rf "$PROJECT_ROOT/build"
fi

# Create the build directory
mkdir "$PROJECT_ROOT/build"

# Configurate the project with CMake
echo "Configuring the project with CMake..."
cmake -S "$PROJECT_ROOT" -B "$PROJECT_ROOT/build" -DCMAKE_BUILD_TYPE=Debug

# Compile the project with CMake
cd "$PROJECT_ROOT/build"

if [ $? -eq 0 ]; then
    echo "Compiling the project with CMake..."
    make
else
    echo "Error configuring the project with CMake."
    exit 1
fi