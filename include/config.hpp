// config.hpp
#pragma once

// Standard libraries
#include <iostream>
#include <memory>
#include <string>
#include <filesystem>

// Logging libraries
#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>


/**
 * @brief Global constants.
 */
const std::string LOG_FOLDER = "logs/";
const std::string ENGINE_VERSION = "0.1.0";
const int DEFAULT_WINDOW_WIDTH = 800;
const int DEFAULT_WINDOW_HEIGHT = 600;


/**
 * @brief Logger initialization.
 * This function configures the logger using spdlog library.
 * 
 * @note This function should be called before any logging operation.
 */
inline void initializeLogger() {
    // Log folder creation
    if( !std::filesystem::exists( LOG_FOLDER ) ) {
        std::filesystem::create_directory( LOG_FOLDER );
    }

    // Logger creation
    auto file_logger = spdlog::stdout_color_mt( "file_logger" );

    spdlog::set_default_logger( file_logger );
    spdlog::set_level( spdlog::level::debug );
    spdlog::flush_on( spdlog::level::info );
}


inline void logFunctionEntry( const std::string& function_name ) {
    spdlog::info("Entering function: {}", function_name );
}

inline void logFunctionExit( const std::string& function_name ) {
    spdlog::info("Exiting function: {}", function_name );
}