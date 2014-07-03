FROM centos

RUN mkdir -p /rpmbuild/SOURCES
RUN mkdir -p /rpmbuild/SPECS
RUN mkdir -p /rpmbuild/RPMS

RUN rpm -ivh http://fedora-epel.mirror.lstn.net/6/i386/epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y install make gcc git autoconf libtool automake python-devel apr-devel \
    pcre-devel expat-devel wget tar cairo-devel check-devel libxml2-devel \
    rpm-build glib2-devel dbus-devel gcc-c++ file \
    bzip2 perl-ExtUtils-MakeMaker libevent-devel

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf

RUN git clone https://github.com/ganglia/monitor-core.git ganglia-3.7.0
RUN tar cvfz /rpmbuild/SOURCES/ganglia-3.7.0.tar.gz ganglia-3.7.0

WORKDIR /rpmbuild/SOURCES/

RUN wget http://concurrencykit.org/releases/ck-0.4.2.tar.gz
RUN tar zxf ck-0.4.2.tar.gz

WORKDIR /rpmbuild/SOURCES/ck-0.4.2
RUN ./configure
RUN make && make install

WORKDIR /rpmbuild/SOURCES

RUN wget http://savannah.nongnu.org/download/confuse/confuse-2.7.tar.gz
RUN tar -xzvf confuse-2.7.tar.gz
WORKDIR /rpmbuild/SOURCES/confuse-2.7

RUN ./configure CFLAGS=-fPIC --disable-nls
RUN make 
RUN make install
WORKDIR /rpmbuild/SOURCES

RUN wget http://oss.oetiker.ch/rrdtool/pub/libs/pango-1.21.1.tar.bz2
RUN tar -xjvf pango-1.21.1.tar.bz2
WORKDIR /rpmbuild/SOURCES/pango-1.21.1

RUN ./configure
RUN make 
RUN make install
WORKDIR /rpmbuild/SOURCES/

RUN wget http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.8.tar.gz
RUN tar xvf rrdtool-1.4.8.tar.gz

WORKDIR /rpmbuild/SOURCES/rrdtool-1.4.8
RUN ./configure PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
RUN make -j8 && make install
WORKDIR /rpmbuild/SOURCES

RUN wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
RUN tar -zxf libmemcached-1.0.18.tar.gz
WORKDIR /rpmbuild/SOURCES/libmemcached-1.0.18

RUN ./configure
RUN make
RUN make install

WORKDIR /rpmbuild/

RUN yum -y install libart_lgpl-devel libconfuse-devel rrdtool-devel

ADD rrdtool.spec /rpmbuild/SPECS/rrdtool.spec
ADD ganglia.spec /rpmbuild/SPECS/ganglia.spec

RUN rpmbuild -bb /rpmbuild/SPECS/ganglia.spec

VOLUME /ganglia-packages

CMD /bin/bash
