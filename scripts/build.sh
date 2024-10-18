#!/bin/bash

# Build directory creation
mkdir -p build && cd build

# Install dependencies using conan
conan install .. --build=missing

# Configure the project with CMake
cmake ..
make

# Verify the compilation status
if [ $? -ne 0 ]; then
    echo "Error during build process."
    exit 1
else
    echo "Build process completed successfully."
fi