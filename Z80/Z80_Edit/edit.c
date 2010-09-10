#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "io.h"
#include "video.h"
#include "editor.h"

/* code: 0x0290-0x5fff
 * data: 0x6000-0x7000
 * stack: 0x7000-0x77ff
 * vram buffer: 0x7800-0x7fff
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

	init_editor();
    start_editor();

	return;
}
/******************************************************************************/

