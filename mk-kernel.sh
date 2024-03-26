#!/bin/bash -e

export PATH="/opt/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1/bin:$PATH"
export CROSS_COMPILE=riscv64-unknown-linux-gnu-
export ARCH=riscv

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out

cd thead-kernel
sed -i '/CONFIG_DEBUG_INFO=y/d' arch/riscv/configs/revyos_defconfig
make revyos_defconfig
export KDEB_PKGVERSION="$(date "+%Y.%m.%d.%H.%M")+$(git rev-parse --short HEAD)"
sed -i '/CONFIG_LOCALVERSION_AUTO/d' .config && echo "CONFIG_LOCALVERSION_AUTO=n" >> .config
cat .config | grep "CONFIG_THEAD_ISA"
make -j$(nproc) bindeb-pkg LOCALVERSION="-1" ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-

mv ../linux-*.buildinfo ${OUT}
mv ../linux-*.changes ${OUT}
mv ../linux-*.deb ${OUT}

echo -e "\e[36m Kernel build: success! \e[0m"
