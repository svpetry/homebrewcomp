#include <stdio.h>
#include <string.h>

#define IO_WRITE(addr, val) \
_asm \
	push af \
	ld a, val \
	out (addr), a \
	pop af \
_endasm;

typedef unsigned char byte;

static byte io_val;
static byte io_addr;

/******************************************************************************/
void isr (void) interrupt {

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
void delay_ms(int ms) {
	int i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
}
/******************************************************************************/
byte value;

main() {

//	IO_WRITE(0x10, #0x04)
	value = 0;
	while (1) {
		io_write(0, value);
//		value++;
//		io_write(130, value);
		delay_ms(20);
//		value = io_read(130);
	}

	return 0;
}
