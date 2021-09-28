
cmake_minimum_required(VERSION 3.16.3)

project(asiotest VERSION 1.0.0)



find_package(Boost 1.76.0 REQUIRED system thread)


add_executable(asiotest)


target_sources(
asiotest
PUBLIC
src/main.cpp
)

target_link_libraries(asiotest PUBLIC 
# Boost::boost 
# Boost::headers 
# Boost::system
Boost::thread
)

set_property(TARGET asiotest PROPERTY CXX_STANDARD 20)
