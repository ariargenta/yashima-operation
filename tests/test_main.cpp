#include <gtest/gtest.h>
#include <GLFW/glfw3.h>


/**
 * @brief Test to check GLFW initialization.
 */
TEST( GLFWTest, Initialization ) {
    EXPECT_EQ( glfwInit(), GLFW_TRUE );
    glfwTerminate();
}


/**
 * @brief Test to check if a window can be created successfully.
 */
TEST( GLFWTest, CreateWindow ) {
    if( glfwInit() ){
        GLFWwindow* window = glfwCreateWindow( 800, 600, "Test window", nullptr, nullptr );
        
        EXPECT_NE( window, nullptr );
        glfwDestroyWindow( window );
        glfwTerminate();
    } else {
        FAIL() << "Failed to initialize GLFW.";
    }
}


/**
 * @brief Main function to run all tests.
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main( int argc, char* argv[] ) {
    ::testing::InitGoogleTest( &argc, argv );
    return RUN_ALL_TESTS();
}