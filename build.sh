#!/bin/bash

if [ -z $2 ]; then
  echo "Not enough arguments, supply the distro & a URL to your docker host"
  echo "Usage: $0 (centos|ubuntu) <tcp://dockerhost:4243>"
  exit 1
fi 

export DIST=$1
export DOCKER_HOST=$2

docker build --no-cache -t ganglia_${DIST}_build $DIST/

docker run --name ganglia_${DIST}_build -d -p 8000 ganglia_${DIST}_build python -m SimpleHTTPServer 8000

PORT=`docker port ganglia_${DIST}_build 8000 | cut -d: -f2`

echo "Giving the container a second to startup"
sleep 5

if [ $DIST == "centos" ]; then
  cd packages && wget -r -nd http://bld-docker-02:${PORT}/RPMS/x86_64/
else [ $DIST == "ubuntu" ];
  cd packages && wget -r -nd http://bld-docker-02:${PORT}/RPMS/x86_64/
fi

docker kill ganglia_${DIST}_build
docker rm ganglia_${DIST}_build
