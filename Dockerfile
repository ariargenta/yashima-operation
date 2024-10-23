# Development stage
FROM debian:stable-slim AS base
LABEL maintainer="55609849+ariargenta@users.noreply.github.com"

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    pkg-config \
    libx11-dev \
    libx11-xcb-dev \
    libfontenc-dev \
    libice-dev \
    libsm-dev \
    libxaw7-dev \
    libxmu-dev \
    libxpm-dev \
    libxt-dev \
    libxtst-dev \
    libxfixes-dev \
    libxi-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxrender-dev \
    libxcomposite-dev \
    libxcursor-dev \
    libxdamage-dev \
    libxext-dev \
    libxss-dev \
    uuid-dev \
    libglfw3-dev \
    libglew-dev \
    libglm-dev \
    python3-full \
    python3-venv && \
    python3 -m venv --help && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Virtual environment
RUN set -x && python3 -m venv /opt/venv

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN set -x && pip install --upgrade pip

RUN set -x && pip install conan

RUN set -x && conan profile detect

WORKDIR /app

COPY . .

# Ensure build and logs directories are created and have correct permissions
RUN set -x && \
    echo "Creating and setting permissions for /app/logs and /app/build" && \
    rm -rf /app/logs /app/build && mkdir -p /app/logs /app/build && \
    ls -ld /app/logs /app/build && \
    chown -R root:root /app && chmod -R 777 /app && \
    chown -R root:root /app/logs /app/build && chmod -R 777 /app/logs /app/build && \
    ls -ld /app/logs /app/build && ls -l /app/logs /app/build

# Debugging: Print ownership and permissions for /app/logs and /app/build
RUN echo "Printing ownership and permissions for /app/logs and /app/build" && \
    ls -ld /app/logs /app/build && ls -l /app/logs /app/build

# Run Conan install and print output directly
RUN set -x && \
    echo "Running conan install" && \
    conan install . --build=missing -c tools.system.package_manager:mode=install && \
    echo "Listing contents of /app" && \
    ls -alh /app && \
    echo "Listing contents of /app/build" && \
    ls -alh /app/build

# Find conan_toolchain.cmake
RUN echo "Finding conan_toolchain.cmake" && \
    find / -name "conan_toolchain.cmake"

# Print the contents of conan_toolchain.cmake
RUN echo "Printing conan_toolchain.cmake" && \
    cat /app/conan_toolchain.cmake || echo "conan_toolchain.cmake not found"

# Test write permissions to /app/build
RUN echo "Testing write permissions to /app/build" && \
    touch /app/build/testfile || (echo "Cannot write to /app/build" && exit 1)

# Debugging: Verify CMake configuration
RUN echo "Listing contents of /app/conan_toolchain.cmake" && \
    ls -alh /app/conan_toolchain.cmake && \
    echo "Running CMake configuration" && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug || echo "CMake configuration failed!" && \
    echo "Listing contents of /app/build" && \
    ls -alh /app/build && \
    echo "Listing contents of /app/build/CMakeFiles" && \
    ls -alh /app/build/CMakeFiles && \
    echo "Printing CMakeOutput.log" && \
    cat /app/build/CMakeFiles/CMakeOutput.log

# Verify if Makefile is generated
RUN echo "Verifying if Makefile is generated" && \
    if [ -f /app/build/Makefile ]; then \
        echo "Makefile found"; \
        echo "Printing Makefile" && \
        cat /app/build/Makefile; \
    else \
        echo "Makefile not found"; \
    fi

# Print CMakeLists.txt for verification
RUN echo "Printing CMakeLists.txt" && \
    cat /app/CMakeLists.txt

# Print CMakeError.log for additional debugging
RUN echo "Printing CMakeError.log" && \
    cat /app/build/CMakeFiles/CMakeError.log || echo "CMakeError.log not found"

CMD cd build && make