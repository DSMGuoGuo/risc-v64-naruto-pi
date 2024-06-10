CROSS_PREFIX=/home/jihongz/workspace/03_toolchain/output/bin/riscv64-unknown-linux-gnu
APP_NAME=uart2

rm -rf $APP_NAME* startup.o
# 编译汇编文件startup.S到obj文件  
$CROSS_PREFIX-gcc -x assembler-with-cpp -c startup.S -o ./startup.o

# 使用链接脚本链接obj文件生成elf可执行文件  
$CROSS_PREFIX-gcc -nostartfiles -T./boot.lds -Wl,-Map=./$APP_NAME.map -Wl,--gc-sections ./startup.o -o ./$APP_NAME.elf  

# 使用gnu工具生成原始的程序bin文件  
$CROSS_PREFIX-objcopy -O binary -S ./$APP_NAME.elf ./$APP_NAME.bin  

# 使用gnu工具生成反汇编文件，方便调试分析（当然我们这个代码太简单，不是很需要）  
$CROSS_PREFIX-objdump --source --demangle --disassemble --reloc --wide ./$APP_NAME.elf > ./$APP_NAME.lst