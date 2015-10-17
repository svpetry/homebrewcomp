#ifndef IO_H_
#define IO_H_

#include "defs.h"

void beep(void);
byte io_read(byte addr);
void io_write(byte addr, byte val);

#endif /* IO_H_ */
