cmd_coreutils/od.o := /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/bin/riscv64-unknown-linux-gnu-gcc -Wp,-MD,coreutils/.od.o.d  -std=gnu99 -Iinclude -Ilibbb  -include include/autoconf.h -D_GNU_SOURCE -DNDEBUG -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DBB_VER='"1.36.1"' -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused -Wunused-parameter -Wunused-function -Wunused-value -Wmissing-prototypes -Wmissing-declarations -Wno-format-security -Wdeclaration-after-statement -Wold-style-definition -finline-limit=0 -fno-builtin-strlen -fomit-frame-pointer -ffunction-sections -fdata-sections -fno-guess-branch-probability -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1 -falign-labels=1 -falign-loops=1 -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-builtin-printf -Oz    -DKBUILD_BASENAME='"od"'  -DKBUILD_MODNAME='"od"' -c -o coreutils/od.o coreutils/od.c

deps_coreutils/od.o := \
  coreutils/od.c \
    $(wildcard include/config/od.h) \
    $(wildcard include/config/desktop.h) \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/stdc-predef.h \
  include/libbb.h \
    $(wildcard include/config/feature/shadowpasswds.h) \
    $(wildcard include/config/use/bb/shadow.h) \
    $(wildcard include/config/selinux.h) \
    $(wildcard include/config/feature/utmp.h) \
    $(wildcard include/config/locale/support.h) \
    $(wildcard include/config/use/bb/pwd/grp.h) \
    $(wildcard include/config/lfs.h) \
    $(wildcard include/config/feature/buffers/go/on/stack.h) \
    $(wildcard include/config/feature/buffers/go/in/bss.h) \
    $(wildcard include/config/extra/cflags.h) \
    $(wildcard include/config/variable/arch/pagesize.h) \
    $(wildcard include/config/feature/verbose.h) \
    $(wildcard include/config/feature/etc/services.h) \
    $(wildcard include/config/feature/ipv6.h) \
    $(wildcard include/config/feature/seamless/xz.h) \
    $(wildcard include/config/feature/seamless/lzma.h) \
    $(wildcard include/config/feature/seamless/bz2.h) \
    $(wildcard include/config/feature/seamless/gz.h) \
    $(wildcard include/config/feature/seamless/z.h) \
    $(wildcard include/config/float/duration.h) \
    $(wildcard include/config/feature/check/names.h) \
    $(wildcard include/config/feature/prefer/applets.h) \
    $(wildcard include/config/long/opts.h) \
    $(wildcard include/config/feature/pidfile.h) \
    $(wildcard include/config/feature/syslog.h) \
    $(wildcard include/config/feature/syslog/info.h) \
    $(wildcard include/config/warn/simple/msg.h) \
    $(wildcard include/config/feature/individual.h) \
    $(wildcard include/config/shell/ash.h) \
    $(wildcard include/config/shell/hush.h) \
    $(wildcard include/config/echo.h) \
    $(wildcard include/config/sleep.h) \
    $(wildcard include/config/printf.h) \
    $(wildcard include/config/test.h) \
    $(wildcard include/config/test1.h) \
    $(wildcard include/config/test2.h) \
    $(wildcard include/config/kill.h) \
    $(wildcard include/config/killall.h) \
    $(wildcard include/config/killall5.h) \
    $(wildcard include/config/chown.h) \
    $(wildcard include/config/ls.h) \
    $(wildcard include/config/xxx.h) \
    $(wildcard include/config/route.h) \
    $(wildcard include/config/feature/hwib.h) \
    $(wildcard include/config/feature/crond/d.h) \
    $(wildcard include/config/feature/setpriv/capabilities.h) \
    $(wildcard include/config/run/init.h) \
    $(wildcard include/config/feature/securetty.h) \
    $(wildcard include/config/pam.h) \
    $(wildcard include/config/use/bb/crypt.h) \
    $(wildcard include/config/feature/adduser/to/group.h) \
    $(wildcard include/config/feature/del/user/from/group.h) \
    $(wildcard include/config/ioctl/hex2str/error.h) \
    $(wildcard include/config/feature/editing.h) \
    $(wildcard include/config/feature/editing/history.h) \
    $(wildcard include/config/feature/tab/completion.h) \
    $(wildcard include/config/feature/username/completion.h) \
    $(wildcard include/config/feature/editing/fancy/prompt.h) \
    $(wildcard include/config/feature/editing/savehistory.h) \
    $(wildcard include/config/feature/editing/vi.h) \
    $(wildcard include/config/feature/editing/save/on/exit.h) \
    $(wildcard include/config/pmap.h) \
    $(wildcard include/config/feature/show/threads.h) \
    $(wildcard include/config/feature/ps/additional/columns.h) \
    $(wildcard include/config/feature/topmem.h) \
    $(wildcard include/config/feature/top/smp/process.h) \
    $(wildcard include/config/pgrep.h) \
    $(wildcard include/config/pkill.h) \
    $(wildcard include/config/pidof.h) \
    $(wildcard include/config/sestatus.h) \
    $(wildcard include/config/unicode/support.h) \
    $(wildcard include/config/feature/mtab/support.h) \
    $(wildcard include/config/feature/clean/up.h) \
    $(wildcard include/config/feature/devfs.h) \
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
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/ctype.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/locale_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__locale_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/dirent.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/dirent.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/dirent_ext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/errno.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/errno.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/errno.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/errno.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/errno.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/errno-base.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/error_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/fcntl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/fcntl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/fcntl-linux.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_iovec.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/falloc.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_timespec.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/time_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stat.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/struct_stat.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/inttypes.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/netdb.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/netinet/in.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/socket.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/socket.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/clock_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/clockid_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/timer_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/select.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/select.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/sigset_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__sigset_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_timeval.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/pthreadtypes.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/thread-shared-types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/pthreadtypes-arch.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/atomic_wide_counter.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/struct_mutex.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/struct_rwlock.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/socket_type.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sockaddr.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/socket.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/socket.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/posix_types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/stddef.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/posix_types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/posix_types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/bitsperlong.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/sockios.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/sockios.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_osockaddr.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/in.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/rpc/netdb.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/sigevent_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__sigval_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/netdb.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/setjmp.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/setjmp.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct___jmp_buf_tag.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/signal.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/signum-generic.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/signum-arch.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/sig_atomic_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/siginfo_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/siginfo-arch.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/siginfo-consts.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/siginfo-consts-arch.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/sigval_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigevent-consts.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigaction.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigcontext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/stack_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/ucontext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigstack.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigstksz.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/ss_flags.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_sigstack.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sigthread.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/signal_ext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/paths.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/stdio.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/lib/gcc/riscv64-unknown-linux-gnu/13.2.0/include/stdarg.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__fpos_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__mbstate_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__fpos64_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/__FILE.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/FILE.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_FILE.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/cookie_io_functions_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stdio_lim.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/floatn.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/floatn-common.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/stdlib.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/waitflags.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/waitstatus.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/alloca.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/stdlib-float.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/string.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/strings.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/libgen.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/poll.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/poll.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/poll.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/ioctl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/ioctls.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/ioctls.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/ioctls.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/ioctl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/ioctl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/ioctl.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/ioctl-types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/ttydefaults.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/mman.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/mman.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/mman-map-flags-generic.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/mman-linux.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/mman-shared.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/mman_ext.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/resource.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/resource.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_rusage.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/stat.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/statx.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/stat.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/types.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/int-ll64.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/statx-generic.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_statx_timestamp.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_statx.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/time.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/sysmacros.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/sysmacros.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/wait.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/idtype_t.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/termios.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-struct.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-c_cc.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-c_iflag.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-c_oflag.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-baud.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-c_cflag.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-c_lflag.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-tcflow.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/termios-misc.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/time.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/time.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/timex.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_tm.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/types/struct_itimerspec.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/param.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/param.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/linux/param.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm/param.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/asm-generic/param.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/pwd.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/grp.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/mntent.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/sys/statfs.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/bits/statfs.h \
  /home/jihong/Templates/risc-v64-naruto-pi/compile_tools/output/linux/sysroot/usr/include/arpa/inet.h \
  include/pwd_.h \
  include/grp_.h \
  include/shadow_.h \
  include/xatonum.h \
  coreutils/od_bloaty.c \
  include/common_bufsiz.h \

coreutils/od.o: $(deps_coreutils/od.o)

$(deps_coreutils/od.o):
