from conan import ConanFile
from conan.tools.cmake import CMake, CMakeToolchain, CMakeDeps

class YashimaOperationConan(ConanFile):
    name = "yashima-operation"
    version = "1.0.0"
    license = "MIT"
    author = "Aria Silva <55609849+ariargenta@users.noreply.github.com>"
    url = "https://github.com/ariargenta/yashima-operation"
    description = "Proof of concept for the operation of the Yashima Engine"
    topics = ("render-engine", "c++", "game-engine")
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": False}
    requires = [
        "glew/2.1.0",
        "spdlog/1.14.1",
        "glfw/3.4",
        "gtest/1.15.0",
        "opengl/system"
    ]
    generators = "CMakeDeps", "CMakeToolchain"
    
    def generate(self):
        tc = CMakeToolchain(self)
        tc.generate()
        deps = CMakeDeps(self)
        deps.generate()
    
    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()
    
    def package(self):
        cmake = CMake(self)
        cmake.install()
    
    def package_info(self):
        self.cpp_info.libs = ["yashima-operation"]