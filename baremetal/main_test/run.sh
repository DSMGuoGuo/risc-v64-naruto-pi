PROJECT_DIR=/home/jihongz/workspace/05_JHPI/risc-v64-naruto-pi
QEMU_PATH=/home/jihongz/workspace/02_qemu/output/bin
OUTPUT_IMG_PATH=$PROJECT_DIR/output

export PATH=$PATH:$QEMU_PATH

qemu-system-riscv64 \
-M naruto \
-m 2048 \
-smp 8 \
-nographic \
--parallel none \
-drive if=pflash,bus=0,unit=0,format=raw,file=$OUTPUT_IMG_PATH/fw.bin