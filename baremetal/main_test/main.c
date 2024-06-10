#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "ns16550.h"
#include "debug_log.h"

volatile void app_function(void) __attribute__((section(".applications")));

void app_function(void)
{
    debug_log("app start !\n");

    while(1);
}

void jump_app(uint64_t app_addr)  
{
    asm volatile("jr a0" : : "r"(app_addr));
}

int main(int argc, char **argv)
{
    extern uint64_t __app_start;

    debug_log("hello world !\n");
    debug_log("__app_start=0x%x\n", (uint64_t)&__app_start);

    jump_app((uint64_t)&__app_start);

    while (1);

    return 0;
}
