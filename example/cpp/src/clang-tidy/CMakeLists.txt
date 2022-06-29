cmake_minimum_required(VERSION 3.16)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(simplecmake)
# check
set(CMAKE_CXX_CLANG_TIDY clang-tidy;-checks=*, readability-*)
