#!/bin/sh

#export DOCKER_HOST='tcp://bld-docker-02:4243'
export DOCKER_HOST='tcp://bld-docker-02:4243'

docker build -t ganglia_centos_build centos/ 
