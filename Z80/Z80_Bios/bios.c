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

void isr (void) __interrupt {
	beep();
}

// Ports initialisieren etc.
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
//	register char *s;
//	register char c;
//	char a;

	init();

//	c = 'A';
//	a = 0;
//	while (1) {
//
//		io_write(7, 0);
//		s = (char *)0x1000;
//		while (s < 0x1c80) {
//			*(s++) = a;
//		}
//
//		io_write(7, 1);
//		s = (char *)0x1000;
//		while (s < 0x1c80) {
//			*(s++) = c++;
//			if (c > 'Z')
//				c = 'A';
//		}
//
//		s = (char *)0x1000;
//		while (s < 0x1c80) {
//			if (*(s++) != a)
//				io_write(5, 0);
//		}
//		a++;
//
//	}

//	_asm
//		halt;
//	_endasm;
//
	v_cls();

//	puts(" ________   ___     ____                            _            ");
//	puts("|__  ( _ ) / _ \\   / ___|___  _ __ ___  _ __  _   _| |_ ___ _ __ ");
//	puts("  / // _ \\| | | | | |   / _ \\| '_ ` _ \\| '_ \\| | | | __/ _ \\ '__|");
//	puts(" / /| (_) | |_| | | |__| (_) | | | | | | |_) | |_| | ||  __/ |   ");
//	puts("/____\\___/ \\___/   \\____\\___/|_| |_| |_| .__/ \\__,_|\\__\\___|_|   ");
//	puts("									   |_|                         ");
//	puts("homebrewcomp.googlecode.com\n");
	puts("System ready.\n\n");


	cmdline();
	return 0;
}
