#!/usr/bin/env bash
set -eu
wget http://ftp.gnu.org/gnu/gdb/gdb-7.1a.tar.bz2
tar xvf gdb-7.1a.tar.bz2
patch -p0 < gdb-71.diff
mkdir -p gdb-7.1/build
cd gdb-7.1/build
../configure --target=arm-none-eabi --prefix=/usr/local --enable-interwork --enable-multilib
make all
make install

