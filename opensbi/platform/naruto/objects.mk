#@file objects.mk
#@author JihongZhang (1042476967@qq.com)
#@brief Naruto Pi Opensbi.
#@version 0.1
#@date 2024-05-07
#
#@copyright Copyright (c) 2024

# Compiler flags
platform-cppflags-y =
platform-cflags-y =
platform-asflags-y =
platform-ldflags-y =

# Objects to build
platform-objs-y += platform.o

# Blobs to build
FW_JUMP=y
FW_TEXT_START=0xBFF80000
FW_JUMP_ADDR=0xB0200000
