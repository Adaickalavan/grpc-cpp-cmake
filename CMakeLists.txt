# CMake version
cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Project name and a few useful settings.
project(
    cppclient
    LANGUAGES CXX
    )

# Place binaries and libraries according to GNU standards
include(GNUInstallDirs)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

# Language settings
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add subdirectories - executables
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/app/)

# Test framework
option(PACKAGE_TESTS "Build the tests" OFF)
if(PACKAGE_TESTS)

    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        release-1.8.0
    )

    enable_testing()
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/test)
endif()
