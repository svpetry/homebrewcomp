#include <string.h>
#include <stdlib.h>

#include "space_main.h"
#include "video.h"
#include "../Lib/bios_text.h"
#include "../Lib/utils.h"
#include "../Lib/graphics.h"
#include "../Lib/sound.h"
#include "../Lib/io.h"

/* code: 0x0290-0x9fff
 * data: 0xa000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	int time;

	hidecursor();

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

	//ball_demo();
	space();

	send_sound_cmd("ST");

	clrbuf();
	buf2screen();
	io_write(7, 1);
	delay_ms(100);

	return;
}
/******************************************************************************/

