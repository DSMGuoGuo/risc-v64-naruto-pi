cmd_libbb/perror_nomsg.o := /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/bin/riscv64-unknown-linux-gnu-gcc -Wp,-MD,libbb/.perror_nomsg.o.d  -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DBB_VER='"1.36.1"' -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -finline-limit=0 -fno-builtin-strlen -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Oz    -DKBUILD_BASENAME='"perror_nomsg"'  -DKBUILD_MODNAME='"perror_nomsg"' -c -o libbb/perror_nomsg.o libbb/perror_nomsg.c

deps_libbb/perror_nomsg.o := \
  libbb/perror_nomsg.c \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/stdc-predef.h \
  include/platform.h \
    $(wildcard include/config/werror.h) \
    $(wildcard include/config/big/endian.h) \
    $(wildcard include/config/little/endian.h) \
    $(wildcard include/config/nommu.h) \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/limits.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/syslimits.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/limits.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/libc-header-start.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/features.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/features-time64.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/wordsize.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/timesize.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/cdefs.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/long-double.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/gnu/stubs.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/gnu/stubs-lp64d.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/posix1_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/local_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/limits.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/pthread_stack_min-dynamic.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/posix2_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/xopen_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/uio_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/byteswap.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/byteswap.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/typesizes.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/time64.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/endian.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/endian.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/endianness.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/uintn-identity.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/stdint.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/stdint.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/wchar.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stdint-intn.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stdint-uintn.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stdint-least.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/stdbool.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/unistd.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/posix_opt.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/environments.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/stddef.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/confname.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/getopt_posix.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/getopt_core.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/unistd_ext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/close_range.h \

libbb/perror_nomsg.o: $(deps_libbb/perror_nomsg.o)

$(deps_libbb/perror_nomsg.o):
