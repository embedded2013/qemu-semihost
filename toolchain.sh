#!/bin/sh

set -ue
# This script tries to ensure we have ARM EABI GCC tooclhain
# If arm-non-eabi-gcc is not found in $PATH, it will try
# to download Sourcery CodeBench Lite Edition toolchain
# http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/
# You can also try to build that toolchain from sources
# https://github.com/jsnyder/arm-eabi-toolchain
#
# Don't forget to add toolchain's /bin directory to $PATH

# Check if we already have ARM EABI toolchain installed
if [ ! arm-eabi/bin ]; then
  export PATH=`pwd`/arm-eabi/bin:
else
if ! arm-none-eabi-gcc --version
then
    echo "No ARM EABI toolchain found"
    echo "Trying to download it automatically"
    echo "If that would fail, please, download it from \
http://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/ \
and add its bin/ directory to the PATH environment variable"

    wget https://sourcery.mentor.com/GNUToolchain/package11442/public/arm-none-eabi/arm-2013.05-23-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
    tar -xjf arm*.tar.bz2
    rm *.tar.bz2
    mv arm-20* arm-eabi
    export PATH=`pwd`/arm-eabi/bin:$PATH
fi
fi
