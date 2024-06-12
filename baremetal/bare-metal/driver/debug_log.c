#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include "ns16550.h"
#include "debug_log.h"

#define UART_LOG_BUFF_SIZE 1024


#ifdef __ASSEMBLER__
#define CONS(NUM, TYPE)NUM
#else
#define CONS(NUM, TYPE)NUM##TYPE
#endif /* __ASSEMBLER__ */

#define NS16550_ADDR		CONS(0x10002000, U)

static char printk_string[UART_LOG_BUFF_SIZE] = {0};


static int _puts(char *str)
{
    int counter = 0;
    if (!str)
    {
        return 0;
    }
    while (*str && (counter < UART_LOG_BUFF_SIZE))
    {
        if(*str == '\n')
	        ns16550_tx(NS16550_ADDR, '\r');
	    ns16550_tx(NS16550_ADDR, *str++);
        counter++;
    }
    return counter;
}

/* FIXME: Currently, the standard library seems
 to be unable to use @vsnprintf. */
int debug_log(char *fmt, ...)
{
    va_list args;
    int plen;
    va_start(args, fmt);
    plen = vsnprintf(printk_string, sizeof(printk_string)/sizeof(char) - 1, fmt, args);
    _puts(printk_string);
    va_end(args);

    return plen;
}


