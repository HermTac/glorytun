cmake_minimum_required(VERSION 3.28.3)

project(glorytun)

add_subdirectory(source)

add_library(
        glorytun
        INTERFACE
)
target_link_libraries(
        glorytun
        INTERFACE
        glorytun_library
)