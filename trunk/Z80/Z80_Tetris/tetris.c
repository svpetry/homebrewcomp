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
	ENABLE_VRAM;
	IO_WRITE(5, #2);
	IO_WRITE(6, #5);

	clrbuf();
	buf2screen();
	IO_WRITE(7, #3);
	delay_ms(500);
}
/******************************************************************************/
void main() {

	init();

	tetris();

	clrbuf();
	buf2screen();
	IO_WRITE(7, #1);
	delay_ms(500);

	quit_app();
	return;
}
/******************************************************************************/

