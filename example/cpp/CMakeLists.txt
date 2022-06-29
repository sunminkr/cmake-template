cmake_minimum_required(VERSION 3.13)
set(CMAKE_CXX_STANDARD 17)

if(POLICY CMP0077)
    cmake_policy(SET CMP0077 NEW)
endif(POLICY CMP0077)

project(simplecmake-example)
set(SIMPLECMAKE_VERSION 1.0.0)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules)

option(BUILD_ARROW "Build arrow" ON)

include(ThirdPartyToolChain)

if(BUILD_ARROW)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}thirdparty/arrow)
endif(BUILD_ARROW)

# Subdirectory should have its CMakeLists.txt
add_subdirectory(src/arrow-example)
add_subdirectory(src/test-module)