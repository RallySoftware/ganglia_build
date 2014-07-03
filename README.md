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

To build, just run `./build.sh` which will do the following:
- Build an image using the Dockerfile which will:
  - Install all the dependencies for building ganglia
  - Build all ganglia RPM's using the spec file included in this
    repository
- Start a container using this image running a python http server
- wget the packages out of the running container into the local
  `packages` directory
- Destroy the container
