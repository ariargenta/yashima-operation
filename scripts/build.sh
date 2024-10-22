#!/bin/bash

SCRIPTS_DIR="${PWD}/scripts"

echo "Cleaning previous build artifats..."

${SCRIPTS_DIR}/clean.sh

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

if [ -d "build" ]; then
    echo "'build' directory  already exists."
else
    mkdir -p build
    echo "'build' directory created."
fi

cd build

conan install .. --build=missing

if [ -d "../logs" ]; then
    echo "'logs' directory already exists."
else
    mkdir -p ../logs
    echo "'logs' directory created."
fi

cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} ..

make 2>&1 | tee ../logs/build.log

if [ $? -ne 0 ]; then
    echo "Error during compilation process. Please review the \"${PWD}/logs/build.log\" file for more details."
    exit 1
else
    echo "Successfully binary compilation in ${BUILD_TYPE} mode."
fi