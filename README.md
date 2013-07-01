ReadCounter -- a trivial example of a virtual memory-mmapped device for QEMU.
==================

This example adds demonstrates how to implement a device to QEMU and
access this device from a program compiled for ARM Cortex-M3 architecture.

To run the example, do the following:

```
git clone https://github.com/krasin/qemu-counter-hello.git
cd qemu-counter-hello
./test.sh
```

This script will ensure you have ARM EABI GCC toolchain (and download it, if missing),
will build a modified QEMU from https://github.com/krasin/qemu-counter, build hello.c and run it
under QEMU.

If not working, you might need to ```sudo apt-get install gcc-multilib make glib2.0-dev libsdl1.2-dev```
