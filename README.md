# T-HEAD Revyos SDK

Below is the instructions of how to build image for T-HEAD Revyos on a HOST PC.

## Download docker

Follow this guide, https://docs.docker.com/get-docker/, to install docker first on HOST PC.

Download milkvhaaland/ubuntu2204 docker.

```
docker pull milkvhaaland/ubuntu2204:v1.3
```

## Start container

meles-ubuntu2204-v1.3 is just an example, you can set your own name.

```
docker run --rm --privileged --name meles-ubuntu2204-v1.3 -v $PWD:/workspace -it milkvhaaland/ubuntu2204:v1.3
```

## Get the source code

```
mkdir -p /workspace/thead-sdk && cd /workspace/thead-sdk
git clone https://github.com/milkv-meles/thead-u-boot.git -b meles
git clone https://github.com/milkv-meles/thead-kernel.git -b meles
git clone https://github.com/milkv-meles/thead-bin.git -b main
git clone https://github.com/milkv-meles/build.git -b main
```

## Build U-Boot

### Build DDR singlerank board

```
cd /workspace/thead-sdk
./build/mk-uboot.sh -b milkv-meles -d singlerank
```

And you will get `out/u-boot-with-spl-singlerank-2020.01-gce1890d0dc.bin`

### Build DDR dualrank board

```
cd /workspace/thead-sdk
./build/mk-uboot.sh -b milkv-meles -d dualrank
```

And you will get `out/u-boot-with-spl-dualrank-2020.01-gce1890d0dc.bin`

## Build Kernel

```
cd /workspace/thead-sdk
./build/mk-kernel.sh
```

And you will get kernel packages under `out` directory.
