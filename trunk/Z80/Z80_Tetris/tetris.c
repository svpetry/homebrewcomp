#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "tmain.h"

/* code: 0x0290-0x9fff
 * data: 0xa000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	v_cls();
	IO_WRITE(5, #8);
	IO_WRITE(6, #46);
}
/******************************************************************************/
void main() {
	init();


	return;
}
/******************************************************************************/

