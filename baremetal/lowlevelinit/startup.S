	.macro loop,cunt		/* 定义一个简单loop宏cunt是loop参数 */
	li		t1,	0xffff		/* 加载立即数到t1 */
	li		t2,	\cunt		/* 加载立即数到t2 */
1:
	nop						/* 空指令nop */
	addi	t1, t1, -1		/* t1-- */
	bne		t1, x0, 1b		/* 判断t1是否等于0，不是就跳转前以符号1处
							（b是向前的意思） */
	li		t1,	0xffff		/* 加载立即数到t1 */
	addi	t2, t2, -1		/* t2-- */
	bne		t2, x0, 1b		/* 判断t2是否等于0，不是就跳转前一个符号1处
							（b是向前的意思） */
	.endm					/* 宏结束 */

	.macro load_data,_src_start,_dst_start,_dst_end
	/* 定义一个简单load_data宏（这里我们按word拷贝数据，
	实际上64位可以按double word来拷贝，效率更高）
	_src_start为源地址，_dst_start为目标地址，_dst_end为目标结束地址 */
	bgeu	\_dst_start, \_dst_end, 2f	/* 判断目标结束地址大于起始地址，
										即是否合法 */
1:
	lw		t0, (\_src_start)			/* 加载源地址内数据到t0 */
	sw		t0, (\_dst_start)			/* 写入t0到目标地址内 */
	addi	\_src_start, \_src_start, 4	/* 源地址+4 */
	addi	\_dst_start, \_dst_start, 4	/* 目标地址+4 */
	bltu	\_dst_start, \_dst_end, 1b	/* 判断是否已到达结束地址，
										未到达则循环到上前一个符号1 */
2:
	.endm

	.section .text
	.globl _start
	.type _start,@function

_start:
	/* load opensbi.dtb */
	/* [0x2008_0000:0x2010_0000] --> [0xBFF0_0000:0x8FF8_0000] */
	li		a0,	0x2008
	slli	a0,	a0, 16
	li		a1,	0xbff
	slli	a1,	a1, 20
	li		a2,	0x800
	slli	a2,	a2, 4
	add 	a2,	a1, a2
	load_data a0,a1,a2

	/* load uboot.dtb */
	/* [0x2010_0000:0x2018_0000] --> [0xB000_0000:0xB008_0000] */
	li		a0,	0x201
	slli	a0,	a0, 20
	li		a1,	0xb00
	slli	a1,	a1, 20
	li		a2,	0x800
	slli	a2,	a2, 8
	add 	a2,	a1, a2
	load_data a0, a1, a2

	/* load opensbi_fw.bin */
	/* [0x2020_0000:0x2040_0000] --> [0xBFF8_0000:0xC000_0000] */
	li		a0,	0x202
	slli	a0,	a0, 20
	li		a1,	0xbff
	slli	a1,	a1, 20
	li		a2,	0x800
	slli	a2,	a2, 8
	add 	a1,	a1, a2
	add 	a2,	a1, a2
	load_data a0,a1,a2

	/* load trusted_fw.bin */
	/* [0x2040_0000:0x2080_0000] --> [0xBF80_0000:0xBFC0_0000] */
	li		a0,	0x204
	slli	a0,	a0, 20
	li		a1,	0xbf8
	slli	a1,	a1, 20
	li		a2,	0xbfc
	slli	a2,	a2, 20
	load_data a0,a1,a2

	/* load u-boot.bin */
	/* [0x2080_0000:0x20C0_0000] --> [0xB020_0000:0xB060_0000] */
	li		a0,	0x208
	slli	a0,	a0, 20
	li		a1,	0xb02
	slli	a1,	a1, 20
	li		a2,	0xb06
	slli	a2,	a2, 20
	load_data a0,a1,a2

	csrr	a0, mhartid
	li		t0, 0x0
	/* 非core0 就loop 1000后再启动，让core0作为opensbi的冷启动引导核心*/
	beq		a0, t0, _no_wait
	loop	0x1000
_no_wait:
	/* a1 寄存器存放Opensbi dtb起始地址 */
	/* t0 寄存器存放Opensbi 起始地址 */
	li		a1, 0xBFF0
	slli	a1, a1, 16
	li		t0, 0xBFF8
	slli	t0, t0, 16
	jr		t0
	/* 此时a0中为core的hart id，
	a1中设备树dtb的所在的起始地址，
	t0为opensbi程序所
	在的ddr地址，jr跳转进入opensbi程序 */

	.end
