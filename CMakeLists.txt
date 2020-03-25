# CMake version
cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Project name and a few useful settings.
project(
    cppclient
    LANGUAGES CXX
    )

# Place binaries and libraries according to GNU standards
include(GNUInstallDirs)
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})

# Language settings
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add subdirectories - executables
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/app/)

# Test framework
# option(PACKAGE_TESTS "Build the tests" OFF)
# if(PACKAGE_TESTS)

#     include(FetchContent)
#     FetchContent_Declare(
#         googletest
#         GIT_REPOSITORY https://github.com/google/googletest.git
#         GIT_TAG        release-1.8.0
#     )

#     enable_testing()
#     add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/test)
# endif()






# find_package(Threads REQUIRED)
# find_package(OpenCV REQUIRED)
# set(BOOST_ROOT /usr/include/boost_1_72_0)
# find_package(Boost 1.72 REQUIRED)

# # Fetch GRPC
# include(FetchContent)
# FetchContent_Declare(
#     gRPC
#     GIT_REPOSITORY https://github.com/grpc/grpc
#     GIT_TAG        v1.25.0
# )
# set(FETCHCONTENT_QUIET OFF)
# FetchContent_MakeAvailable(gRPC)

# # Since FetchContent uses add_subdirectory under the hood, we can use
# # the grpc targets directly from this build.
# set(_PROTOBUF_LIBPROTOBUF libprotobuf)
# set(_REFLECTION grpc++_reflection)
# set(_PROTOBUF_PROTOC $<TARGET_FILE:protoc>)
# set(_GRPC_GRPCPP grpc++)
# if(CMAKE_CROSSCOMPILING)
#     find_program(_GRPC_CPP_PLUGIN_EXECUTABLE grpc_cpp_plugin)
# else()
#     set(_GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:grpc_cpp_plugin>)
# endif()

# # Get proto file
# get_filename_component(FIL_proto "./protos/helloworld.proto" ABSOLUTE)
# get_filename_component(FIL_proto_path "${FIL_proto}" PATH)

# # Generated sources
# set(FIL_proto_srcs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.pb.cc")
# set(FIL_proto_hdrs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.pb.h")
# set(FIL_grpc_srcs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.grpc.pb.cc")
# set(FIL_grpc_hdrs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.grpc.pb.h")

# # message("${${FIL}_proto}")
# # message(${CMAKE_CURRENT_LIST_FILE})
# # message(${CMAKE_CURRENT_BINARY_DIR})

# # Compile protocol buffers
# add_custom_command(
#     OUTPUT 
#         "${FIL_proto_srcs}" 
#         "${FIL_proto_hdrs}" 
#         "${FIL_grpc_srcs}" 
#         "${FIL_grpc_hdrs}"
#     COMMAND 
#         ${_PROTOBUF_PROTOC}
#         ARGS 
#             --grpc_out "${CMAKE_CURRENT_BINARY_DIR}"
#             --cpp_out "${CMAKE_CURRENT_BINARY_DIR}"
#             -I "${FIL_proto_path}"
#             --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}"
#         "${FIL_proto}"
#     DEPENDS 
#         "${FIL_proto}"
# )

# # Include generated *.pb.h files
# include_directories("${CMAKE_CURRENT_BINARY_DIR}")

# # Targets greeter_[async_](client|server)
# foreach(_target
#   greeter_client greeter_server)
#   add_executable(${_target} "./${_target}.cc"
#     ${FIL_proto_srcs}
#     ${FIL_grpc_srcs})
#   target_link_libraries(${_target}
#     ${_REFLECTION}
#     ${_GRPC_GRPCPP}
#     ${_PROTOBUF_LIBPROTOBUF})
# endforeach()
