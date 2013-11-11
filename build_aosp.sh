#!/bin/bash

ROOTFS_PATH="/home/simone/neak-gs2plus/ramdisk-aosp"

echo "Building N.E.A.K. GS2 Plus..."

# Cleanup
./clean.sh

# Making .config
make neak_defconfig

# Compiling
./build.sh $ROOTFS_PATH
