#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "space_main.h"
#include "utils.h"
#include "utils3d.h"
#include "sound.h"

/* code: 0x0290-0x9fff
 * data: 0xa000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	int time;

	io_write(5, 0); // set background color
	io_write(6, 53); // set foreground color

    io_write(7, 3); // enable vga ram at 0x1000, set video mode
	delay_ms(100);
	clrbuf();

	time = io_read(130) + ((int)io_read(131)) << 8;
	srand(time);
}
/******************************************************************************/
void main() {

	init();

	space();

	send_sound_cmd("ST");

	clrbuf();
	buf2screen();
	io_write(7, 1);
	delay_ms(100);

	quit_app();
	return;
}
/******************************************************************************/

