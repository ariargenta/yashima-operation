#!/bin/bash

SCRIPTS_DIR="${PWD}/scripts"

if [ ! -d "build" ] && [ ! -d "logs" ]; then
    echo "No build artifacts found. Nothing to clean."
    exit 0
else
    echo "Cleaning previous build artifacts..."
    ${SCRIPTS_DIR}/clean.sh || { echo "Error occurred while cleaning build artifacts."; exit 1; }
fi

echo "Select build type:"
echo "D: Debug"
echo "R: Release"
echo "I: RelWithDebInfo"

read -p "(default debug) [D/R/I]:" CHOICE

case "$CHOICE" in
    "" ) BUILD_TYPE="Debug";;
    D|d) BUILD_TYPE="Debug";;
    R|r) BUILD_TYPE="Release";;
    I|i) BUILD_TYPE="RelWithDebInfo";;
    *) echo "Invalid choice. Please select D, R, or I."; exit 1;;
esac

if [ ! -d "build" ] || [ ! -d "logs" ]; then
    mkdir -p build logs
    echo "'build' and 'logs' directories created."
fi

cd build

cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} .. || { echo "Error: CMake configuration failed"; exit 1; }

make 2>&1 | tee ../logs/build.log

if [ $? -ne 0 ]; then
    echo "Error occurred during build. Please check \"${$PWD}/logs/build.log\" for more details."
    exit 1
else
    echo "Successfully compiled binaries in ${BUILD_TYPE} mode."
fi