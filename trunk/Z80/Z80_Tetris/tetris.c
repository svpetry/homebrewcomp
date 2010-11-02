#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "tmain.h"
#include "utils.h"
#include "utils3d.h"

/* code: 0x0290-0x9fff
 * data: 0xa000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	int time;

	io_write(5, 42);
	io_write(6, 15);

	io_write(7, 3);
	delay_ms(400);
	clrbuf();

	time = io_read(130) + ((int)io_read(131)) << 8;
	srand(time);
}
/******************************************************************************/
void main() {

	init();

	tetris();

	clrbuf();
	buf2screen();
	io_write(7, 1);
	delay_ms(400);

	quit_app();
	return;
}
/******************************************************************************/

