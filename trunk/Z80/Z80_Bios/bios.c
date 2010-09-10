#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "defs.h"
#include "utils.h"
#include "video.h"
#include "io.h"
#include "bios_cmd.h"
#include "cmdline.h"


/*
 * BIOS Code	0x0280-0x3fff (ca 15.5k)
 * BIOS Data	0x4000-0x6fff (12k)
 * Video RAM	0x1000-0x1fff (4k)
 * Stack		0x7000-0x77ff (2k)
 * Video Buffer 0x7800-0x7fff (2k)
 */

void isr (void) interrupt {

}

// Ports initialisieren etc.
void init() {
	_asm
		push af
		ld a, #1
		out (7), a // enable VRAM
		ld a, #16
		out (5), a // Hintergrundfarbe
		ld a, #53
		out (6), a // Vordergrundfarbe
		pop af
	_endasm;
}

main() {
	init();
	v_cls();
	puts("Z80-DOS Ready.\n\n");
	cmdline();
	return 0;
}
