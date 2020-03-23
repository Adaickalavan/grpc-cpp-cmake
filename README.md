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
                    0.9
                ]
            }
        ]
    }
    ```

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
