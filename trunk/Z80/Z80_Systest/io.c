#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "io.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"

static byte io_val;
static word io_addr;
static volatile byte at 0x0080 filebuf[0x200];

/******************************************************************************/
char getchar(void) {
	byte result;
	do {
		result = io_read(128);
	} while (result == 255);
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
/******************************************************************************/

