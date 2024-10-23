#!/bin/bash

IMAGE_NAME="yashima-operation-image"
CONTAINER_NAME="yashima-operation-container"

if ! command -v docker &> /dev/null; then
    echo "Docker could not be found. Please install Docker before running this script."
    exit 1
else
    echo "Building Docker image..."
fi

if [ "$(docker images -q $IMAGE_NAME)" ]; then
    echo "Deleting pre-existing Docker image '$IMAGE_NAME'..."
    docker rmi $IMAGE_NAME

    if [ $? -ne 0 ]; then
        echo "Error occurred while deleting pre-existing Docker image."
        exit 1
    fi
fi

echo "Building Docker image '$IMAGE_NAME'..."

docker build -t $IMAGE_NAME .

if [ $? -ne 0 ]; then
    echo "Error occurred while building Docker image."
    exit 1
else
    echo "Docker image '$IMAGE_NAME' built successfully."
fi

docker run --name $CONTAINER_NAME --rm -v "$(pwd)/logs:/app/logs" -v "$(pwd)/build:/app/build" $IMAGE_NAME

docker exec $CONTAINER_NAME sh -c "touch /app/logs/testfile && touch /app/build/testfile && echo 'Permissions check passed' || echo 'Permissions check failed'"

docker exec $CONTAINER_NAME rm -f /app/logs/testfile /app/build/testfile

if [ $? -ne 0 ]; then
    echo "Error occurred while running Docker container."
    exit 1
else
    echo "Docker container '$CONTAINER_NAME' ran successfully."
fi