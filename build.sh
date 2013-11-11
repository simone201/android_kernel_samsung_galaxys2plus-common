#!/bin/bash

# Set Default Path
TOP_DIR=$PWD
KERNEL_PATH="/home/simone/neak-gs2plus"

# Set toolchain and root filesystem path
TOOLCHAIN="/home/simone/android-toolchain-eabi-4.7/bin/arm-eabi-"
ROOTFS_PATH=$1

# Exports
export KERNEL_VERSION="N.E.A.K-S2PLUS-1.0x"
export KERNELDIR=$KERNEL_PATH

# First compile
make -j`grep 'processor' /proc/cpuinfo | wc -l` ARCH=arm CROSS_COMPILE=$TOOLCHAIN >> compile.log 2>&1 || exit -1

# Copying kernel modules
find -name '*.ko' -exec cp -av {} $ROOTFS_PATH/lib/modules/ \;
unzip VoiceSolution.zip -d $ROOTFS_PATH/lib/modules

# Recompile to make modules working
make -j`grep 'processor' /proc/cpuinfo | wc -l` ARCH=arm CROSS_COMPILE=$TOOLCHAIN || exit -1

# Copy Kernel Image
rm $KERNEL_PATH/releasetools/tar/$KERNEL_VERSION.tar
rm $KERNEL_PATH/releasetools/zip/$KERNEL_VERSION.zip
cp $KERNEL_PATH/arch/arm/boot/zImage .

# Create ramdisk.cpio archive
cd $ROOTFS_PATH
find . | cpio -o -H newc > ../ramdisk.cpio
cd ..

# Make boot.img
./mkbootimg --base 0 --pagesize 4096 --kernel_offset 0xa2008000 --ramdisk_offset 0xa3000000 --second_offset 0xa2f00000 --tags_offset 0xa2000100 --cmdline 'console=ttyS0,115200n8 mem=832M@0xA2000000 androidboot.console=ttyS0 vc-cma-mem=0/176M@0xCB000000' --kernel zImage --ramdisk ramdisk.cpio -o boot.img

# Copy boot.img
cp boot.img $KERNEL_PATH/releasetools/zip
cp boot.img $KERNEL_PATH/releasetools/tar

# Creating flashable zip and renaming boot.img
cd $KERNEL_PATH/releasetools/zip
zip -0 -r $KERNEL_VERSION.zip *
cd ..
cd tar
tar cf $KERNEL_VERSION.tar boot.img && ls -lh $KERNEL_VERSION.tar

# Cleanup
rm $KERNEL_PATH/releasetools/zip/boot.img
rm $KERNEL_PATH/releasetools/tar/boot.img
rm $KERNEL_PATH/zImage
