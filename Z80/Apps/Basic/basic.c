#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/io.h"
#include "../Lib/utils.h"
#include "vars.h"
#include "mybasic.h"

/* code1:       0x1288-0x69ff
 * data:        0x6a00-0x74ff
 * stack:       0x7500-0x7fff
 * code2:       0x8000-0xdfff (bank 0)
 * label stack: 0xe000-0xffff (bank 0)
 * prog[]:      0x8000-0xffff (bank 1)
 * malloc heap: 0x8000-0xffff (bank 2)
 */

/******************************************************************************/
void init(void) {
#ifndef _DEBUG
	ENABLE_VRAM;
	clrscr();
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
	puts("                               |_|       (c)2010-2015 S.Petry ");
	puts("\n");
	#ifdef _DEBUG
		load_program("TEST.BAS");
		puts("\n\nPress any key to continue.");
		getchar();
		system("cls");
		start_basic();
	#else
	if (prog_paramcount) {
		init_vars();
		load_program(prog_params[0]);
		puts("\n\nProgram ready. Press any key to start.");
		getchar();
		clrscr();
		start_basic();
	}
	puts("\n\nPress any key to quit.");
	getchar();
#endif // _DEBUG

	return;
}
/******************************************************************************/

