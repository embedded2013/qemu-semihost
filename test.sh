#!/bin/sh

set -ue

# This script expects qemu-system-arm 1.4.0+ installed
# Also, you will need Sourcery CodeBench Lite Edition toolchain
# http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/
# Don't forget to add toolchain's /bin directory to $PATH

arm-none-eabi-gcc -o hello.elf hello.c -g -mcpu=cortex-m3 -mthumb -T generic-m-hosted.ld -std=c99

echo
echo "============================================="
echo "Running QEMU w/o read_counter device"
echo "============================================="
qemu-system-arm  -cpu cortex-m3 -nographic -monitor null -serial null -semihosting -kernel hello.elf

echo
echo "============================================="
echo "Running QEMU with read_counter device"
echo "============================================="
qemu-system-arm  -cpu cortex-m3 -nographic -monitor null -serial null -semihosting -device read_counter -kernel hello.elf
