#include "riscv_encoding.h"
#define BOOT_HART 7

	.section .init
	.globl _start
	.type _start,@function
_start:
	.cfi_startproc
	.cfi_undefined ra
.option push
.option norelax
	la  gp, __global_pointer$
.option pop

	# csrc CSR_SSTATUS, SSTATUS_SIE
	/* Continue primary hart */

	csrw sie, 0
	csrw sip, 0
#ifdef __riscv_flen
	/* set to init FPU */
	li t0, (0x1 << 13)
	csrs sstatus, t0
#endif
	li t0, SSTATUS_SUM // SUM in sstatus
	csrs sstatus, t0

	/* Primary hart */
	la sp, _sp
	csrw sscratch, sp

	/* Clear bss section */
	la a0, __bss_start
	la a1, __bss_end
	bgeu a0, a1, 2f
1:
	STOR zero, (a0)
	addi a0, a0, REGSIZE
	bltu a0, a1, 1b
2:
	li a0, 0
	li a1, 0
	li a2, 0
	jal main
1:
	wfi
	j 1b

	.cfi_endproc