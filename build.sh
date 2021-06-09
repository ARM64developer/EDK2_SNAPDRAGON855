#!/bin/bash
echo del last build things && rm Build/* -rf
rm -rf Build/F11/DEBUG_GCC5/FV/Ffs/7E374E25-8E01-4FEE-87F2-390C23C606CDFVMAIN
# based on the instructions from edk2-platform
set -e
export PYTHON_COMMAND=python2.7
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.
GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p F11/F11.dsc
gzip -c < Build/F11/DEBUG_GCC5/FV/F11_UEFI.fd >uefi_image
cp uefi_image out/mi9
cp uefi_image out/F11
cp uefi_image out/op7
cp uefi_image out/lgv50
#cp uefi_image out/tp1803

cat dtbs/SM8150-MI9.dtb >>out/mi9
cat dtbs/SM8150.dtb >>out/F11
cat dtbs/op7.dtb >>out/op7
cat dtbs/lgv50.dtb >>out/lgv50
#cat dtbs/mini5g.dtb >>out/tp1803

abootimg --create out/MI9-uefi.img -k out/mi9 -r ramdisk-null -f bootimg.cfg
abootimg --create out/v50-uefi.img -k out/lgv50 -r ramdisk-null -f bootimg.cfg
abootimg --create out/op7-uefi.img -k out/op7 -r ramdisk-null -f bootimg.cfg
abootimg --create out/F11-uefi.img -k out/F11 -r ramdisk-null -f bootimg.cfg
#abootimg --create out/mini5g-uefi.img -k out/tp1803 -r out/ramdisk-null -f out/bootimg.cfg
