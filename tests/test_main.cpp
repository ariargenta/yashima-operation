#include <gtest/gtest.h>
#include "config.hpp"


class TestEnvironment : public ::testing::Environment {
    public:
        void SetUp() override {
            initializeLogger();
            spdlog::info( "Test environment setup." );
        }
};


/**
 * @brief Main function to run all tests.
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main( int argc, char* argv[] ) {
    ::testing::InitGoogleTest( &argc, argv );
    ::testing::AddGlobalTestEnvironment( new ::testing::Environment() );
    return RUN_ALL_TESTS();
}