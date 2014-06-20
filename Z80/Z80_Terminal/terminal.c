#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "main.h"

/* code: 0x0290-0x2fff
 * data: 0x3000-0x4000
 * stack: 0x4000-0x47ff
 * vram buffer: 0x4800-0x4fff
 */

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	v_cls();
	IO_WRITE(5, #0);
	IO_WRITE(6, #46);
}
/******************************************************************************/
void main() {
	init();

	init_terminal();
    start_terminal();

	return;
}
/******************************************************************************/

