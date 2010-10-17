#include <string.h>

//static unsigned char io_val;
//static unsigned int io_addr;

/******************************************************************************/
//unsigned char io_read(unsigned char addr) {
//	io_addr = addr;
//	_asm
//		push af
//		push bc
//		ld bc, (_io_addr)
//		in a, (c)
//		ld (_io_val), a
//		pop bc
//		pop af
//	_endasm;
//	return io_val;
//}
/******************************************************************************/
//void io_write(unsigned char addr, unsigned char val) {
//	io_addr = addr;
//	io_val = val;
//	_asm
//		push af
//		push bc
//		ld a,(_io_val)
//		ld bc,(_io_addr)
//		out (c),a
//		pop bc
//		pop af
//	_endasm;
//}
/******************************************************************************/
void delay_ms(unsigned int ms) {
	unsigned int i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
}
/******************************************************************************/
main() {

	_asm
		ld a, #1
		out (0), a // RAM-Bank 0 aktivieren
		out (7), a // enable VRAM
		xor a, a
		out (1), a // ext. Port = 0
		out (2), a // ext. Port = 0
		out (3), a // LED aus
		out (4), a // PC-Speaker aus
		ld a, #16
		out (5), a // Hintergrundfarbe
		ld a, #53
		out (6), a // Vordergrundfarbe
	_endasm;

	delay_ms(250);

	memset(0x1000, 32, 0x0C80);
	strcpy(0x1000, "Zilog Z84C0020PEC CPU, 131.072 Bytes RAM. Loading bios.bin...");


	_asm
		xor a, a
		out (7), a // disable VRAM

		halt
	_endasm;
	return 0;
}