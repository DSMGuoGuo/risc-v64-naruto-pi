/**
 * @file naruto.h
 * @author JihongZhang (1042476967@qq.com)
 * @brief Naruto Pi QEMU
 * @version 0.1
 * @date 2024-04-15
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#ifndef HW_RISCV_NARUTO_H
#define HW_RISCV_NARUTO_H

#include "hw/riscv/riscv_hart.h"
#include "hw/sysbus.h"
#include "hw/block/flash.h"

/**
 * @brief CPU architecture.
 * 
 */
#define TYPE_NARUTO_CPU_CORE_ARCH	TYPE_RISCV_CPU_NARUTO

/**
 * @brief CPU reset vector address.
 * 
 */
#define NARUTO_RESET_VECTOR    0x0U

/**
 * @brief Naruto Pi description.
 * 
 */
#define NARUTO_PI_DESC		"Naruto Pi RISC-V Evaluation Kit"
#define NARUTO_PI_MANAGEMENT_CPU_COUNT		1U
#define NARUTO_PI_COMPUTE_CPU_COUNT			7U
#define NARUTO_PLIC_NUM_SOURCES				127U
#define NARUTO_PLIC_NUM_PRIORITIES			7U
#define NARUTO_PLIC_PRIORITY_BASE			0x04U
#define NARUTO_PLIC_PENDING_BASE			0x1000U
#define NARUTO_PLIC_ENABLE_BASE				0x2000U
#define NARUTO_PLIC_ENABLE_STRIDE			0x80U
#define NARUTO_PLIC_CONTEXT_BASE			0x200000U
#define NARUTO_PLIC_CONTEXT_STRIDE			0x1000U

/**
 * @brief Naruto device define of SOC.
 * 
 */
#define TYPE_NARUTO_SOC "naruto_soc"
#define RISCV_NARUTO_SOC(obj) \
OBJECT_CHECK(NarutoSoCState, (obj), TYPE_NARUTO_SOC)

typedef struct NarutoSoCState {
	/*< private >*/
	SysBusDevice parent_obj;
	/*< public >*/
	CPUClusterState m_cluster;
	RISCVHartArrayState m_cpus;
	CPUClusterState c_cluster;
	RISCVHartArrayState c_cpus;
	DeviceState *plic;
	DeviceState *pflash;
	PFlashCFI01 *flash;
	FWCfgState *fw_cfg;
} NarutoSoCState;

/**
 * @brief Naruto machine define.
 * 
 */
#define TYPE_NARUTO_MACHINE MACHINE_TYPE_NAME("naruto")
#define NARUTO_MACHINE(obj) \
OBJECT_CHECK(NarutoMachineState, (obj), TYPE_NARUTO_MACHINE)

typedef struct {
	/*< private >*/
	SysBusDevice parent_obj;
	/*< public >*/
	NarutoSoCState soc;
} NarutoMachineState;

/**
 * @brief Naruto device define.
 * 
 */
enum {
	NARUTO_SOC_RSVD0,
	NARUTO_SOC_ROM,
	NARUTO_SOC_SRAM,
	NARUTO_SOC_UART0,
	NARUTO_SOC_UART1,
	NARUTO_SOC_UART2,
	NARUTO_SOC_CLINT,
	NARUTO_SOC_PLIC,
	NARUTO_SOC_VIRTIO0,
	NARUTO_SOC_VIRTIO1,
	NARUTO_SOC_VIRTIO2,
	NARUTO_SOC_VIRTIO3,
	NARUTO_SOC_VIRTIO4,
	NARUTO_SOC_VIRTIO5,
	NARUTO_SOC_VIRTIO6,
	NARUTO_SOC_VIRTIO7,
	NARUTO_SOC_FW_CFG,
	NARUTO_SOC_PFLASH,
	NARUTO_SOC_DRAM,
};

enum {
	NARUTO_VIRTIO0_IRQ = 1,
	NARUTO_VIRTIO1_IRQ = 2,
	NARUTO_VIRTIO2_IRQ = 3,
	NARUTO_VIRTIO3_IRQ = 4,
	NARUTO_VIRTIO4_IRQ = 5,
	NARUTO_VIRTIO5_IRQ = 6,
	NARUTO_VIRTIO6_IRQ = 7,
	NARUTO_VIRTIO7_IRQ = 8,

	NARUTO_UART0_IRQ   = 10,
	NARUTO_UART1_IRQ   = 11,
	NARUTO_UART2_IRQ   = 12,
	NARUTO_RTC_IRQ     = 13,
	NARUTO_I2C0_IRQ    = 14,
	NARUTO_I2C1_IRQ    = 15,
	NARUTO_I2C2_IRQ    = 16,
	NARUTO_SPI0_IRQ    = 17,
	NARUTO_SPI1_IRQ    = 18,
	NARUTO_USB_IRQ     = 19,
	NARUTO_SDIO_IRQ    = 20,
	NARUTO_I2S_IRQ     = 21,
	NARUTO_NAND_IRQ    = 22,
	NARUTO_CAN_IRQ     = 23,
	NARUTO_ADC_IRQ     = 24,
	NARUTO_ETH_IRQ     = 25,
	NARUTO_LCDC_IRQ    = 26,
	NARUTO_WDT_IRQ     = 27,

	NARUTO_TIMER_IRQ   = 29, /* 29-31 */
	NARUTO_PWM_IRQ     = 32, /* 32-35 */
	NARUTO_GPIO_IRQ    = 36, /* 36-51 */
	NARUTO_DMA_IRQ     = 52, /* 52-59 */
};

#endif
