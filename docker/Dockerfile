FROM fedora:latest
RUN dnf -y update && dnf -y upgrade
RUN dnf -y install vim
RUN yum install wget -y
RUN yum install firefox -y
RUN yum -y install curl cvs subversion make autoconf gcc gcc-c++ automake bzip2
RUN yum -y install bitstream-vera-sans-mono-fonts tcl tcl-devel tk tk-devel jack-audio-connection-kit jack-audio-connection-kit-devel alsa-lib alsa-lib-devel libtool


ARG PD_VERSION=0.52-2
ARG PD_TARBALL=pd-$PD_VERSION.src.tar.gz
ARG PD_FOLDER=pd-$PD_VERSION

WORKDIR /tmp
RUN wget http://msp.ucsd.edu/Software/$PD_TARBALL && \
    tar xzvf $PD_TARBALL && \
    cd $PD_FOLDER && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install
