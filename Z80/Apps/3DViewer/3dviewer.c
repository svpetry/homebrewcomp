#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/io.h"
#include "../Lib/graphics.h"
#include "../Lib/utils.h"
#include "../Lib/utils3d.h"
#include "3dmain.h"

/* code:         0x1290-0x7fff
 * data:         0x8000-0xf000
 * stack:        0xf000-0xffff
 */

/******************************************************************************/
void init_graphic() {
	// set foreground and background color
	io_write(5, 0);
	io_write(6, 21);

	// enable video ram, enable graphics mode
	io_write(7, 3);
	delay_ms(200);

	hidecursor();
}
/******************************************************************************/
void main() {

	// enable video ram
	io_write(7, 1);
	puts("\n3DViewer (c) 2014-2015 S.Petry\n");

	if (!prog_paramcount)
	{
		puts("No file given!");
		puts("Press any key to continue.");
		getchar();
		quit_app();
	}

	if (!load_model(prog_params[0]))
	{
		puts("Press any key to continue.");
		getchar();
		quit_app();
	}

	init_graphic();

	clrbuf();
	buf2screen();
	start3d();

	io_write(7, 1);
	delay_ms(200);
	quit_app();
	return;
}
/******************************************************************************/

