#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "video.h"
#include "defs.h"
#include "utils.h"

/******************************************************************************/
void v_cls() {
	memset(VIDEO_RAM, ' ', VRAM_SIZE);
}
/******************************************************************************/
void put_line(char *s, byte row) {
	byte i;
	char *p;

	p = (char *)(VIDEO_RAM + (row << 7));
	i = 0;
	while (*s && i < 80) {
		*(p++) = *(s++);
		i++;
	}
	while (i < 80) {
		*(p++) = ' ';
		i++;
	}
}
/******************************************************************************/

