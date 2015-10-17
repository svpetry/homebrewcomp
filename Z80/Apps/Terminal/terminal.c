#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/io.h"
#include "main.h"

/* code:        0x1290-0x2fff
 * data:        0x3000-0x4000
 * stack:       0x4000-0x47ff
 */

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	clrscr();
	hidecursor();
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

