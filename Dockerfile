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
RUN python3 -m venv /opt/venv

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install --upgrade pip

RUN pip install conan

RUN conan profile detect

WORKDIR /app

COPY . .

RUN rm -rf /app/logs /app/build && mkdir -p /app/logs /app/build && \
    chown -R root:root /app && chmod -R 777 /app && \
    chown -R root:root /app/logs /app/build && chmod -R 777 /app/logs /app/build

# Debugging
RUN ls -ld /app/logs /app/build && ls -l /app/logs /app/build

RUN conan install . --build=missing -c tools.system.package_manager:mode=install > /app/logs/conan_install.log 2>&1

# Print the last 100 lines of the Conan install log
RUN tail -n 100 /app/logs/conan_install.log

# Check if conan_paths.cmake exists
RUN ls -alh /app && ls -alh /app/build && test -f /app/build/conan_paths.cmake || (echo "conan_paths.cmake not found" && exit 1)

# Find conan_paths.cmake
RUN find / -name "conan_paths.cmake"

# Print the contents of conan_paths.cmake
RUN cat /app/build/conan_paths.cmake

# Print the entire Conan install log
RUN cat /app/logs/conan_install.log

# Test write permissions to /app/build
RUN touch /app/build/testfile || (echo "Cannot write to /app/build" && exit 1)

CMD cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug && make

RUN [ -d "/app/build" ] || mkdir /app/build