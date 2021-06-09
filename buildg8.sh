#!/bin/bash
echo fuck lg
rm Build/* -rf
# based on the instructions from edk2-platform
set -e
export PYTHON_COMMAND=python2.7
. build_common.sh
# not actually GCC5; it's GCC7 on Ubuntu 18.04.


GCC5_AARCH64_PREFIX=aarch64-linux-gnu- build -s -n 0 -a AARCH64 -t GCC5 -p F11/lg8.dsc
gzip -c < Build/F11/DEBUG_GCC5/FV/F11_UEFI.fd >uefi_image
cat dtbs/lg8.dtb >>g8
abootimg --create lg8-uefi.img -k g8 -r out/ramdisk-null -f out/bootimg.cfg
