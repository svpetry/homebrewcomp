#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/io.h"
#include "../Lib/graphics.h"
#include "../Lib/utils.h"
#include "../Lib/utils3d.h"
#include "3dmain.h"

/* code: 0x1290-0x4fff
 * data: 0x5000-0xf000
 * stack: 0xf000-0xffff
 */

/******************************************************************************/
void init() {
	bios_p1 = 0;
	bios_cmd = 0x02; // cursor control
	__asm
		rst 0x0010
	__endasm;

	// set background color and foreground color
	io_write(5, 0);
	io_write(6, 21);

	// enable video mode
	io_write(7, 3);
	delay_ms(200);
}
/******************************************************************************/
void main() {

	init();

	clrbuf();
	buf2screen();
	start3d();

	// enable text mode
	io_write(7, 1);
	delay_ms(200);

	quit_app();
	return;
}
/******************************************************************************/

