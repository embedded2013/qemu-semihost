#!/bin/sh

set -ue

# Make sure we have checked out the modified QEMU
if [ ! -d qemu/build ]; then
  cd qemu
  mkdir build
  cd build
  ../configure --enable-debug --target-list="arm-softmmu"
  cd ../..
fi

# Rebuild QEMU
cd qemu/build
make
cd ../..
export PATH=`pwd`/qemu/build/arm-softmmu:$PATH
