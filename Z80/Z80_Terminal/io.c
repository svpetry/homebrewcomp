#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "io.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"

static byte io_val;
static word io_addr;

/******************************************************************************/
void puts_nlb(char *s) {
	char *p = s;
	while (*p) {
		putchar(*p);
		p++;
	}
}
/******************************************************************************/
char getchar(void) {
	byte result;
	byte cnt = 0;
	do
	{
		if (cnt == 0)
			v_showcursor();
		result = io_read(128);
		if (result == 255) {
			delay_ms(15);
			if (cnt == CURSOR_DELAY)
				v_hidecursor();
			if (++cnt == CURSOR_DELAY << 1)
				cnt = 0;
		}
	} while (result == 255);
	v_hidecursor();
	return result;
}
/******************************************************************************/
char getchar_nc(void)
{
	byte result;
	do
	{
		result = io_read(128);
	} while (result == 255);
	return result;
}
/******************************************************************************/
void beep(void) {
	IO_WRITE(4, #1);
	delay_ms(200);
	IO_WRITE(4, #0);
}
/******************************************************************************/
byte io_read(byte addr) {
	io_addr = addr;
	__asm
		push af
		push bc
		ld bc, (_io_addr)
		in a, (c)
		ld (_io_val), a
		pop bc
		pop af
	__endasm;
	return io_val;
}
/******************************************************************************/
void io_write(byte addr, byte val) {
	io_addr = addr;
	io_val = val;
	__asm
		push af
		push bc
		ld a,(_io_val)
		ld bc,(_io_addr)
		out (c),a
		pop bc
		pop af
	__endasm;
}
/******************************************************************************/

