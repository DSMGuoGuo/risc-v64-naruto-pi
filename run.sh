#!/bin/bash

PROJECT_DIR=/home/jihongz/workspace/05_JHPI/risc-v64-naruto-pi
QEMU_PATH=/home/jihongz/workspace/02_qemu/output/bin
OUTPUT_IMG_PATH=$PROJECT_DIR/output
export PATH=$PATH:$QEMU_PATH

DEFAULT_VC="1280x720"

qemu-system-riscv64 \
-M naruto \
-m 1024 \
-smp 8 \
-drive if=pflash,bus=0,unit=0,format=raw,file=$OUTPUT_IMG_PATH/fw.bin \
-drive file=$OUTPUT_IMG_PATH/rootfs/rootfs.img,format=raw,id=hd0 \
-global virtio-mmio.force-legacy=false \
-device virtio-blk-device,drive=hd0 \
-device virtio-gpu-device,id=video0,xres=1280,yres=720 \
-fw_cfg name="opt/qemu_cmdline",string="qemu_vc="$DEFAULT_V"" \
--serial vc:$DEFAULT_VC --serial vc:$DEFAULT_VC --serial vc:$DEFAULT_VC --monitor vc:$DEFAULT_VC \
--parallel none

# -nographic
