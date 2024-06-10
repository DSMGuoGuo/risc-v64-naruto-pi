/**
 * @file qemu-naruto-pi.c
 * @author Jihong Zhang <1042476967@qq.com>
 * @brief Naruto Pi initialize.
 * @version 0.1
 * @date 2024-05-25
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#include <dm.h>
#include <env.h>
#include <fdtdec.h>
#include <image.h>
#include <log.h>
#include <init.h>
#include <virtio_types.h>
#include <virtio.h>
#include <version.h>

/**
 * @brief The function is typically used to obtain
 * the available physical memory size on the system. Here
 * Physi_size_t is a type definition used to represent
 * the size of physical memory, Usually an unsigned
 * integer type, such as uint64_t or other appropriate type
 * 
 * @return phys_size_t Return U-boot system memmory size.
 */
phys_size_t get_effective_memsize(void)
{
	return 64*1024*1024;
}

int board_init(void)
{

	return 0;
}

int board_late_init(void)
{

	return 0;
}
