#!/bin/bash

IMAGE_NAME="yashima-operation"

if ! command -v docker &> /dev/null
then
    echo "Docker could not be found. Please install Docker before running this script."
    exit 1
else
    echo "Building Docker image..."
fi

if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "Docker image '$IMAGE_NAME' not found. Building the image..."

    docker build -t $IMAGE_NAME .
    
    if [ $? -ne 0 ]; then
        echo "Error occurred during Docker image build."
        exit 1
    fi
else
    echo "Docker image '$IMAGE_NAME' already exists."
fi

echo "Running Docker container..."

docker run --rm $IMAGE_NAME

if [ $? -ne 0 ]; then
    echo "Error occurred while running the Docker container."
    exit 1
else
    echo "Docker container ran successfully."
fi