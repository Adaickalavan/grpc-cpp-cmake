set(BOOST_ROOT /usr/include/boost_1_72_0)
find_package(Boost 1.72 REQUIRED)
find_package(Threads REQUIRED)
find_package(OpenCV REQUIRED)

add_executable(clientrest 
    ./clientrest.cpp) 

target_include_directories(
    clientrest 
    PUBLIC 
        ${Boost_INCLUDE_DIR}
        ${OpenCV_INCLUDE_DIRS}
    )

target_link_libraries(
    clientrest
    PUBLIC
        ${CMAKE_THREAD_LIBS_INIT}
        ${OpenCV_LIBS}
    )


find_package(gRPC CONFIG REQUIRED)
add_executable(my_exe my_exe.cc)
target_link_libraries(my_exe gRPC::grpc++)

add_executable(clientgrpc 
    ./clientgrpc.cpp) 

target_include_directories(
    clientgrpc 
    PUBLIC 
        ${Boost_INCLUDE_DIR}
        ${OpenCV_INCLUDE_DIRS}
    )

target_link_libraries(
    clientgrpc
    PUBLIC
        ${CMAKE_THREAD_LIBS_INIT}
        ${OpenCV_LIBS}
    )
