FROM ubuntu:14.04
MAINTAINER elijah@aclue.com

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update 

RUN apt-get -y install git python-software-properties build-essential \
 autoconf libtool automake autoconf libtool pkg-config libapr1 \
 libapr1-dev libconfuse-dev libexpat-dev libpcre3-dev python librrd-dev \
 libapr1-dev python-dev libdbi0-dev gperf wget

RUN mkdir /build
WORKDIR /build

RUN wget http://concurrencykit.org/releases/ck-0.4.2.tar.gz

RUN tar zxf ck-0.4.2.tar.gz

WORKDIR /build/ck-0.4.2

RUN ./configure

RUN make && make install

WORKDIR /build

RUN git clone https://github.com/ganglia/monitor-core ganglia

WORKDIR /build/ganglia

RUN sed -i 's/3.3.0/3.7.0/' debian/changelog

RUN ./bootstrap

RUN dpkg-buildpackage

RUN mkdir /build/pkg
WORKDIR /build/pkg
RUN mv /build/*.deb /build/pkg
