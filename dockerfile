FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive


ENV BOOST_ROOT=/usr/local/include/boost


RUN cd /usr/include/ \
&& apt-get update \
&& apt-get install -y \
build-essential \
cmake \
git 



COPY ${PWD}/boost /tmp/boost 

RUN ls -la /tmp/boost

RUN cd /tmp/boost \ 
&& ./bootstrap.sh --prefix=/usr/local \
&& ./b2 install \
&& cd .. \
&& rm -rf /tmp/boost


RUN useradd builder \
&& mkdir /work \
&& chown -R builder:builder /work

USER builder
WORKDIR /work


# ENTRYPOINT /bin/bash
