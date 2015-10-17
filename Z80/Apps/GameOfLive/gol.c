#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/rand.h"
#include "../Lib/io.h"
#include "../Lib/utils.h"
#include "golmain.h"

/* code: 0x1280-0x27ff
 * data: 0x2800-0x4800
 * stack: 0xf000-0xffff
 */

volatile byte  __at 0x0060 bios_cmd;
volatile word  __at 0x0061 bios_p1;

/******************************************************************************/
void init() {
	bios_p1 = 0;
	bios_cmd = 0x02; // cursor control
	__asm
		rst 0x0010
	__endasm;

	io_write(5, 0);
	io_write(6, 54);

	io_write(7, 3);
	delay_ms(200);

	srand_dw();
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
