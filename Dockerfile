# Base image
FROM debian:latest

# Dockerfile author / maintainer
LABEL maintainer="55609849+ariargenta@users.noreply.github.com"

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libglfw3-dev \
    libglew-dev \
    libgl1-mesa-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/yashima-operation

# Copy the files to the project container
COPY . .

# Build the project
RUN chmod +x build.sh && ./scripts/build.sh

# Set the entry point to run the binary
CMD ["./build/yashima-operation"]