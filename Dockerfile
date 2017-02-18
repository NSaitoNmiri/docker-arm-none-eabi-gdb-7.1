FROM ubuntu:xenial
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget gcc make texinfo libncurses5-dev patch libexpat1-dev python bzip2
WORKDIR /tmp
ADD ./build.sh ./build.sh
ADD ./gdb-71.diff ./gdb-71.diff
RUN bash ./build.sh
WORKDIR /host_workdir
CMD ["/usr/local/bin/arm-none-eabi-gdb"]
