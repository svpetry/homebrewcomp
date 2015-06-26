#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "bios_cmd.h"
#include "video.h"
#include "utils.h"
#include "3dmain.h"
#include "utils3d.h"

/* code: 0x0290-0x77ff
 * data: 0x8000-0xf000
 * stack: 0xf000-0xffff
 * video buffer: 0x7800-0x7fff (2k)
 */

/******************************************************************************/
void init_graphic() {
	int time;

	// set foreground and background color
	io_write(5, 0);
	io_write(6, 21);

	// enable video ram, enable graphics mode
	io_write(7, 3);
	delay_ms(200);

	// randomize
	time = io_read(130) + ((int)io_read(131)) << 8;
	srand(time);
}
/******************************************************************************/
void main() {

	// enable video ram
	io_write(7, 1);
	puts("\n3DViewer (c) 2014 S.Petry\n");

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

