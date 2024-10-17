# Base image
FROM debian:latest

# Dockerfile author / maintainer
LABEL maintainer="55609849+ariargenta@users.noreply.github.com"

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    libglfw3-dev \
    libglew-dev \
    libglm-dev \

# Set the working directory
WORKDIR /app

# Copy the files to the project container
COPY . .

# Build the project
RUN mkdir build && cd build && cmake .. && make

# Execute unit tests
RUN cd build && ctest --output-on-failure

# Set the entry point to run the binary
CMD ["./build/yashima-operation"]