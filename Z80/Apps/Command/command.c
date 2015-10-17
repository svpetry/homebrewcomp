#include <stdlib.h>
#include <string.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/utils.h"
#include "../Lib/io.h"
#include "cmdline.h"


/*
 * BIOS Code	0x1280-0x4fff (ca 15.7k)
 * BIOS Data	0x5000-0x6fff (8k)
 * Video RAM	0x1000-0x1fff (4k)
 * Stack		0x7000-0x77ff (2k)
 */

void init() {
	__asm
		push af
		ld a, #1
		out (7), a // enable VRAM
		ld a, #16
		out (5), a // Hintergrundfarbe
		ld a, #53
		out (6), a // Vordergrundfarbe
		pop af
	__endasm;
}

main() {
	init();

	clrscr();

	puts("homebrewcomp OS 2.0   2010-2015\n\n");

	cmdline();
	return 0;
}
