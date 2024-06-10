/* SPDX-License-Identifier: GPL-2.0+ */

#ifndef __CONFIG_H
#define __CONFIG_H

#include <linux/sizes.h>

#define CONFIG_SYS_SDRAM_BASE		(0x80000000UL)

#define CONFIG_SYS_FLASH_BASE		0x20000000

#ifdef CONFIG_CMD_ONENAND
#define CFG_SYS_ONENAND_BASE		0x11010000
#endif

#define RISCV_MMODE_TIMERBASE		0x2000000
#define RISCV_MMODE_TIMER_FREQ		1000000
#define RISCV_SMODE_TIMER_FREQ		1000000

#define CONFIG_TFTP_PORT
#define CONFIG_TFTP_TSIZE

/* Environment options */
#ifndef CONFIG_SPL_BUILD

#define BOOTENV_DEV_QEMU(devtypeu, devtypel, instance) \
	"bootcmd_" #devtypel "=" \
		"if env exists kernel_start; then " \
			"bootm ${kernel_start} - ${fdtcontroladdr};" \
		"fi\0"

#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
	"bootcmd_" #devtypel #instance "=" \
		"if test ${mtdids} = '' || test ${mtdparts} = '' ; then " \
			"echo NAND boot disabled: No mtdids and/or mtdparts; " \
		"else " \
			"run nandboot; " \
		"fi\0"

#define BOOTENV_DEV_NAME_QEMU(devtypeu, devtypel, instance) \
	#devtypel #instance " "

#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
	#devtypel #instance " "

#define BOOT_TARGET_DEVICES(func) \
	func(VIRTIO, virtio, 0)

#include <config_distro_bootcmd.h>

#define CFG_EXTRA_ENV_SETTINGS			\
	"fdt_high=0xffffffffffffffff\0"		\
	"initrd_high=0xffffffffffffffff\0"	\
	"kernel_addr_r=0x80000000\0"		\
	"fdt_addr_r=0x82000000\0"			\
	"scriptaddr=0x82700000\0"			\
	"pxefile_addr_r=0x88100000\0"		\
	"ramdisk_addr_r=0x88200000\0"		\
	BOOTENV								\
	"boot_script_dhcp=/uboot/boot.scr"
#endif

#endif /* __CONFIG_H */
