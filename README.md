# <span style="color:#e60000;"><span style="font-size:20px;">**1 描述Naruto Pi**</span></span>

`Naruto Pi`是基于`QEMU`构建的`RISC-V64 SOC`，支持`Linux`，`baremetal`, `RTOS`等，适合用来学习`Linux`，后续还会添加大量的`controller`，实现无需实体开发板，就学习`Linux`和`RISC-V`架构。

 # 登录用户名和密码：
- Ubuntu：

	username：jihongz
    
    password：1
 - busybox（root）：
 
 	username：root
    
    password：root
    
 - busybox（naruto）：
 
 	username：naruto
    
    password：naruto
    
   
 # 环境部署(基于Ubuntu20.04)
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
#ssh服务，需要的再装
sudo apt install openssh-server
#缺啥安装啥
sudo apt-get install flex
sudo apt-get install bison
```


# <span style="color:#e60000;"><span style="font-size:20px;">**2 编译Naruto Pi**</span></span>

- 编译之前需要注意更改脚本GCC编译器地址
- 文件路径：`build.sh`,将如下路径改成自己的编译器路径
```sh
COMPILE_PATH=/home/jihongz/workspace/03_toolchain/output
```
- 编译器需要`RISCV64`的编译器，需要支持`Linux`.

- 获取交叉编译工具链源码
- 方法一： 官方`git`仓库，此方法比较慢，开了梯子也没用，用了公网`IP`也没用，建议用方法二

```bash
git clone https://github.com/riscv/riscv-gnu-toolchain --recursive
```
- 方法二：`Gitee`下载`main`仓库

```bash
git clone  https://gitee.com/mirrors/riscv-gnu-toolchain
```
- branch 分支，全拉下来

```bash
cd riscv-gnu-toolchain
```

```bash
git clone https://gitee.com/mirrors/riscv-newlib
git clone https://gitee.com/mirrors/riscv-binutils-gdb
git clone https://gitee.com/mirrors/riscv-dejagnu
git clone https://gitee.com/mirrors/riscv-glibc
git clone https://gitee.com/mirrors/riscv-gcc
```
- 编译交叉编译工具链源码
- 设置输出路径,这个输出路径就是我们上面要改的脚本的那个路径，记得一定要相同
```bash
./configure --prefix=/home/jihongz/workspace/03_toolchain/output
```
- 编译（如果出现权限问题加`sudo`即可）

```bash
make linux
```

## <span style="color:#9933ff;"> 2.1 整体编译（busybox 文件系统）</span>
`./build.sh all busybox`
## <span style="color:#9933ff;"> 2.2 整体编译（ubuntu 文件系统）</span>
`./build.sh all ubuntu`

![image.png](https://raw.gitcode.com/DSMGUOGUO/risc-v64-naruto-pi/attachment/uploads/a2d70498-994a-4ccf-b9af-cbc6cc07c1ed/image.png 'image.png')

- 如果只是编译部分，则可以使用下列命令去编译对应的`Image`.
## <span style="color:#9933ff;"> 2.3 编译qemu</span>
`./build.sh qemu_defconfig`

`./build.sh qemu`
## <span style="color:#9933ff;"> 2.4 编译lowinit</span>
`lowinit` 是`bootrom`跳转出来的第一个程序，主要负责把`BL1~BL3`的程序从模拟的`pFLASH`中拷贝到`DDR`中。

`./build.sh lowinit`

## <span style="color:#9933ff;"> 2.5 编译lowinit</span>
`./build.sh lowinit`

## <span style="color:#9933ff;"> 2.6 编译oensbi 设备树</span>
`./build.sh sbi_dtb`

## <span style="color:#9933ff;"> 2.7 编译oensbi</span>
`./build.sh sbi`
## <span style="color:#9933ff;"> 2.8 编译uboot 和kernel 设备树</span>
- `Naruto Pi`的`Kernel`和`U-boot`使用的是同一个设备树，统一管理。

`./build.sh sbi`

## <span style="color:#9933ff;"> 2.9 编译uboot</span>
`./build.sh uboot_defconfig`

`./build.sh uboot`

## <span style="color:#9933ff;"> 2.10 编译kernel</span>
`./build.sh kernel_defconfig`

`./build.sh kernel`

## <span style="color:#9933ff;"> 2.11 编译ubuntu</span>
`./build.sh ubuntu`

## <span style="color:#9933ff;"> 2.12 压缩ubuntu</span>
- 如果改过Ubuntu文件系统，想再次打包可以直接调用脚本：

`./build.sh tar_ubuntu`

## <span style="color:#9933ff;"> 2.13 编译busybox</span>
`./build.sh busybox`

## <span style="color:#9933ff;"> 2.14 编译bare-metal</span>
`./build.sh barematel`
## <span style="color:#9933ff;"> 2.15 打包所有Image</span>
`./build.sh image`

## <span style="color:#9933ff;"> 2.16 运行</span>
`./run.sh`

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
- 目前已经集成的`设备`及其`基地址`如下（`不断更新`）：

```c
static const MemMapEntry naruto_soc_memmap[] = {
	[NARUTO_SOC_ROM]			= {0x00000000,	0x8000},
	[NARUTO_SOC_SRAM]			= {0x00008000,	0x8000},
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