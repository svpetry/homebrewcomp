/*
 * io.h
 *
 *  Created on: 08.06.2010
 *      Author: Sven
 */

#ifndef IO_H_
#define IO_H_

#include "defs.h"

#define IO_WRITE(addr, val) \
_asm \
	push af \
	ld a, val \
	out (addr), a \
	pop af \
_endasm

#define ENABLE_VRAM IO_WRITE(7, #1)
#define DISABLE_VRAM IO_WRITE(7, #0)
#define SELECT_BANK0 IO_WRITE(0, #1)
#define SELECT_BANK1 IO_WRITE(0, #2)
#define SELECT_BANK2 IO_WRITE(0, #3)

void puts_nlb(char *s);
char getchar(void);
void beep(void);
byte io_read(byte addr);
void io_write(byte addr, byte val);

void delete_file(char *file_name);

#endif /* IO_H_ */
