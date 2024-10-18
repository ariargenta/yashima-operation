#pragma once

#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include "config.hpp"


/**
 * @brief OpenGL initialization.
 * 
 * @return void
 */
void initializeOpenGL() {
    logFunctionEntry( "initializeOpenGL" );

    if( !glfwInit() ) {
        std::cerr << "Failed to initialize GLFW." << std::endl;
        return;
    }

    spdlog::info( "GLFW initialized successfully." );

    // Window configuration
    glfwWindowHint( GLFW_CONTEXT_VERSION_MAJOR, 3 );
    glfwWindowHint( GLFW_CONTEXT_VERSION_MINOR, 3 );
    glfwWindowHint( GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE );

    GLFWwindow* window = glfwCreateWindow( DEFAULT_WINDOW_WIDTH, DEFAULT_WINDOW_HEIGHT, "Yashima Operation", nullptr, nullptr );

    if( !window ) {
        spdlog::error( "Failed to create GLFW window." );
        glfwTerminate();
        return;
    }

    spdlog::info( "GLFW window created successfully." );

    glfwMakeContextCurrent( window );

    glewExperimental = GL_TRUE;

    if( glewInit() != GLEW_OK ) {
        spdlog::error( "Failed to initialize GLEW." );
        return;
    }

    spdlog::info( "GLEW initialized successfully." );

    logFunctionExit( "initializeOpenGL" );
}


/**
 * @brief Main loop execution.
 * 
 * @return void
 */
void runMainLoop() {
    while( !glfwWindowShouldClose( glfwGetCurrentContext() ) ) {
        //Render here
        glfwSwapBuffers( glfwGetCurrentContext() );
        glfwPollEvents();
    }

    glfwTerminate();
}


/**
 * @brief Callback funtion to handle errors.
 * This function is used by GLFW to report errors.
 * 
 * @param error The error code.
 * @param description A pointer to a UTF-8 encoded string describing the error.
 * @return void
 */
void errorCallback( int error, const char* description ) {
    spdlog::error( "GLFW error ({}): {}", error, description );
}