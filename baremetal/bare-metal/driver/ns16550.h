#ifndef NS16550_H_
#define NS16550_H_

#include <stdint.h>

void ns16550_tx(uintptr_t addr, uint8_t c);
int ns16550_rx(uintptr_t addr, uint8_t *c, uint32_t timeout);

#endif /* NS16550_H_ */
