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
__asm \
	push af \
	ld a, val \
	out (addr), a \
	pop af \
__endasm

#define ENABLE_VRAM io_write(7, 1)
#define DISABLE_VRAM io_write(7, 0)
#define SELECT_BANK0 io_write(0, 1)
#define SELECT_BANK1 io_write(0, 2)
#define SELECT_BANK2 io_write(0, 3)

void puts_nlb(char *s);
char getchar(void);
void beep(void);
byte io_read(byte addr);
void io_write(byte addr, byte val);

void list_dir(char *wildcard);
byte matches(char *file_name, char *wildcard);
void dump_file(char *file_name);
void delete_file(char *file_name);

#endif /* IO_H_ */
