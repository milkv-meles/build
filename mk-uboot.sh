#!/bin/bash -e

export PATH="/opt/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1/bin:$PATH"
export ARCH=riscv
export CROSS_COMPILE=riscv64-unknown-linux-gnu-

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out

[ ! -d ${OUT} ] && mkdir -p ${OUT}

cd thead-u-boot

make distclean
make light_milkv_meles_16g_defconfig
make -j$(nproc)
find . -name "u-boot-with-spl.bin" | xargs -I{} cp -av {} ${OUT}/u-boot-with-spl-meles-16g.bin

make distclean
make light_milkv_meles_dualrank_defconfig
make -j$(nproc)
find . -name "u-boot-with-spl.bin" | xargs -I{} cp -av {} ${OUT}/u-boot-with-spl-meles.bin

make distclean
make light_milkv_meles_singlerank_defconfig
make -j$(nproc)
find . -name "u-boot-with-spl.bin" | xargs -I{} cp -av {} ${OUT}/u-boot-with-spl-meles-4g.bin

echo -e "\e[36m U-Boot build: success! \e[0m"
