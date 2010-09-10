#include <string.h>

main() {
	_asm
		ld a, #1
		out (0), a // RAM-Bank 1 aktivieren
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

	memset(0x1000, 32, 0x0800);
	strcpy(0x1000, "Zilog Z84C0020PEC CPU, 131.072 Bytes RAM. Loading bios.bin...");

	_asm
		xor a, a
		out (7), a // disable VRAM

		halt
	_endasm;
	return 0;
}
