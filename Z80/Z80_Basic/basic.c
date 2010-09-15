#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "mybasic.h"

/* code1: 0x0290-0x5fff
 * data: 0x6000-0x6fff
 * stack: 0x7000-0x77ff
 * vram buffer: 0x7800-0x7fff
 * code2: 0x8000-0xffff
 */

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	v_cls();
	IO_WRITE(5, #32);
	IO_WRITE(6, #31);
}
/******************************************************************************/
void main() {
	init();

	start_basic();
	
	return;
}
/******************************************************************************/

