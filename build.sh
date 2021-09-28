#!/bin/bash


cd build 

# Check if makefile exists, otherwise config with cmake
if [ ! -e "Makefile" ]; then
    cmake .. || exit 1
fi

make || exit 1


# run program
./asiotest



