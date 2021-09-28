#!/bin/bash

# Clone local copy of the boost library if not exists
if [ ! -d ${PWD}/boost ]; then
    git clone git@github.com:boostorg/boost.git --recursive
fi


BOOST_GIT_TAG=boost-1.76.0



# Build docker image if not present
if ! docker images|grep boost-builder -q; then
    # Checkout correct git tag
    cd boost
    git checkout ${BOOST_GIT_TAG}
    git submodule update --recursive
    cd .. 
    # Build the docker image using dockerfile
    docker build --no-cache -t boost-builder .
fi

# Create build directory if not exists
if [ ! -d ${PWD}/build ]; then
    mkdir ${PWD}/build
fi

# Create output directory if not exists
if [ ! -d ${PWD}/output ]; then
    mkdir ${PWD}/output
fi

# Run the build
if docker images|grep boost-builder -q; then
docker run -it --rm  \
-u builder:builder  \
-v ${PWD}/src:/work/src \
-v ${PWD}/output:/work/output \
-v ${PWD}/build:/work/build \
-v ${PWD}/CMakeLists.txt:/work/CMakeLists.txt \
-v ${PWD}/build.sh:/work/build.sh \
-t boost-builder \
/bin/bash -C /work/build.sh
fi