#!/bin/bash

BUILD_DIR="${PWD}/build"
LOGS_DIR="${PWD}/logs"

echo "Cleaning up..."

if [ -d "${BUILD_DIR}" ]; then
    echo "Removing 'build' directory..."
    rm -rf ${BUILD_DIR}
fi

if [ -d "${LOGS_DIR}" ]; then
    echo "Removing 'logs' directory..."
    rm -rf ${LOGS_DIR}
fi

echo "Cleanup completed."