#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/io.h"
#include "editor.h"

/* code:        0x1290-0x33ff
 * data:        0x3400-0x35ff
 * stack:       0x3600-0x37ff
 * heap:		0x3800-0xffff
 */

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	clrscr();
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

