find_package(Threads REQUIRED)
find_package(OpenCV REQUIRED)
set(BOOST_ROOT /usr/include/boost_1_72_0)
find_package(Boost 1.72 REQUIRED)

# add_executable(clientrest 
#     ./clientrest.cpp) 

# target_include_directories(
#     clientrest 
#     PUBLIC 
#         ${Boost_INCLUDE_DIR}
#         ${OpenCV_INCLUDE_DIRS}
#     )

# target_link_libraries(
#     clientrest
#     PUBLIC
#         ${CMAKE_THREAD_LIBS_INIT}
#         ${OpenCV_LIBS}
#     )

# add_executable(clientgrpc 
#     ./clientgrpc.cpp) 

# target_include_directories(
#     clientgrpc 
#     PUBLIC 
#         ${Boost_INCLUDE_DIR}
#         ${OpenCV_INCLUDE_DIRS}
#     )

# target_link_libraries(
#     clientgrpc
#     PUBLIC
#         ${CMAKE_THREAD_LIBS_INIT}
#         ${BOOST_LIBRARIES}
#         ${OpenCV_LIBS}
#         gRPC::grpc++
#     )


# Include GRPC helper macros and functions
include(../cmake/grpc.cmake)

# Fetch GRPC
FETCH_GRPC()

# List proto files
list(APPEND PROTO_FILES 
    ../protos/helloworld.proto
    )

# Generates C++ sources from the .proto files
GRPC_GENERATE_CPP(
    PROTO_SRCS
    GRPC_SRCS
    ${CMAKE_CURRENT_BINARY_DIR}
    ${PROTO_FILES}
    )

# Targets greeter_(client|server)
foreach(_target
    greeter_client 
    greeter_server)
    add_executable(${_target} 
        ./${_target}.cc
        ${PROTO_SRCS}
        ${GRPC_SRCS}
    )
    target_link_libraries(${_target}
        PUBLIC
            ${_REFLECTION}
            ${_GRPC_GRPCPP}
            ${_PROTOBUF_LIBPROTOBUF}
    )
    # Include generated *.pb.h files
    target_include_directories(${_target}
        PUBLIC
            ${CMAKE_CURRENT_BINARY_DIR}
    )  
endforeach()
