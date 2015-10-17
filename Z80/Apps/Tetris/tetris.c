#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/graphics.h"
#include "../Lib/utils.h"
#include "../Lib/sound.h"
#include "../Lib/rand.h"
#include "../Lib/io.h"
#include "tmain.h"
#include "tsound.h"

/* code: 0x1290-0x3fff
 * data: 0x4000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	hidecursor();
	io_write(5, 42);
	io_write(6, 15);

	io_write(7, 3);
	delay_ms(400);
	clrbuf();

	srand_dw();
}
/******************************************************************************/
void main() {

	init();

	tetris();

	send_sound_cmd("ST");

	clrbuf();
	buf2screen();
	io_write(7, 1);
	delay_ms(400);

	quit_app();
	return;
}
/******************************************************************************/

