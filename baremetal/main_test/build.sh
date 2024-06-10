# CROSS_PREFIX=/home/jihongz/workspace/03_toolchain/output/bin/riscv64-unknown-linux-gnu
CROSS_PREFIX=/home/jihongz/workspace/03_toolchain/output/gcc-riscv64-unknown-elf/bin/riscv64-unknown-elf
ROOT_DIR=/home/jihongz/workspace/05_JHPI/risc-v64-naruto-pi
PROCESSORS=8
OBJ_DIR=/home/jihongz/workspace/05_JHPI/risc-v64-naruto-pi/baremetal/03_main_test
TARGET=main

cd OBJ_DIR
make CROSS_COMPILE=$CROSS_PREFIX- clean
make CROSS_COMPILE=$CROSS_PREFIX- -j$PROCESSORS

if [ -e "$OBJ_DIR/build/$TARGET.bin" ]; then
    pwd
else
    echo "error : build failed.";
    exit;
fi

if [ -d "$ROOT_DIR/output" ]; then
    pwd
else
    mkdir $ROOT_DIR/output
fi

if [ -e "$ROOT_DIR/output/lowlevelinit.bin" ]; then
    cd $ROOT_DIR/output
    cp $OBJ_DIR/build/$TARGET.bin $ROOT_DIR/output
    dd of=fw.bin bs=1k count=32k if=/dev/zero
    dd of=fw.bin bs=1k conv=notrunc seek=0 if=lowlevelinit.bin
    dd of=fw.bin bs=1k conv=notrunc seek=2K if=main.bin
else
    echo "error : BL1 bootload does not exist.";
    exit;
fi