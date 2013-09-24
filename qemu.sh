#!/bin/sh

set -ue

QEMU_PATH=qemu-counter

# Make sure we have checked out the modified QEMU
if [ ! -d $QEMU_PATH/build ]; then
  cd $QEMU_PATH
  mkdir build
  cd build
  ../configure --enable-debug --target-list="arm-softmmu"
  cd ../..
fi

# Rebuild QEMU
cd $QEMU_PATH/build
make
cd ../..
export PATH=`pwd`/$QEMU_PATH/build/arm-softmmu:$PATH
