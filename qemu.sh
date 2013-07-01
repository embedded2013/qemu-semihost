#!/bin/sh

set -ue

# Make sure we have checked out the modified QEMU
if [ ! -d qemu/build ]; then
  git submodule update --init qemu
  cd qemu
  git submodule update --init dtc

  mkdir  build
  cd build
  ../configure --enable-debug --target-list="arm-softmmu"
  cd ../..
fi

# Rebuild QEMU
cd qemu/build
make -j7
cd ../..
export PATH=`pwd`/qemu/build/arm-softmmu:$PATH
