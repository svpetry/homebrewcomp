#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "mybasic.h"
#include "utils.h"
#include "bios_cmd.h"

/* code1: 0x0290-0x5fff
 * data: 0x6000-0x6fff
 * stack: 0x7000-0x77ff
 * vram buffer: 0x7800-0x7fff
 * code2: 0x8000-0xdfff (bank 0)
 * label stack: 0xe000-0xffff (bank 0)
 * prog[]: 0x8000-0xffff (bank 1)
 * malloc heap: 0x8000-0xffff (bank 2)
 */

/******************************************************************************/
void init(void) {
#ifndef _DEBUG
	ENABLE_VRAM;
	v_cls();
	IO_WRITE(5, #32);
	IO_WRITE(6, #31);
#endif
}
/******************************************************************************/
void main() {
	init();

	puts("                    ___ _            _     ___          _    ");
	puts("                   / __(_)_ __  _ __| |___| _ ) __ _ __(_)__ ");
	puts("                   \\__ \\ | '  \\| '_ \\ / -_) _ \\/ _` (_-< / _|");
	puts("                   |___/_|_|_|_| .__/_\\___|___/\\__,_/__/_\\__|");
	puts("                               |_|           (c)2010 S.Petry ");
	puts("\n");
#ifdef _DEBUG
	load_program("TEST.BAS");
	puts("\n\nPress any key to continue.");
	start_basic();
#else
	if (prog_paramcount) {
		load_program(prog_params[0]);
		puts("\n\nProgram ready. Press any key to start.");
		getchar();
		v_cls();
		start_basic();
	}
#endif // _DEBUG

	puts("\n\nPress any key to continue.");
	getchar();
	quit_app();

	return;
}
/******************************************************************************/

