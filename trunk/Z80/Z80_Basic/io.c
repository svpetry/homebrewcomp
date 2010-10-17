#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "io.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"

#ifndef _DEBUG
static byte io_val;
static word io_addr;
static volatile byte at 0x0080 filebuf[0x200];
#endif // _DEBUG
static byte io_rand = 0;

/******************************************************************************/
void puts_nlb(char *s) {
	char *p = s;
	while (*p) {
		putchar(*p);
		p++;
	}
}
/******************************************************************************/
#ifndef _DEBUG
char getchar(void) {
	byte result;
	byte cnt = 0;
	unsigned int r_val = 0;
	do
	{
		if (cnt == 0)
			v_showcursor();
		result = io_read(128);
		if (result == 255) {
			delay_ms(15);
			if (cnt == 20)
				v_hidecursor();
			if (++cnt == 40)
				cnt = 0;
		}
		r_val++;
	} while (result == 255);
	v_hidecursor();

	if (io_rand == 0) {
		srand(r_val);
    	io_rand = 1;
	}

	if (result == 27)
    	quit_app();

	return result;
}
/******************************************************************************/
byte io_read(byte addr) {
	io_addr = addr;
	_asm
		push af
		push bc
		ld bc, (_io_addr)
		in a, (c)
		ld (_io_val), a
		pop bc
		pop af
	_endasm;
	return io_val;
}
/******************************************************************************/
void io_write(byte addr, byte val) {
	io_addr = addr;
	io_val = val;
	_asm
		push af
		push bc
		ld a,(_io_val)
		ld bc,(_io_addr)
		out (c),a
		pop bc
		pop af
	_endasm;
}
#endif
/******************************************************************************/
void beep(void) {
	IO_WRITE(4, #1);
	delay_ms(200);
	IO_WRITE(4, #0);
}
/******************************************************************************/
