# STEP 1: Base image
FROM debian:stable-slim AS base
LABEL maintainer="55609849+ariargenta@users.noreply.github.com"

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    wget \
    libglfw3-dev \
    libglew-dev \
    libglm-dev \
    python3-venv && \
    python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install conan && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# STEP 2: Development environment
FROM base AS development
ARG BUILD_TESTS=on
WORKDIR /app
COPY . .

# Dev build & testing execution
RUN . /opt/venv/bin/activate && conan --version \
    conan install . --build=missing && \
    mkdir build && \
    cd build \
    && cmake .. -DBUILD_TESTS=${BUILD_TESTS} && \
    make

RUN if [ "${BUILD_TESTS}" = "ON" ]; then ctest; fi

# STEP 3: Staging environment
FROM base AS staging
ARG BUILD_MODE=Release
ENV STAGING=true
WORKDIR /app
COPY . .

# Release build
RUN mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=${BUILD_MODE} && make

# Diagnosis tools
RUN apt-get update && apt-get install -y gdb valgrind && apt-get clean

# STEP 4: Production environment
FROM base AS production
WORKDIR /app
COPY --from=staging /app/build /app/build

# Entry point to run the binary
CMD ["./build/yashima-operation"]