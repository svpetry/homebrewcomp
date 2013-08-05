#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "utils.h"
#include "golmain.h"

/* code: 0x0290-0x9fff
 * data: 0xa000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	int time;

	io_write(5, 0);
	io_write(6, 54);

	io_write(7, 3);
	delay_ms(200);

	time = io_read(130) + ((int)io_read(131)) << 8;
	srand(time);

	active_buf = 0;
}
/******************************************************************************/
void main() {

	init();

	start_gol();

	io_write(7, 1);
	delay_ms(200);

	quit_app();
	return;
}
/******************************************************************************/

