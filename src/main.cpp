#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <iostream>


/**
 * @brief Callback funtion to handle errors.
 * This function is used by GLFW to report errors.
 * 
 * @param error The error code.
 * @param description A pointer to a UTF-8 encoded string describing the error.
 * @return void
 */
void errorCallback( int error, const char* description ) {

    std::cerr << "Error: " << description << std::endl;
}


/**
 * @brief Main function.
 * Initializes GLFW and GLEW, creates a window and starts the rendering loop.
 * 
 * @return int Returns 0 if the program was executed successfully. Otherwise, returns -1.
 */
int main( int argc, char* argv[] ) {

    if(!glfwInit()) {
        // Initialize GLFW
        std::cerr << "Failed to initialize GLFW." << std::endl;
        return -1;
    }

    // Set error callback
    glfwSetErrorCallback( errorCallback );

    // Set OpenGL version using C++20
    glfwWindowHint( GLFW_CONTEXT_VERSION_MAJOR, 3 );
    glfwWindowHint( GLFW_CONTEXT_VERSION_MINOR, 3 );
    glfwWindowHint( GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE );

    // Create a windowed mode window and its OpenGL context
    GLFWwindow* window = glfwCreateWindow( 800, 600, "Yashima Operation", nullptr, nullptr );

    if( !window ) {
        std::cerr << "Failed to create GLFW window." << std::endl;
        glfwTerminate();
        return -1;
    }

    // Make the window's context current
    glfwMakeContextCurrent( window );

    // Initialize GLEW
    glewExperimental = GL_TRUE;

    if( glewInit() != GLEW_OK ) {
        std::cerr << "Failed to initialize GLEW." << std::endl;
        glfwDestroyWindow( window );
        glfwTerminate();
        return -1;
    }

    // Main loop
    while( !glfwWindowShouldClose( window ) ) {
        //Render here
        glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
        // Swap front and back buffers
        glfwSwapBuffers( window );
        //Poll for and process events
        glfwPollEvents();
    }
    // Clean up
    glfwDestroyWindow( window );
    glfwTerminate();

    return 0;
}