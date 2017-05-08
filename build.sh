#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)

set -eu
if [ ! -d gdb-7.1 ]; then
  if [ ! -f gdb-7.1a.tar.bz2 ]; then
    curl http://ftp.gnu.org/gnu/gdb/gdb-7.1a.tar.bz2 -o gdb-7.1a.tar.bz2
  fi
  tar xvf gdb-7.1a.tar.bz2
fi
patch -p0 < ${SCRIPT_DIR}/gdb-71.diff
mkdir -p gdb-7.1/build
cd gdb-7.1/build
../configure --target=arm-none-eabi --prefix=/usr/local --program-suffix=-7.1 --enable-interwork --enable-multilib
make all
make install

