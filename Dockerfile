# Base image
FROM docker.io/ubuntu AS buildstage

LABEL Author Adaickalavan<adaickalavan@gmail.com>

# Prevent interactive messages while installing libraries
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools
RUN apt-get update -y
RUN apt-get -y install \
    cmake \ 
    pkg-config \
    wget

# Install Boost ASIO library
RUN cd /usr/include/ && \
    wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.bz2 && \
    tar --bzip2 -xf ./boost_1_72_0.tar.bz2 && \
    rm -r ./boost_1_72_0.tar.bz2

# Change working directory
WORKDIR /src

# Copy the current folder which contains C++ source code to the Docker image
COPY . .

# Use cmake to compile the cpp source file. cmake@v3.10.x .
RUN cmake -E make_directory build && \
    cmake -E chdir ./build cmake .. && \
    cmake --build ./build
