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
    $ ./bin/client d1e2caec-b504-4bf3-8bc3-f28db5fd7618.mock.pstmn.io 80 /
    ```
    For testing, I have set up a mock server using Postman at the url https://d1e2caec-b504-4bf3-8bc3-f28db5fd7618.mock.pstmn.io. A `GET` request to this mock server url will return a web response "Hi got" and a `POST` request to this mock server url will return a web response "Hi posted". This can be verified by accessing the mock server url using your browser.

## Instructions to run the code inside Docker
1. Build: `docker build -t cppclient .` on `Dockerfile`
1. Run: `docker-compose up` on `docker-compose.yaml` file    