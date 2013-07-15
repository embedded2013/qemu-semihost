cmake_minimum_required (VERSION 2.8.9)
project(qemu-counter-hello)

include(ExternalProject)

ExternalProject_Add(qemu
  PREFIX qemu
  GIT_REPOSITORY git@github.com:krasin/qemu-counter.git
  CONFIGURE_COMMAND <SOURCE_DIR>/configure --target-list=arm-softmmu
  INSTALL_COMMAND ""
  )

ExternalProject_Add(arm-eabi-toolchain
  PREFIX arm-eabi
  URL https://sourcery.mentor.com/GNUToolchain/package11442/public/arm-none-eabi/arm-2013.05-23-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
  URL_MD5 9d206de1c74f9454e468ddcdd72c9c53
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  )
