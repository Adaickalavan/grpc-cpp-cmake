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


# Fetch GRPC
include(../cmake/grpc.cmake)
fetch_grpc()

# Get proto file
get_filename_component(FIL_proto "../protos/helloworld.proto" ABSOLUTE)
get_filename_component(FIL_proto_path "${FIL_proto}" PATH)

# Generated sources
set(FIL_proto_srcs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.pb.cc")
set(FIL_proto_hdrs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.pb.h")
set(FIL_grpc_srcs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.grpc.pb.cc")
set(FIL_grpc_hdrs "${CMAKE_CURRENT_BINARY_DIR}/helloworld.grpc.pb.h")

# message("${${FIL}_proto}")
# message(${CMAKE_CURRENT_LIST_FILE})
# message(${CMAKE_CURRENT_BINARY_DIR})

# Compile protocol buffers
add_custom_command(
    OUTPUT 
        "${FIL_proto_srcs}" 
        "${FIL_proto_hdrs}" 
        "${FIL_grpc_srcs}" 
        "${FIL_grpc_hdrs}"
    COMMAND 
        ${_PROTOBUF_PROTOC}
        ARGS 
            --grpc_out "${CMAKE_CURRENT_BINARY_DIR}"
            --cpp_out "${CMAKE_CURRENT_BINARY_DIR}"
            -I "${FIL_proto_path}"
            --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}"
        "${FIL_proto}"
    DEPENDS 
        "${FIL_proto}"
)

# Include generated *.pb.h files
# include_directories("${CMAKE_CURRENT_BINARY_DIR}")

# Targets greeter_[async_](client|server)
foreach(_target
    greeter_client 
    greeter_server)
    add_executable(${_target} 
        "./${_target}.cc"
        ${FIL_proto_srcs}
        ${FIL_grpc_srcs})
    target_link_libraries(${_target}
        PUBLIC
            ${_REFLECTION}
            ${_GRPC_GRPCPP}
            ${_PROTOBUF_LIBPROTOBUF}
    )
    target_include_directories(${_target}
        PUBLIC
            ${CMAKE_CURRENT_BINARY_DIR}
    )  
endforeach()
