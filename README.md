ReadCounter – a trivial device for QEMU
-----

This example demonstrates how to implement a simple virtual device for QEMU and
access this device from a program compiled for ARM Cortex-M3 architecture.

The device is visible to the user program as a 32-bit memory-mmapped register that
returns the number of times this register has been read.

The primary sources to look at are
[hw/arm/read_counter.c](https://github.com/krasin/qemu-counter/blob/read_counter/hw/arm/read_counter.c) (device)
and [main.c](https://github.com/krasin/qemu-counter-hello/blob/master/hello.c) (example usage).

To run the example, do the following:

```
git clone https://github.com/krasin/qemu-counter-hello.git
cd qemu-counter-hello
./test.sh
```

This script will ensure you have ARM EABI GCC toolchain (and download it, if missing),
will build a modified QEMU from https://github.com/krasin/qemu-counter, build
[hello.c](https://github.com/krasin/qemu-counter-hello/blob/master/hello.c) and run it
under QEMU.

If not working, you might need to ```sudo apt-get install cmake gcc-multilib make glib2.0-dev libsdl1.2-dev dh-autoreconf```

If working, after a few minutes of waiting, which will take to download all the dependencies and
to build QEMU, you will hopefully see the following:

```
=============================================
Running QEMU w/o read_counter device
=============================================
This is a test program for QEMU counter device
See http://github.com/krasin/qemu-counter for more details

Let's check if the Read Counter device presented
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
The device has been accessed for 0 times!
ERROR - No Read Counter detected

=============================================
Running QEMU with read_counter device
=============================================
This is a test program for QEMU counter device
See http://github.com/krasin/qemu-counter for more details

Let's check if the Read Counter device presented
The device has been accessed for 1 times!
The device has been accessed for 2 times!
The device has been accessed for 3 times!
The device has been accessed for 4 times!
The device has been accessed for 5 times!
The device has been accessed for 6 times!
The device has been accessed for 7 times!
The device has been accessed for 8 times!
The device has been accessed for 9 times!
The device has been accessed for 10 times!
OK - Read Counter works as intended
```

After that you will be able to run it by hand as well:

```
$ ./qemu/build/arm-softmmu/qemu-system-arm -cpu cortex-m3 -nographic -monitor null \
-serial null -semihosting -device read_counter -kernel hello.elf
This is a test program for QEMU counter device
See http://github.com/krasin/qemu-counter for more details

Let's check if the Read Counter device presented
The device has been accessed for 1 times!
The device has been accessed for 2 times!The device has been accessed for 3 times!
The device has been accessed for 4 times!
The device has been accessed for 5 times!
The device has been accessed for 6 times!
The device has been accessed for 7 times!
The device has been accessed for 8 times!
The device has been accessed for 9 times!
The device has been accessed for 10 times!
OK - Read Counter works as intended
```

Happy QEMU hacking!
