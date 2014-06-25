#!/bin/sh

export DOCKER_HOST='tcp://bld-docker-02:4243'

docker build --rm -t ganglia_centos_build centos/ 
