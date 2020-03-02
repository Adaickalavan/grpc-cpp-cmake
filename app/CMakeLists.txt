set(BOOST_ROOT /usr/include/boost_1_72_0)
find_package(Boost 1.72 REQUIRED)
find_package(Threads REQUIRED)

add_executable(client 
    ./client.cpp) 

target_include_directories(
    client 
    PUBLIC 
        ${Boost_INCLUDE_DIR}
    )

target_link_libraries(
    client
    PUBLIC
        ${CMAKE_THREAD_LIBS_INIT}
    )