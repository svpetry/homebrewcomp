#ifndef IO_H_
#define IO_H_

#include "defs.h"

#ifdef _DEBUG

#define IO_WRITE(addr, val) ;

#else // _DEBUG

#define IO_WRITE(addr, val) \
_asm \
	push af \
	ld a, val \
	out (addr), a \
	pop af \
_endasm

#endif // _DEBUG


#define ENABLE_VRAM IO_WRITE(7, #1)
#define DISABLE_VRAM IO_WRITE(7, #0)
#define SELECT_BANK0 IO_WRITE(0, #1)
#define SELECT_BANK1 IO_WRITE(0, #2)
#define SELECT_BANK2 IO_WRITE(0, #4)

void puts_nlb(char *s);
#ifndef _DEBUG
char getchar(void);
byte io_read(byte addr);
void io_write(byte addr, byte val);
#endif
void beep(void);

#endif /* IO_H_ */
