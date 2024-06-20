/**
 * @file naruto.c
 * @author JihongZhang (1042476967@qq.com)
 * @brief Naruto Pi QEMU
 * @version 0.1
 * @date 2024-04-15
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#include "qemu/osdep.h"
#include "qemu/log.h"
#include "qemu/error-report.h"
#include "qemu/units.h"
#include "qemu/cutils.h"
#include "qapi/error.h"
#include "hw/boards.h"
#include "hw/loader.h"
#include "hw/sysbus.h"
#include "chardev/char.h"
#include "hw/cpu/cluster.h"
#include "target/riscv/cpu.h"
#include "hw/misc/unimp.h"
#include "hw/riscv/boot.h"
#include "hw/riscv/riscv_hart.h"
#include "hw/intc/riscv_aclint.h"
#include "sysemu/device_tree.h"
#include "sysemu/sysemu.h"
#include "hw/riscv/naruto.h"
#include "hw/intc/sifive_plic.h"
#include "hw/block/flash.h"
#include "hw/char/serial.h"
#include "hw/misc/naruto-misc.h"

static const MemMapEntry naruto_soc_memmap[] = {
	[NARUTO_SOC_ROM]			= {0x00000000,	0x8000},
	[NARUTO_SOC_SRAM]			= {0x00008000,	0x8000},
	[NARUTO_SOC_SYSCON]			= {0x00100000,	0x1000},
	[NARUTO_SOC_CLINT]			= {0x02000000,	0x10000},
	[NARUTO_SOC_PLIC]			= {0x0c000000,	0x4000000},
	[NARUTO_SOC_UART0]			= {0x10000000,	0x1000},
	[NARUTO_SOC_UART1]			= {0x10001000,	0x1000},
	[NARUTO_SOC_UART2]			= {0x10002000,	0x1000},
	[NARUTO_SOC_RTC]			= {0x10003000,	0x1000},
	[NARUTO_SOC_VIRTIO0]		= {0x10100000,	0x1000},
	[NARUTO_SOC_VIRTIO1]		= {0x10101000,	0x1000},
	[NARUTO_SOC_VIRTIO2]		= {0x10102000,	0x1000},
	[NARUTO_SOC_VIRTIO3]		= {0x10103000,	0x1000},
	[NARUTO_SOC_VIRTIO4]		= {0x10104000,	0x1000},
	[NARUTO_SOC_VIRTIO5]		= {0x10105000,	0x1000},
	[NARUTO_SOC_VIRTIO6]		= {0x10106000,	0x1000},
	[NARUTO_SOC_VIRTIO7]		= {0x10107000,	0x1000},
	[NARUTO_SOC_FW_CFG]			= {0x10108000,	0x18},
	[NARUTO_SOC_PFLASH]			= {0x20000000,	0x2000000},
	[NARUTO_SOC_DRAM]			= {0x80000000,	0},
};

/* Enter create naruto SOC device. */

/**
 * @brief Naruto Pi create and initial cluster and core.
 * 
 */
static void naruto_cpu_init(Object *obj)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(obj);
	MachineState *ms = MACHINE(qdev_get_machine());

	/* Initialize cluster 1. */
	object_initialize_child(obj, "cluster0", &s->c_cluster, TYPE_CPU_CLUSTER);
	qdev_prop_set_uint32(DEVICE(&s->c_cluster), "cluster-id", 0);
	/* Bind CPU to cluster1. */
	object_initialize_child(OBJECT(&s->c_cluster), "c-cpus", &s->c_cpus,
							TYPE_RISCV_HART_ARRAY);
	/* Initialize cluster 1 cpu. */
	/* Number of CPUs for initializing hardware threads. */
	qdev_prop_set_uint32(DEVICE(&s->c_cpus), "num-harts",
						NARUTO_PI_COMPUTE_CPU_COUNT);
	/* Initialize CPU hardware thread initialization value. */
	qdev_prop_set_uint32(DEVICE(&s->c_cpus), "hartid-base", 0);
	/* Initialize CPU type. */
	qdev_prop_set_string(DEVICE(&s->c_cpus), "cpu-type", ms->cpu_type);
	/* Set CPU reset vector address. */
	qdev_prop_set_uint64(DEVICE(&s->c_cpus), "resetvec", 
						naruto_soc_memmap[NARUTO_SOC_ROM].base);

	/* Initialize cluster 0. */
	object_initialize_child(obj, "cluster1", &s->m_cluster,
							TYPE_CPU_CLUSTER);
	qdev_prop_set_uint32(DEVICE(&s->m_cluster), "cluster-id", 1);
	/* Bind CPU to cluster 0. */
	object_initialize_child(OBJECT(&s->m_cluster), "m-cpus",
							&s->m_cpus, TYPE_RISCV_HART_ARRAY);
	/* Initialize cluster 0 cpu. */
	/* Number of CPUs for initializing hardware threads. */
	qdev_prop_set_uint32(DEVICE(&s->m_cpus), "num-harts",
						NARUTO_PI_MANAGEMENT_CPU_COUNT);
	/* Initialize CPU hardware thread initialization value. */
	qdev_prop_set_uint32(DEVICE(&s->m_cpus), "hartid-base", 7);
	/* Initialize CPU type. */
	qdev_prop_set_string(DEVICE(&s->m_cpus), "cpu-type", ms->cpu_type);
	/* Set CPU reset vector address. */
	qdev_prop_set_uint64(DEVICE(&s->m_cpus),
						"resetvec",
						naruto_soc_memmap[NARUTO_SOC_ROM].base);
}

/**
 * @brief Naruto Pi CPU realize.
 * 
 * @param dev 
 */
static void naruto_cpu_realize(DeviceState *dev)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);

	/* Initialize cpu */
	sysbus_realize(SYS_BUS_DEVICE(&s->c_cpus), &error_abort);
	/* Initialize cluster. Note: cluster must be create after cpu core. */
	qdev_realize(DEVICE(&s->c_cluster), NULL, &error_abort);

	/* Initialize cpu */
	sysbus_realize(SYS_BUS_DEVICE(&s->m_cpus), &error_abort);
	/* Initialize cluster. Note: cluster must be create after cpu core. */
	qdev_realize(DEVICE(&s->m_cluster), NULL, &error_abort);
}

/**
 * @brief Naruto Pi PLIC realize.
 * 
 * @param dev 
 */
static void naruto_plic_realize(DeviceState *dev)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);
	MachineState *ms = MACHINE(qdev_get_machine());
	char *plic_hart_config;

	/* Initialize CLINT. */
	riscv_aclint_swi_create(naruto_soc_memmap[NARUTO_SOC_CLINT].base,
							0, ms->smp.cpus, false);
	riscv_aclint_mtimer_create(
		naruto_soc_memmap[NARUTO_SOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
		RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
		RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
		RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
	/* Initialize PLIC. */
	/* create PLIC hart topology configuration string */
	plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
	s->plic = sifive_plic_create(naruto_soc_memmap[NARUTO_SOC_PLIC].base,
		plic_hart_config, ms->smp.cpus, 0,
		NARUTO_PLIC_NUM_SOURCES,
		NARUTO_PLIC_NUM_PRIORITIES,
		NARUTO_PLIC_PRIORITY_BASE,
		NARUTO_PLIC_PENDING_BASE,
		NARUTO_PLIC_ENABLE_BASE,
		NARUTO_PLIC_ENABLE_STRIDE,
		NARUTO_PLIC_CONTEXT_BASE,
		NARUTO_PLIC_CONTEXT_STRIDE,
		naruto_soc_memmap[NARUTO_SOC_PLIC].size);
	g_free(plic_hart_config);
}

/**
 * @brief Naruto Pi PFLASH realize.
 * 
 * @param dev 
 */
static void naruto_pflash_realize(DeviceState *dev)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);
	MemoryRegion *system_memory = get_system_memory();
	uint64_t flash_sector_size;

	/* Initialize pFlash */
	s->pflash = qdev_new(TYPE_PFLASH_CFI01);
	flash_sector_size = 256 * KiB;
	qdev_prop_set_uint64(s->pflash, "sector-length", flash_sector_size);
	qdev_prop_set_uint8(s->pflash, "width", 4);
	qdev_prop_set_uint8(s->pflash, "device-width", 2);
	qdev_prop_set_bit(s->pflash, "big-endian", false);
	qdev_prop_set_uint16(s->pflash, "id0", 0x89);
	qdev_prop_set_uint16(s->pflash, "id1", 0x18);
	qdev_prop_set_uint16(s->pflash, "id2", 0x00);
	qdev_prop_set_uint16(s->pflash, "id3", 0x00);
	qdev_prop_set_string(s->pflash, "name", "naruto.flash0");
	object_property_add_child(OBJECT(s), "naruto.flash0",
							OBJECT(s->pflash));
	object_property_add_alias(OBJECT(s), "pflash0",
							OBJECT(s->pflash), "drive");
	s->flash = PFLASH_CFI01(s->pflash);
	pflash_cfi01_legacy_drive(s->flash, drive_get(IF_PFLASH, 0, 0));

	assert(QEMU_IS_ALIGNED(naruto_soc_memmap[NARUTO_SOC_PFLASH].size,
							flash_sector_size));
	assert(naruto_soc_memmap[NARUTO_SOC_PFLASH].size /
							flash_sector_size <= UINT32_MAX);
	qdev_prop_set_uint32(s->pflash, "num-blocks", 
		naruto_soc_memmap[NARUTO_SOC_PFLASH].size / flash_sector_size);
	sysbus_realize_and_unref(SYS_BUS_DEVICE(s->pflash), &error_fatal);
	memory_region_add_subregion(system_memory, 
				naruto_soc_memmap[NARUTO_SOC_PFLASH].base,
				sysbus_mmio_get_region(SYS_BUS_DEVICE(s->pflash), 0));
}

/**
 * @brief Naruto Pi UART realize.
 * 
 * @param dev 
 */
static void naruto_uart_realize(DeviceState *dev)
{
	/* Initialize uart. */
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);
	MemoryRegion *system_memory = get_system_memory();

	serial_mm_init(system_memory, naruto_soc_memmap[NARUTO_SOC_UART0].base,
		0, qdev_get_gpio_in(DEVICE(s->plic), NARUTO_UART0_IRQ),
		399193, serial_hd(0), DEVICE_LITTLE_ENDIAN);
	serial_mm_init(system_memory, naruto_soc_memmap[NARUTO_SOC_UART1].base,
		0, qdev_get_gpio_in(DEVICE(s->plic), NARUTO_UART1_IRQ),
		399193, serial_hd(1), DEVICE_LITTLE_ENDIAN);
	serial_mm_init(system_memory, naruto_soc_memmap[NARUTO_SOC_UART2].base,
		0, qdev_get_gpio_in(DEVICE(s->plic), NARUTO_UART2_IRQ),
		399193, serial_hd(2), DEVICE_LITTLE_ENDIAN);
}

/**
 * @brief Naruto Pi VIRTIO realize.
 * 
 * @param dev 
 */
static void naruto_virtio_realize(DeviceState *dev)
{
	/* Initialize virtio. */
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);

	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO0].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO0_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO1].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO1_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO2].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO2_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO3].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO3_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO4].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO4_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO5].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO5_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO6].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO6_IRQ));
	sysbus_create_simple("virtio-mmio",
		naruto_soc_memmap[NARUTO_SOC_VIRTIO7].base,
		qdev_get_gpio_in(DEVICE(s->plic), NARUTO_VIRTIO7_IRQ));
}

/**
 * @brief Naruto Pi fw_cfg realize.
 * 
 * @param dev 
 */
static void naruto_fw_cfg_realize(DeviceState *dev)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);
	MachineState *ms = MACHINE(qdev_get_machine());

	s->fw_cfg = fw_cfg_init_mem_wide(
				naruto_soc_memmap[NARUTO_SOC_FW_CFG].base + 8,
				naruto_soc_memmap[NARUTO_SOC_FW_CFG].base, 8,
				naruto_soc_memmap[NARUTO_SOC_FW_CFG].base + 16,
				&address_space_memory);
	fw_cfg_add_i16(s->fw_cfg,
				FW_CFG_NB_CPUS,
				(uint16_t)ms->smp.cpus);

	rom_set_fw(s->fw_cfg);
}

/**
 * @brief Naruto Pi RTC realize.
 * 
 * @param dev 
 */
static void naruto_rtc_realize(DeviceState *dev)
{
	NarutoSoCState *s = RISCV_NARUTO_SOC(dev);

	sysbus_create_simple("goldfish_rtc",
				naruto_soc_memmap[NARUTO_SOC_RTC].base,
				qdev_get_gpio_in(DEVICE(s->plic), NARUTO_RTC_IRQ));
}

/**
 * @brief Naruto Pi System configure realize.
 * 
 * @param dev 
 */
static void naruto_syscon_realize(DeviceState *dev)
{
	naruto_syscon_create(naruto_soc_memmap[NARUTO_SOC_SYSCON].base);
}

/**
 * @brief Create NARUTO_SOC_Device.
 * 
 * @param obj 
 */
static void naruto_soc_instance_init(Object *obj)
{
	naruto_cpu_init(obj);
}

/**
 * @brief Initialize Naruto device bus. 
 * 
 * @param dev 
 * @param err 
 */
static void naruto_soc_realize(DeviceState *dev, Error **err)
{
	naruto_cpu_realize(dev);
	naruto_plic_realize(dev);
	naruto_pflash_realize(dev);
	naruto_uart_realize(dev);
	naruto_virtio_realize(dev);
	naruto_fw_cfg_realize(dev);
	naruto_rtc_realize(dev);
	naruto_syscon_realize(dev);
}

static void naruto_soc_class_init(ObjectClass *klass, void *data)
{
	DeviceClass *dc = DEVICE_CLASS(klass);
	dc->realize = naruto_soc_realize;
	dc->user_creatable = false;
}

static const TypeInfo naruto_soc_type_info = {
	.name = TYPE_NARUTO_SOC,
	.parent = TYPE_DEVICE,
	.instance_size = sizeof(NarutoSoCState),
	.instance_init = naruto_soc_instance_init,
	.class_init = naruto_soc_class_init,
};

static void naruto_soc_register_types(void)
{
	type_register_static(&naruto_soc_type_info);
}

type_init(naruto_soc_register_types)

/* Exit create naruto SOC device. */

/* Enter create naruto machine. */
static void naruto_board_init(MachineState *machine)
{
	NarutoMachineState *s = NARUTO_MACHINE(machine);

	/* Initialize DRAM. */
	MemoryRegion *system_memory = get_system_memory();
	MemoryRegion *dram_mem = g_new(MemoryRegion, 1);
	MemoryRegion *sram_mem = g_new(MemoryRegion, 1);
	MemoryRegion *mask_rom = g_new(MemoryRegion, 1);

	/* Initialize SoC. */
	object_initialize_child(OBJECT(machine), "soc", &s->soc,
							TYPE_NARUTO_SOC);
	qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
	/* Initialize DDR. */
	memory_region_init_ram(dram_mem, NULL, "naruto.pi.dram",
						machine->ram_size, &error_fatal);

	memory_region_add_subregion(system_memory,
			naruto_soc_memmap[NARUTO_SOC_DRAM].base, dram_mem);
	/* Initialize SRAM. */
	memory_region_init_ram(sram_mem, NULL, "naruto.pi.sram",
			naruto_soc_memmap[NARUTO_SOC_SRAM].size, &error_fatal);
	memory_region_add_subregion(system_memory,
			naruto_soc_memmap[NARUTO_SOC_SRAM].base, sram_mem);
	/* Initialize ROM. */
	memory_region_init_ram(mask_rom, NULL, "naruto.pi.rom",
			naruto_soc_memmap[NARUTO_SOC_ROM].size, &error_fatal);
	memory_region_add_subregion(system_memory,
			naruto_soc_memmap[NARUTO_SOC_ROM].base, mask_rom);

	/* Load the reset vector */
	riscv_setup_rom_reset_vec(machine, &s->soc.m_cpus,
			naruto_soc_memmap[NARUTO_SOC_PFLASH].base,
			naruto_soc_memmap[NARUTO_SOC_ROM].base,
			naruto_soc_memmap[NARUTO_SOC_ROM].size,
			0x0, 0x0);
}

static void naruto_machine_class_init(ObjectClass *klass, void *data)
{
	MachineClass *mc = MACHINE_CLASS(klass);

	mc->desc = NARUTO_PI_DESC;
	mc->init = naruto_board_init;
	mc->max_cpus = NARUTO_PI_MANAGEMENT_CPU_COUNT +
				NARUTO_PI_COMPUTE_CPU_COUNT;
	mc->min_cpus = NARUTO_PI_MANAGEMENT_CPU_COUNT + 1;
	mc->default_cpus = mc->min_cpus;
	mc->default_ram_id = "naruto.pi.sram.default";
	mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
}

static const TypeInfo naruto_machine_typeinfo = {
	.name			= TYPE_NARUTO_MACHINE,
	.parent			= TYPE_MACHINE,
	.instance_size	= sizeof(NarutoMachineState),
	.class_init		= naruto_machine_class_init,
};

static void naruto_machine_init_register_types(void)
{
	type_register_static(&naruto_machine_typeinfo);
}

type_init(naruto_machine_init_register_types)
