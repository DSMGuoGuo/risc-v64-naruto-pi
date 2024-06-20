/**
 * @file naruto-misc.h
 * @author JihongZhang (1042476967@qq.com)
 * @brief Naruto Pi QEMU
 * @version 0.1
 * @date 2024-06-18
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#ifndef __NARUTO_MISC_H__
#define __NARUTO_MISC_H__

#include "hw/sysbus.h"
#include "qom/object.h"

#define TYPE_NARUTO_SYSCON "riscv.naruto.syscon"

#define NARUTO_SYSCON_SIZE	0x1000U

typedef struct NarutoSysconState NarutoSysconState;
DECLARE_INSTANCE_CHECKER(NarutoSysconState, NARUTO_SYSCON,
						TYPE_NARUTO_SYSCON)

struct NarutoSysconState {
	/*< private >*/
	SysBusDevice parent_obj;

	/*< public >*/
	MemoryRegion mmio;
};

enum {
	FINISHER_FAIL = 0x3333,
	FINISHER_PASS = 0x5555,
	FINISHER_RESET = 0x7777
};

DeviceState *naruto_syscon_create(hwaddr addr);

#endif
