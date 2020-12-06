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
    $ ./bin/client
    ```
    For testing, I have set up a mock server using Postman at the url https://d1e2caec-b504-4bf3-8bc3-f28db5fd7618.mock.pstmn.io. A `POST` request to this mock server url will return a JSON response 
    ```JSON
    {
        "predictions": [
            {
                "classes": 2,
                "probabilities": [
                    0.5,
                    0.1,
                    0.8
                ]
            }
        ]
    }
    ```

1. http://tfsimagenet:8501/v1/models/tfModel:predict
    http://localhost:8501/v1/models/tfModel:predict

## Instructions to build and run the code inside Docker
1. Build image: 
    ```bash
    $ cd /path/to/repository/root/cpp-client
    $ docker build -t cppclient .
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
    $ sudo apt-get install build-essential autoconf libtool pkg-config
    $ sudo apt-get install cmake
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
    // -- $ make install
    ```