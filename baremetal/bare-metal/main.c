#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "ns16550.h"
#include "debug_log.h"

int main(int argc, char **argv)
{
	debug_log("Hello Naruto !\n");
	debug_log("Wellcome to Bare-metal !\n");

	while (1) {

	}

	return 0;
}
