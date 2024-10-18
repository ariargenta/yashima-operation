from conan import ConanFile
from conan.tools.cmake import CMake

class YashimaOperationConan( ConanFile ):
    name = "yashima-operation"
    version = "1.0.0"
    license = "MIT"
    author = "Aria Silva <55609849+ariargenta@users.noreply.github.com>"
    url = "https://github.com/ariargenta/yashima-operation"
    description = "Proof of concept for the operation of the Yashima Engine"
    topics = ( "render-engine", "c++", "game-engine" )
    settings = "os", "compiler", "build_type", "arch"
    options = { "shared": [ True, False ] }
    default_options = { "shared": False }
    requires = [
        "glew/2.1.0"
        "spdlog/1.14.1",
        "glfw/3.4",
        "gtest/1.15.2"
    ]
    generators = "CMakeDeps", "CMakeToolchain", "CMakeFindPackage"
    
    
    def imports( self ):
        self.folders.source = "."
        self.folders.build = "build"
    
    def build( self ):
        cmake = CMake( self )
        cmake.configure()
        cmake.build()
    
    def package_info( self ):
        self.cpp_info.libs = [ "yashima-operation" ]