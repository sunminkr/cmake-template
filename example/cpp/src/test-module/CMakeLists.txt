cmake_minimum_required(VERSION 3.13)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(module LANGUAGES CXX)

set(SRC ${CMAKE_CURRENT_SOURCE_DIR}/test.cc)
add_executable(module ${SRC})

add_subdirectory(test)