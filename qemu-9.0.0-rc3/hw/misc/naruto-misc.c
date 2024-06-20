/**
 * @file naruto-misc.c
 * @author JihongZhang (1042476967@qq.com)
 * @brief Naruto Pi QEMU
 * @version 0.1
 * @date 2024-06-18
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#include "qemu/osdep.h"
#include "hw/sysbus.h"
#include "qapi/error.h"
#include "qemu/log.h"
#include "qemu/module.h"
#include "sysemu/runstate.h"
#include "hw/misc/naruto-misc.h"
#include "sysemu/sysemu.h"

static uint64_t naruto_syscon_read(void *opaque, hwaddr addr, unsigned int size)
{
	return 0;
}

static void naruto_syscon_write(void *opaque, hwaddr addr,
		uint64_t val64, unsigned int size)
{
	if (addr == 0) {
		int status = val64 & 0xffff;
		int code = (val64 >> 16) & 0xffff;
		switch (status) {
			case FINISHER_FAIL:
				qemu_system_shutdown_request_with_code(
				SHUTDOWN_CAUSE_GUEST_PANIC, code);
				return;
			case FINISHER_PASS:
				qemu_system_shutdown_request_with_code(
				SHUTDOWN_CAUSE_GUEST_SHUTDOWN, code);
				return;
			case FINISHER_RESET:
				qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
				return;
			default:
				break;
		}
	}

	qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
				__func__, (int)addr, val64);
}

static const MemoryRegionOps naruto_syscon_ops = {
	.read = naruto_syscon_read,
	.write = naruto_syscon_write,
	.endianness = DEVICE_NATIVE_ENDIAN,
	.valid = {
		.min_access_size = 2,
		.max_access_size = 4
	}
};

static void naruto_syscon_init(Object *obj)
{
	NarutoSysconState *s = NARUTO_SYSCON(obj);

	memory_region_init_io(&s->mmio, obj, &naruto_syscon_ops, s,
						TYPE_NARUTO_SYSCON, NARUTO_SYSCON_SIZE);
	sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
}

static const TypeInfo naruto_syscon_info = {
	.name			= TYPE_NARUTO_SYSCON,
	.parent			= TYPE_SYS_BUS_DEVICE,
	.instance_size	= sizeof(NarutoSysconState),
	.instance_init	= naruto_syscon_init,
};

static void naruto_syscon_register_types(void)
{
	type_register_static(&naruto_syscon_info);
}

type_init(naruto_syscon_register_types)


/*
 * Create naruto system configure device.
 */
DeviceState *naruto_syscon_create(hwaddr addr)
{
	DeviceState *dev = qdev_new(TYPE_NARUTO_SYSCON);
	sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
	sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
	return dev;
}
