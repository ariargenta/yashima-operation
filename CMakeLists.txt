cmake_minimum_required(VERSION 3.25)

project(yashima-operation VERSION 1.0.0 LANGUAGES CXX)

if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan_toolchain.cmake")
    message(FATAL_ERROR "conan_toolchain.cmake not found!")
endif()

include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Conan setup
find_package(glew REQUIRED)
find_package(spdlog REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GTest REQUIRED)
find_package(OpenGL REQUIRED)

# Source files
file(GLOB_RECURSE SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp)

# Build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Ejecutable target
add_executable(yashima-operation ${SRC_FILES})

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)

# Link libraries to executable
target_link_libraries(yashima-operation
    PRIVATE
    glfw
    OpenGL::GL
    GLEW
    spdlog::spdlog)

# Output binary to build directory
set_target_properties(yashima-operation PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)

# Google Test setup
enable_testing()

# Test executable
file(GLOB_RECURSE TEST_FILES ${CMAKE_SOURCE_DIR}/tests/*.cpp)
add_executable(runTests ${TEST_FILES})

# Link Google Test libraries
target_link_libraries(runTests
    PRIVATE
    GTest::GTest
    GTest::Main
    glfw
    OpenGL::GL
    GLEW
    spdlog::spdlog)

# Add tests
add_test(NAME runTests COMMAND runTests)