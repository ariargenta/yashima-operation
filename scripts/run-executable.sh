#!/bin/bash

# Variables
BUILD_FOLDER="build"
EXECUTABLE="${BUILD_FOLDER}/yashima-operation"
LOG_FOLDER="logs"
LOG_FILE="${LOG_FOLDER}/yashima-operation.log"

# Verify if executable exists
if [ ! -f "${EXECUTABLE}" ]; then
    echo "Executable not found: ${EXECUTABLE}"
    exit 1
fi

# Binary execution
${EXECUTABLE} > ${LOG_FILE} 2>&1

if [ $? -ne 0 ]; then
    echo "Error while executing binary: ${EXECUTABLE}, please check the logs"
    
    if [ -f "${LOG_FILE}" ]; then
        cat "${LOG_FILE}"

    else
        echo "Log file not found: ${LOG_FILE}"
    fi
else
    echo "Binary executed successfully: ${EXECUTABLE}"
fi