cmake_minimum_required(VERSION 3.13)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_MODULE_PATH}/cmake_modules")
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Testing
project(module_test)

enable_testing()
find_package(GTest REQUIRED)

set(source ${CMAKE_CURRENT_SOURCE_DIR}/gtest_test.cc)
add_executable(module_test ${source})
target_link_libraries(module_test
                      GTest::GTest
                      GTest::Main
)

add_test(test_all module_test)