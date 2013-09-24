#!/bin/sh

set -ue

. ./qemu.sh

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
