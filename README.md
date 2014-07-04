# Ganglia Build 

This repository uses Docker to build ganglia RPMs. Presently it builds
from the master repository of ganglia and calls it version 3.7.0
(because 3.7.0 hasn't actually been released). 

## Requirements

Using this repository requires that you have [Docker](www.docker.io)
running somewhere. Update build.sh with the URL for your docker host and
you are off and running, unless you have TLS enabled in which case you
need to change the docker commands in the build script. 

This script has the following local requirements for the host running
`build.sh`:
- wget
- docker cli binary

## Building

To build, run `build.sh` with two arguments:
- The name of the distro you want to build (ubuntu or centos)
- The URL to your docker server in a format compatible with the Docker
  -H parameter (ex. tcp://1.2.3.4:4243)

which will do the following:
- Build an image using the Dockerfile which will:
  - Install all the dependencies for building ganglia
  - Build all ganglia packages for that distribution
- Start a container using this image running a python http server
- wget the packages out of the running container into the local
  `packages` directory
- Destroy the container

This will result in the built packages being placed in the `packages`
directory of this repository.

## Examples

To build CentOS packages:
```
./build.sh centos tcp://1.2.3.4:4243
```

To build Ubuntu packages
```
./build.sh ubuntu tcp://1.2.3.4:4243
```
