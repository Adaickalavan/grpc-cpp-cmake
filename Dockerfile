# Base image
FROM docker.io/ubuntu AS buildstage

LABEL Author Adaickalavan<adaickalavan@gmail.com>

# Prevent interactive messages while installing libraries
ENV DEBIAN_FRONTEND=noninteractive

#------------------------------------------------------------------------------
# Environment variables inside docker
#------------------------------------------------------------------------------
# Uncomment inside Huawei domain
ENV http_proxy http://0.0.0.0:3128
ENV HTTP_PROXY http://0.0.0.0:3128
ENV https_proxy http://0.0.0.0:3128
ENV HTTPS_PROXY http://0.0.0.0:3128
ENV ftp_proxy http://0.0.0.0:3128
ENV FTP_PROXY http://0.0.0.0:3128
ENV no_proxy 127.0.0.1,10.218.163.63,localhost,.huawei.com,.kyber.team
ENV NO_PROXY 127.0.0.1,10.218.163.63,localhost,.huawei.com,.kyber.team

#------------------------------------------------------------------------------
# Install dependencies
#------------------------------------------------------------------------------
# Install build tools
RUN apt-get update --fix-missing -y && \
    apt-get -y install \
    pkg-config \
    libopenmpi-dev \
    wget \
    libunwind-dev \
    build-essential \
    autoconf \
    libtool \
    golang

# Install CMake 3.17.0
ARG CMAKE_VER=3.17
ARG CMAKE_BUILD=0
RUN cd /usr/local/ && \
    wget --no-check-certificate https://cmake.org/files/v${CMAKE_VER}/cmake-${CMAKE_VER}.${CMAKE_BUILD}-Linux-x86_64.tar.gz && \
    tar -xzf ./cmake-${CMAKE_VER}.${CMAKE_BUILD}-Linux-x86_64.tar.gz && \
    rm -r ./cmake-${CMAKE_VER}.${CMAKE_BUILD}-Linux-x86_64.tar.gz && \
    ln -s /usr/local/cmake-${CMAKE_VER}.${CMAKE_BUILD}-Linux-x86_64/bin/cmake /usr/bin/cmake

# # Install Boost ASIO library 1.72.0
# ARG BOOST_MAJOR=1
# ARG BOOST_MINOR=72 
# ARG BOOST_BUILD=0
# RUN cd /usr/include/ && \
#     wget --no-check-certificate https://dl.bintray.com/boostorg/release/${BOOST_MAJOR}.${BOOST_MINOR}.${BOOST_BUILD}/source/boost_${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD}.tar.bz2 && \
#     tar --bzip2 -xf ./boost_${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD}.tar.bz2 && \
#     rm -r ./boost_${BOOST_MAJOR}_${BOOST_MINOR}_${BOOST_BUILD}.tar.bz2

#------------------------------------------------------------------------------
# Fix Git
#------------------------------------------------------------------------------
RUN cp /etc/apt/sources.list /etc/apt/sources.list~ && \
    sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt-get update

RUN apt-get install -y \
    git

RUN apt-get install build-essential fakeroot dpkg-dev -y && \
    apt-get build-dep git -y && \
    apt-get install libcurl4-openssl-dev -y  && \
    cd ~ && \
    mkdir source-git && \
    cd source-git/ && \
    apt-get source git && \
    cd git-2.*.*/ && \
    sed -i 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/' ./debian/control && \
    sed -i '/TEST\s*=\s*test/d' ./debian/rules && \
    dpkg-buildpackage -rfakeroot -b -uc -us && \
    dpkg -i ../git_*ubuntu*.deb

#------------------------------------------------------------------------------
# Fix Git proxy
#------------------------------------------------------------------------------
# RUN git config --global http.proxy http://a84166141:huawei432!@localhost:3128
RUN git config --global https.proxy https://localhost:3128
RUN git config --global http.proxy http://localhost:3128
ENV GIT_SSL_NO_VERIFY true

#------------------------------------------------------------------------------
# Copy src files
#------------------------------------------------------------------------------
# Change working directory
WORKDIR /src

# Copy the current folder which contains C++ source code to the Docker image
COPY . .

# Use cmake to compile the cpp source file.
RUN cmake -E make_directory build && \
    cmake -E chdir ./build cmake .. && \
    cmake --build ./build

#------------------------------------------------------------------------------
# Entrypoint
#------------------------------------------------------------------------------
CMD ["/src/build/app/greeter_server"]

# RUN cmake -E make_directory build && \
#     cmake -E chdir ./build cmake -DCMAKE_BUILD_TYPE=Release .. && \
#     cmake --build ./build