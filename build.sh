#!/bin/bash

if [ -d "./output" ]; then
	echo "---------------------------- 进入自动脚本 ----------------------"
else
	echo "---------------------------- 进入自动脚本 ----------------------"
	mkdir ./output
	mkdir ./output/qemu
fi
PROJECT_DIR=$(pwd)

ROOTFS_SEL=${2:-busybox}

TRUSTED_DOMAIN_SEL=${3:-freertos}

NUMBER_OF_CPU=-j4

COMPILE_SOURCE_CODE_PATH=$PROJECT_DIR/compile_tools
COMPILE_PATH=$COMPILE_SOURCE_CODE_PATH/output/linux
COMPILE_NEWLIB_PATH=$COMPILE_SOURCE_CODE_PATH/output/bare-metal
COMPILE_NEWLIB_TOOLS_PATH=$COMPILE_NEWLIB_PATH/bin
COMPILE_TOOLS_PATH=$COMPILE_PATH/bin
COMPILE_LIB_PATH=$COMPILE_PATH/sysroot
COMPILE_TOOLS=riscv64-unknown-linux-gnu
COMPILE_NEWLIB_TOOLS=riscv64-unknown-elf

QEMU_OUTPUT_PATH=$PROJECT_DIR/output/qemu
QEMU_PATH=$QEMU_OUTPUT_PATH/bin

export PATH=$PATH:$QEMU_PATH
export PATH=$PATH:$COMPILE_TOOLS_PATH

OUTPUT_IMG_PATH=$PROJECT_DIR/output
DTS_PATH=$PROJECT_DIR/dts
SBI_SOURCE_PATH=$PROJECT_DIR/opensbi
QEMU_SOURCE_PATH=$PROJECT_DIR/qemu-9.0.0-rc3
UBOOT_SOURCE_PATH=$PROJECT_DIR/u-boot
KERNEL_SOURCE_PATH=$PROJECT_DIR/linux-6.9-rc3
ROOTFS_PATH=$PROJECT_DIR/rootfs
BUILD_ROOTFS_PATH=$PROJECT_DIR/rootfs_build

BAREMETAL_PATH=$PROJECT_DIR/baremetal
BOOT_PATH=$PROJECT_DIR/boot
LOWLEVEL_FW_PATH=$BOOT_PATH/lowlevelinit
UBUNTU20_ROOTFS_PATH=$ROOTFS_PATH/ubuntu20.04
BUSYBOX_SOURCE_PATH=$ROOTFS_PATH/busybox
BUSYBOX_CONFIG_PATH=$ROOTFS_PATH/busybox_config
BAREMETAL_PROJECT=$BAREMETAL_PATH/bare-metal

BARE_METAL_PATH=bare-metal
BARE_METAL_IMG_NAME=main

FREERTOS_PATH=$PROJECT_DIR/freertos

SBI_IMG_NAME=naruto_sbi
SBI_DTS_NAME=naruto_sbi
UBOOT_DTS_NAME=naruto_uboot
LOWLEVEL_FW_NAME=lowlevelinit

BUILD_TARGET=$1

build_clean()
{
	echo "---------------------------- 删除编译文件 ----------------------"
	cd $QEMU_SOURCE_PATH
	make clean
	cd $SBI_SOURCE_PATH
	make clean
	cd $UBOOT_SOURCE_PATH
	make clean
	cd $KERNEL_SOURCE_PATH
	make clean
	rm -rf $OUTPUT_IMG_PATH/*
}

build_qemu_defconfig()
{
	echo "---------------------------- 配置QEMU -------------------------"
	cd $QEMU_SOURCE_PATH
	./configure --target-list=riscv64-softmmu,riscv64-linux-user --prefix=$QEMU_OUTPUT_PATH
}

build_qemu()
{
	echo "---------------------------- 编译QEMU -------------------------"
	cd $QEMU_SOURCE_PATH
	make $NUMBER_OF_CPU
	sudo make install
}

build_lowlevelinit()
{
	echo "---------------------------- 编译lowlevelinit ------------------"
	cd $LOWLEVEL_FW_PATH

	if [ ! -d "$OUTPUT_IMG_PATH/lowinit" ]; then
		mkdir $OUTPUT_IMG_PATH/lowinit
	fi

	$COMPILE_TOOLS-gcc -x assembler-with-cpp -c startup.S -o ./startup.o

	$COMPILE_TOOLS-gcc -nostartfiles -T./boot.lds -Wl,-Map=$OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.map -Wl,--gc-sections ./startup.o -o $OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.elf

	$COMPILE_TOOLS-objcopy -O binary -S $OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.elf $OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.bin

	$COMPILE_TOOLS_PATH/$COMPILE_TOOLS-objdump --source --demangle --disassemble --reloc --wide $OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.elf > $OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.lst

	rm -rf ./startup.o
}

build_sbi()
{
	echo "---------------------------- 编译SBI --------------------------"
	cd $SBI_SOURCE_PATH
	
	if [ ! -d "$OUTPUT_IMG_PATH/opensbi" ]; then
		mkdir $OUTPUT_IMG_PATH/opensbi
	fi

	make all PLATFORM=naruto CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- PLATFORM_RISCV_XLEN=64
	cp $SBI_SOURCE_PATH/build/platform/naruto/firmware/fw_jump.bin $OUTPUT_IMG_PATH/opensbi/
	$COMPILE_TOOLS_PATH/$COMPILE_TOOLS-objdump --source --demangle --disassemble --reloc --wide $SBI_SOURCE_PATH/build/platform/naruto/firmware/fw_jump.elf > $OUTPUT_IMG_PATH/opensbi/fw_jump.lst
}

build_sbi_dtb()
{
	echo "---------------------------- 编译SBI设备树 ---------------------"
	cd $DTS_PATH/

	if [ ! -d "$OUTPUT_IMG_PATH/dts" ]; then
		mkdir $OUTPUT_IMG_PATH/dts
	fi

	rm -rf $OUTPUT_IMG_PATH/dts/$SBI_DTS_NAME*
	cpp -nostdinc -I include -undef -x assembler-with-cpp $SBI_DTS_NAME.dts > $OUTPUT_IMG_PATH/dts/$SBI_DTS_NAME.dtb.dts.tmp
	dtc -i $SBI_DTS_NAME.dts -I dts -O dtb -o $OUTPUT_IMG_PATH/dts/$SBI_DTS_NAME.dtb $OUTPUT_IMG_PATH/dts/$SBI_DTS_NAME.dtb.dts.tmp 
}

build_uboot_defconfig()
{
	echo "---------------------------- 配置U-boot ------------------------"
	cd $UBOOT_SOURCE_PATH
	make CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- qemu-naruto_pi_defconfig
}

build_uboot()
{
	echo "---------------------------- 编译U-boot ------------------------"
	cd $UBOOT_SOURCE_PATH/

	if [ ! -d "$OUTPUT_IMG_PATH/uboot" ]; then
		mkdir $OUTPUT_IMG_PATH/uboot
	fi

	make CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- $NUMBER_OF_CPU DEVICE_TREE=../../../../output/dts/$UBOOT_DTS_NAME
	cp $UBOOT_SOURCE_PATH/u-boot $OUTPUT_IMG_PATH/uboot/u-boot.elf
	cp $UBOOT_SOURCE_PATH/u-boot.map $OUTPUT_IMG_PATH/uboot/u-boot.map
	cp $UBOOT_SOURCE_PATH/u-boot.bin $OUTPUT_IMG_PATH/uboot/u-boot.bin
	$COMPILE_TOOLS_PATH/$COMPILE_TOOLS-objdump --source --demangle --disassemble --reloc --wide $OUTPUT_IMG_PATH/uboot/u-boot.elf > $OUTPUT_IMG_PATH/uboot/u-boot.lst
}

build_uboot_dtb()
{
	echo "---------------------------- 编译U-boot设备树 -------------------"
	cd $DTS_PATH/

	if [ ! -d "$OUTPUT_IMG_PATH/dts" ]; then
		mkdir $OUTPUT_IMG_PATH/dts
	fi

	rm -rf $OUTPUT_IMG_PATH/dts/$UBOOT_DTS_NAME*
	cpp -nostdinc -I include -undef -x assembler-with-cpp $UBOOT_DTS_NAME.dts > $OUTPUT_IMG_PATH/dts/$UBOOT_DTS_NAME.dtb.dts.tmp
	dtc -i $UBOOT_DTS_NAME.dts -I dts -O dtb -o $OUTPUT_IMG_PATH/dts/$UBOOT_DTS_NAME.dtb $OUTPUT_IMG_PATH/dts/$UBOOT_DTS_NAME.dtb.dts.tmp 
}

build_kernel_defconfig()
{
	echo "---------------------------- 配置kernel config -----------------"
	cd $KERNEL_SOURCE_PATH
	make ARCH=riscv CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- qemu-naruto_pi_defconfig
}

build_kernel()
{
	echo "---------------------------- 编译kernel config -----------------"
	cd $KERNEL_SOURCE_PATH

	if [ ! -d "$OUTPUT_IMG_PATH/linux_kernel" ]; then
		mkdir $OUTPUT_IMG_PATH/linux_kernel
	fi

	make ARCH=riscv CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- $NUMBER_OF_CPU
	cp $KERNEL_SOURCE_PATH/arch/riscv/boot/Image $OUTPUT_IMG_PATH/linux_kernel/Image
}

build_ubuntu()
{
	echo "---------------------------- 解压ubuntu -------------------------"
	cd $UBUNTU20_ROOTFS_PATH
	sudo rm -rf $UBUNTU20_ROOTFS_PATH/rootfs
	cat rootfs.tar.bz2.* > rootfs.tar.bz2
	sudo tar -xjf $UBUNTU20_ROOTFS_PATH/rootfs.tar.bz2 -C $UBUNTU20_ROOTFS_PATH/
}

build_tar_ubuntu()
{
	echo "---------------------------- 压缩ubuntu -------------------------"
	cd $UBUNTU20_ROOTFS_PATH
	rm -rf $UBUNTU20_ROOTFS_PATH/rootfs.tar.bz2
	sudo tar -cjf rootfs.tar.bz2 rootfs
	split -b 10M -d -a 3 rootfs.tar.bz2 rootfs.tar.bz2.
}

build_busybox()
{
	echo "---------------------------- 编译busybox -------------------------"
	if [ ! -d "$OUTPUT_IMG_PATH/busybox" ]; then
		mkdir $OUTPUT_IMG_PATH/busybox
	fi

	sudo rm -rf $OUTPUT_IMG_PATH/busybox

	cd $BUSYBOX_SOURCE_PATH/
	make ARCH=riscv CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- qemu-naruto_pi_defconfig
	make ARCH=riscv CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- $NUMBER_OF_CPU
	make ARCH=riscv CROSS_COMPILE=$COMPILE_TOOLS_PATH/$COMPILE_TOOLS- install
}

build_baremetal()
{
	echo "---------------------------- 编译baremetal -------------------------"
	cd $BAREMETAL_PROJECT/
	make CROSS_COMPILE=$COMPILE_NEWLIB_TOOLS_PATH/$COMPILE_NEWLIB_TOOLS- clean
	make CROSS_COMPILE=$COMPILE_NEWLIB_TOOLS_PATH/$COMPILE_NEWLIB_TOOLS- $NUMBER_OF_CPU

	if [ ! -d "$OUTPUT_IMG_PATH/trusted_domain" ]; then
		mkdir $OUTPUT_IMG_PATH/trusted_domain
	fi

	cp ./build/trusted_fw.* $OUTPUT_IMG_PATH/trusted_domain/
}

build_freertos()
{
	echo "---------------------------- 编译FreeRTOS -------------------------"
	cd $FREERTOS_PATH
	make CROSS_COMPILE=$COMPILE_NEWLIB_TOOLS_PATH/$COMPILE_NEWLIB_TOOLS- clean
	make CROSS_COMPILE=$COMPILE_NEWLIB_TOOLS_PATH/$COMPILE_NEWLIB_TOOLS- $NUMBER_OF_CPU

	if [ ! -d "$OUTPUT_IMG_PATH/trusted_domain" ]; then
		mkdir $OUTPUT_IMG_PATH/trusted_domain
	fi

	cp ./build/trusted_fw.* $OUTPUT_IMG_PATH/trusted_domain/
}

build_make_image()
{
	echo "---------------------------- 制作image -------------------------"
	cd $OUTPUT_IMG_PATH/
	rm -rf fw.bin
	dd of=fw.bin bs=1k count=32k if=/dev/zero
	dd of=fw.bin bs=1k conv=notrunc seek=0 if=$OUTPUT_IMG_PATH/lowinit/$LOWLEVEL_FW_NAME.bin
	dd of=fw.bin bs=1k conv=notrunc seek=512 if=$OUTPUT_IMG_PATH/dts/$SBI_DTS_NAME.dtb
	dd of=fw.bin bs=1k conv=notrunc seek=1K if=$OUTPUT_IMG_PATH/dts/$UBOOT_DTS_NAME.dtb
	dd of=fw.bin bs=1k conv=notrunc seek=2K if=$OUTPUT_IMG_PATH/opensbi/fw_jump.bin
	dd of=fw.bin bs=1k conv=notrunc seek=4K if=$OUTPUT_IMG_PATH/trusted_domain/trusted_fw.bin
	dd of=fw.bin bs=1k conv=notrunc seek=8K if=$OUTPUT_IMG_PATH/uboot/u-boot.bin

	sudo rm -rf $OUTPUT_IMG_PATH/rootfs

	if [ ! -d "$OUTPUT_IMG_PATH/rootfs" ]; then
		mkdir $OUTPUT_IMG_PATH/rootfs
	fi

	if [ ! -d "$OUTPUT_IMG_PATH/rootfs/rootfs" ]; then
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs
	fi

	if [ ! -d "$OUTPUT_IMG_PATH/rootfs/bootfs" ]; then
		mkdir $OUTPUT_IMG_PATH/rootfs/bootfs
	fi

	cd $OUTPUT_IMG_PATH/rootfs
	if [ ! -f "$OUTPUT_IMG_PATH/rootfs/rootfs.img" ]; then
		dd if=/dev/zero of=rootfs.img bs=1M count=1024
		sudo $BUILD_ROOTFS_PATH/generate_rootfs.sh $OUTPUT_IMG_PATH/rootfs/rootfs.img $BUILD_ROOTFS_PATH/sfdisk
	fi

	cp $OUTPUT_IMG_PATH/linux_kernel/Image $OUTPUT_IMG_PATH/rootfs/bootfs/Image
	cp $OUTPUT_IMG_PATH/dts/naruto_uboot.dtb $OUTPUT_IMG_PATH/rootfs/bootfs/naruto_uboot.dtb

	sudo $UBOOT_SOURCE_PATH/tools/mkimage -A riscv -O linux -T script -C none -a 0 -e 0 -n "Distro Boot Script" -d $DTS_PATH/uboot_fs.cmd $OUTPUT_IMG_PATH/rootfs/bootfs/boot.scr

	if [ "$ROOTFS_SEL" == "busybox" ]; then
		#busybox
		cp -r $OUTPUT_IMG_PATH/busybox/* $OUTPUT_IMG_PATH/rootfs/rootfs/
		cp -r $BUSYBOX_CONFIG_PATH/* $OUTPUT_IMG_PATH/rootfs/rootfs/
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs/proc
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs/sys
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs/dev
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs/tmp
		mkdir $OUTPUT_IMG_PATH/rootfs/rootfs/lib
		cd $OUTPUT_IMG_PATH/rootfs/rootfs/
		ln -s ./lib ./lib64
		cp -ra $COMPILE_LIB_PATH/lib/* $OUTPUT_IMG_PATH/rootfs/rootfs/lib/
		cp -ra $COMPILE_LIB_PATH/usr/bin/* $OUTPUT_IMG_PATH/rootfs/rootfs/usr/bin/
	elif [ "$ROOTFS_SEL" == "ubuntu" ]; then
		#ubuntu
		sudo cp -ra $UBUNTU20_ROOTFS_PATH/rootfs/* $OUTPUT_IMG_PATH/rootfs/rootfs
	fi

	sudo $BUILD_ROOTFS_PATH/build.sh $OUTPUT_IMG_PATH/rootfs
}

build_compile_tools()
{
	echo "---------------------------- 编译编译工具链 -------------------------"
	if [ ! -d "$COMPILE_SOURCE_CODE_PATH" ]; then
		mkdir $COMPILE_SOURCE_CODE_PATH
	fi

	if [ ! -d "$COMPILE_SOURCE_CODE_PATH/output" ]; then
                mkdir $COMPILE_SOURCE_CODE_PATH/output
        fi

	if [ ! -d "$COMPILE_SOURCE_CODE_PATH/output/linux" ]; then
                mkdir $COMPILE_SOURCE_CODE_PATH/output/linux
        fi

	if [ ! -d "$COMPILE_SOURCE_CODE_PATH/output/bare-metal" ]; then
                mkdir $COMPILE_SOURCE_CODE_PATH/output/bare-metal
        fi

	cd $COMPILE_SOURCE_CODE_PATH

	git clone  https://gitee.com/mirrors/riscv-gnu-toolchain
	cd riscv-gnu-toolchain
	git clone https://gitee.com/mirrors/riscv-newlib
	git clone https://gitee.com/mirrors/riscv-binutils-gdb
	git clone https://gitee.com/mirrors/riscv-dejagnu
	git clone https://gitee.com/mirrors/riscv-glibc
	git clone https://gitee.com/mirrors/riscv-gcc
	./configure --prefix=$COMPILE_SOURCE_CODE_PATH/output/linux
	make linux $NUMBER_OF_CPU
	./configure --prefix=$COMPILE_SOURCE_CODE_PATH/output/bare-metal --with-cmodel=medany
	make $NUMBER_OF_CPU
}

build_all()
{
	build_qemu_defconfig
	build_qemu
	build_lowlevelinit
	build_sbi_dtb
	build_uboot_dtb
	build_sbi
	build_uboot_defconfig
	build_uboot
	build_kernel_defconfig
	build_kernel
	if [ "$ROOTFS_SEL" == "busybox" ]; then
		build_busybox
	elif [ "$ROOTFS_SEL" == "ubuntu" ]; then
		build_ubuntu
	fi

	if [ "$TRUSTED_DOMAIN_SEL" == "baremetal" ]; then
		build_baremetal
	elif [ "$TRUSTED_DOMAIN_SEL" == "freertos" ]; then
		build_freertos
	fi

	build_make_image
}

case "$BUILD_TARGET" in
--help)
	echo_usage
	exit 0
	;;
qemu_defconfig)
	build_qemu_defconfig
	;;
qemu)
	build_qemu
	;;
lowinit)
	build_lowlevelinit
	;;
sbi_dtb)
	build_sbi_dtb
	;;
sbi)
	build_sbi
	;;
uboot_defconfig)
	build_uboot_defconfig
	;;
uboot)
	build_uboot
	;;
uboot_dtb)
	build_uboot_dtb
	;;
kernel_defconfig)
	build_kernel_defconfig
	;;
kernel)
	build_kernel
	;;
ubuntu)
	build_ubuntu
	;;
tar_ubuntu)
	build_tar_ubuntu
	;;
busybox)
	build_busybox
	;;
baremetal)
	build_baremetal
	;;
freertos)
	build_freertos
	;;
image)
	build_make_image
	;;
compile)
	build_compile_tools
	;;
all)
	build_all
	;;

clean)
	build_clean
	;;
*)
	echo "Unknown target: $BUILD_TARGET"
	exit 255
	;;
esac

echo "---------------------------- 结束 ------------------------------"
