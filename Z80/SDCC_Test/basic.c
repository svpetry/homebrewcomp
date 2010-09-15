#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "malloc.h"

/* code: 0x0290-0x5fff
 * data: 0x6000-0x6fff
 * stack: 0x7000-0x77ff
 * vram buffer: 0x7800-0x7fff
 * code2: 0x8000-0x6fff
 */

volatile int glob = 12;

/******************************************************************************/
void init() {
	int i;
	for (i = 0; i < 16; i++);
}
/******************************************************************************/
void main() {
	char *p;

	init();
	glob = 15;

    p = malloc(100);

	return;
}
/******************************************************************************/

