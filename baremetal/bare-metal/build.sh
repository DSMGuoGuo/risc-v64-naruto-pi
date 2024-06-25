ROOT_DIR=$1
CROSS_PREFIX=$2
OBJ_DIR=$3
NUMBER_OF_CPU= -j4
PROJECT_OUT_PATH=$ROOT_DIR/output/bare-metal
TARGET=main

cd OBJ_DIR
make CROSS_COMPILE=$CROSS_PREFIX- clean
make CROSS_COMPILE=$CROSS_PREFIX- $NUMBER_OF_CPU

if [ -e "$OBJ_DIR/build/$TARGET.bin" ]; then
	pwd
else
	echo "error : build failed.";
	exit;
fi

if [ -d "$PROJECT_OUT_PATH" ]; then
	pwd
else
	mkdir $PROJECT_OUT_PATH
fi
rm -rf $PROJECT_OUT_PATH/*
cp -ra $OBJ_DIR/build/*.bin $PROJECT_OUT_PATH/
cp -ra $OBJ_DIR/build/*.elf $PROJECT_OUT_PATH/
cp -ra $OBJ_DIR/build/*.hex $PROJECT_OUT_PATH/
cp -ra $OBJ_DIR/build/*.map $PROJECT_OUT_PATH/
cp -ra $OBJ_DIR/build/*.lst $PROJECT_OUT_PATH/

make CROSS_COMPILE=$CROSS_PREFIX- clean