cmake_minimum_required(VERSION 3.3)

project(yashima-operation VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Clean previous build
if(EXISTS "${CMAKE_SOURCE_DIR}/build")
    file(REMOVE_RECURSE "${CMAKE_SOURCE_DIR}/build")
    file(MAKE_DIRECTORY "${CMAKE_SOURCE_DIR}/build")
endif()

# Source files
file(GLOB_RECURSE SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp)

# Executable target
add_executable(yashima-operation ${SRC_FILES})

# OpenGL package
find_package(OpenGL REQUIRED)

# Include directories for GLFW and GLEW
include_directories(${CMAKE_SOURCE_DIR}/include)

# Find GLFW package
find_package(glfw3 3.3 REQUIRED)

# Link necessary libraries
target_link_libraries(yashima-operation PRIVATE glfw OpenGL::GL GLEW)

# Output binary to build directory
set_target_properties(yashima-operation PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)

# Google Test setup
add_subdirectory(${CMAKE_SOURCE_DIR}/third-party/googletest)

# Enable testing
enable_testing()

# Test executable
file(GLOB_RECURSE TEST_FILES ${CMAKE_SOURCE_DIR}/tests/*.cpp)
add_executable(runTests ${TEST_FILES})

# Link Google Test libraries
target_link_libraries(runTests PRIVATE gtest gtest_main glfw OpenGL::GL GLEW)

# Add tests
add_test(NAME runTests COMMAND runTests)