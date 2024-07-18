## <font  size=5 color=##00BFFF> 1. 概述</font>

`Naruto Pi`是基于`QEMU`构建的`RISC-V64 SOC`，支持`Linux`，`baremetal`, `RTOS`等，适合用来学习`Linux`，后续还会添加大量的`controller`，实现无需实体开发板即可学习`Linux`和`RISC-V`架构，是用来探索嵌入式的奥秘的绝佳之选，本项目长期更新，后续会支持`SPI`，`I2C`，`USB`，`Ethernet`，`Boot Flow`，`I2S`，`ADC`，`RTC`，`Power`等经典常用`IP`和`Driver`，同时也设有文档手把手跟学，非常适合想从零了解`CPU`实现和`bringup`的小伙伴。

 # 登录用户名和密码：
- `Ubuntu`：

	username：jihongz
    
    password：1
 - `busybox`（root）：
 
 	username：root
    
    password：root
    
 - `busybox`（naruto）：
 
 	username：naruto
    
    password：naruto
    
   
 ## <font  size=5 color=##00BFFF> 2. 环境部署基于`Ubuntu20.04`</font>
在开始编译之前需要部署一下依赖，安装以下依赖
```
sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build
# 建议安装的额外的包, qemu: 为了额外的功能
sudo apt-get install git-email
sudo apt-get install libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev
sudo apt-get install libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev
sudo apt-get install libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev
sudo apt-get install librbd-dev librdmacm-dev
sudo apt-get install libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev
sudo apt-get install libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev
sudo apt-get install valgrind xfslibs-dev
sudo apt-get install python3.8-venv
sudo apt-get install texinfo
sudo apt-get install gawk
sudo apt-get install device-tree-compiler
sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev

#ssh服务，需要的再装
sudo apt install openssh-server
#缺啥安装啥
sudo apt-get install flex
sudo apt-get install bison
```

 ## <font  size=5 color=##00BFFF> 3. 整体编译Naruto Pi</font>
 
在开始编译之前需要部署一下依赖，安装以下依赖


- 编译器需要`RISCV64`的编译器，需要支持`Linux`，如果需要跑`bare-metal`则还需要`newlib-c`

- 编译交叉编译工具链，这一步会很慢，我估计普通电脑需要三个小时，所以可以先去玩一会再回来

```bash
./build.sh compile
```
 ## <font  size=4 color=##00BFFF> 3.1 整体编译（如果使用ubuntu 文件系统）</font>
- 如果使用FreeRTOS作为trusted domain 就加freertos，如果用baremetal则加baremetal

```bash
./build.sh all busybox freertos
```

```bash
./build.sh all busybox baremetal
```

 ## <font  size=4 color=##00BFFF> 3.1 整体编译（如果使用busybox 文件系统）</font>

```bash
./build.sh all ubuntu freertos
```

```bash
./build.sh all ubuntu baremetal
```
 ## <font  size=5 color=##00BFFF> 4. 模块化编译Naruto Pi</font>
 
- 如果后期开发只是更改部分部分内容，则可以使用下列命令去编译对应的代码即可，这样速度比较快.

 ## <font  size=4 color=##00BFFF> 4.1 编译qemu</font>
 `QEMU`是虚拟机软件，将`RISCV`指令集翻译成`x86`指令集运行的环境。
```bash
./build.sh qemu_defconfig
```

```bash
./build.sh qemu
```

 ## <font  size=4 color=##00BFFF> 4.2 编译lowinit</font>
`lowinit` 是`bootrom`跳转出来的第一个程序，主要负责把`BL1~BL3`的程序从模拟的`pFLASH`中拷贝到`DDR`中。

```bash
./build.sh lowinit
```
 ## <font  size=4 color=##00BFFF> 4.3 编译opensbi 设备树</font>

```bash
./build.sh sbi_dtb
```
 ## <font  size=4 color=##00BFFF> 4.4 编译Opensbi</font>

```bash
./build.sh sbi
```

 ## <font  size=4 color=##00BFFF> 4.5 编译uboot 和kernel 设备树</font>
 
- `Naruto Pi`的`Kernel`和`U-boot`使用的是同一个设备树，统一管理。

```bash
./build.sh uboot_dtb
```
 ## <font  size=4 color=##00BFFF> 4.6 编译uboot</font>

```bash
./build.sh uboot_defconfig
```

```bash
./build.sh uboot
```
 ## <font  size=4 color=##00BFFF> 4.7 编译kernel</font>

```bash
./build.sh kernel_defconfig
```

```bash
./build.sh kernel
```
 ## <font  size=4 color=##00BFFF> 4.8 编译ubuntu文件系统（如使用busybox可以不编译）</font>

```bash
./build.sh ubuntu
```
 ## <font  size=4 color=##00BFFF> 4.9 压缩ubuntu</font>

- 如果改过`Ubuntu`文件系统，想再次打包可以直接调用脚本，这个主要是我用来把`Ubuntu`的文件系统拆分，这样才能使每个文件小于`10Mb`上传于`GIT`

```bash
./build.sh tar_ubuntu
```
 ## <font  size=4 color=##00BFFF> 4.10 编译Busybox(同样和Ubuntu二选一即可)</font>

```bash
./build.sh busybox
```
 ## <font  size=4 color=##00BFFF> 4.11 编译bare-metal</font>
- 我想讲解一些裸机的驱动，所以我想弄个裸机的目录，你们也可以用来跑裸机，裸机是`core 7`在运行。
```bash
./build.sh barematel
```
 ## <font  size=4 color=##00BFFF> 4.12 编译FreeRTOS</font>
 - 用于运行`FreeRTOS`，同样是跑在`core 7`上，所以和`bare-metal` 二选一

```bash
./build.sh freertos
```
 ## <font  size=5 color=##00BFFF>  打包所以Image 并运行Naruto Pi</font>
- 打包

```bash
./build.sh image
```

- 运行

```bash
./run.sh
```

# <span style="color:#e60000;"><span style="font-size:20px;">**3 内存分布**</span></span>
- 目前已经集成的`Memory`及其`基地址`如下（`不断更新`）：

| 地址 | 大小 |内存区域描述 |
|--|--|--|
| 0x0000_0000 | 2Kb| ROM |
| 0x0000_8000 | 2Kb| SRAM |
| 0x2000_0000 | 32Mb| PFLASH |
| 0x8000_0000 | 1Gb| DDR |

# <span style="color:#e60000;"><span style="font-size:20px;">**4 程序分区**</span></span>
| 地址 | 大小 |内存区域描述 |
|--|--|--|
| 0x0000_0000 | 2Kb| ROM 启动程序|
| 0x2000_0000 | 512Kb| lowinit |
| 0x2008_0000 | 512Kb| opensbi_dtb |
| 0x2010_0000 | 512Kb| uboot_dtb|
| 0x2018_0000 | 512Kb| `reserved`|
| 0x2020_0000 | 512Kb| opensbi |
| 0x2028_0000 | 1.5Mb| `reserved` |
| 0x2040_0000 | 4Mb| trusted domain|
| 0x2080_0000 | 4Mb| uboot|
| 0x20C0_0000 | 20Mb| `reserved`|

# <span style="color:#e60000;"><span style="font-size:20px;">**5 设备地址映射**</span></span>
- 目前已经集成的`设备名称`，`基地址`和`寄存器总大小`如下（`不断更新`）：

```c
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
```
