## Instructions to run the code
1. Download the repository
    ```bash
    $ git clone https://github.com/Adaickalavan/cpp-client.git 
    ```
1. Build source codes using CMake in Linux
    ```bash
    $ cd /path/to/repository/root/cpp-client/
    $ mkdir build
    $ cd build
    $ cmake ..
    $ cmake --build .
    ``` 
1. Run the C++ client
    ```bash
    $ cd /path/to/repository/root/cpp-client/
    $ cd build
    $ ./app/greeter_client
    ```

## Instructions to build and run the code inside Docker
1. Build image: 
    ```bash
    $ cd /path/to/repository/root/cpp-client
    $ docker build -t cppclient --network=host .
    ```
1. Run the image: 
    ```bash
    $ cd /path/to/repository/root/cpp-client
    $ docker-compose up
    ```    


## Steps to build GRPC locally
Reference: https://github.com/grpc/grpc/blob/master/BUILDING.md#pre-requisites

1. Set `~/.bash_aliases` file:
    ```bash
    export MY_INSTALL_DIR=$HOME/.local
    export PATH=$PATH:$MY_INSTALL_DIR/bin
    ```

1. Install pre-requisites and CMake
    ```bash
    $ sudo apt-get install -y build-essential autoconf libtool pkg-config
    $ sudo apt-get install -y cmake
    ```

1. Clone gRPC repository
    ```bash
    $ git clone -b v1.28.1 https://github.com/grpc/grpc
    $ cd grpc
    $ git submodule update --init
    ```

1. Builds and install gRPC
    ```bash
    $ cd grpc
    $ mkdir -p cmake/build
    $ cd cmake/build
    $ cmake -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
        ../..
    $ make
    $ make install
    ```