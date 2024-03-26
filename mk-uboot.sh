#!/bin/bash -e

export PATH="/opt/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1/bin:$PATH"
export ARCH=riscv
export CROSS_COMPILE=riscv64-unknown-linux-gnu-

LOCALPATH=$(pwd)
OUT=${LOCALPATH}/out

[ ! -d ${OUT} ] && mkdir -p ${OUT}

usage() {
    echo "====USAGE: mk-uboot.sh -b <board_name> -d <ddr_rank>===="
    echo "mk-uboot.sh -b milkv-meles -d dualrank"
}

while getopts "b:d:h" flag; do
    case $flag in
	b)
	    export BOARD="$OPTARG"
	    ;;
	d)
	    export DDRRANK="$OPTARG"
	    ;;
    esac
done

if [ ! $BOARD ] || [ ! $DDRRANK ]; then
    usage
    exit
fi

case ${BOARD} in
	"milkv-meles")
		UBOOT_DEFCONFIG=light_milkv_meles_${DDRRANK}_defconfig
		;;
	*)
		echo "board '${BOARD}' not supported!"
		exit -1
		;;
esac

cd thead-u-boot

make ${UBOOT_DEFCONFIG}
make -j BUILD_TYPE=RELEASE

cp u-boot-with-spl.bin ${OUT}/u-boot-with-spl-${DDRRANK}-2020.01-g$(git rev-parse --short HEAD).bin

echo -e "\e[36m U-Boot build: success! \e[0m"
