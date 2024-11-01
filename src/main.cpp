#include "render_init.hpp"


/**
 * @brief Main function.
 * Initializes GLFW and GLEW, creates a window and starts the rendering loop.
 * 
 * @return int Returns 0 if the program was executed successfully. Otherwise, returns -1.
 */
int main(int argc, char* argv[]) {
    // Callback function to handle errors
    glfwSetErrorCallback(errorCallback);

    // Graphics initialization
    initializeOpenGL();
    runMainLoop();
}