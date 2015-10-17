#include <stdlib.h>
#include <string.h>

#include "defs.h"
#include "io.h"

byte io_val;
word io_addr;

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

