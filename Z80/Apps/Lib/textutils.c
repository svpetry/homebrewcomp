#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "textutils.h"
#include "defs.h"
#include "bios_text.h"
#include "utils.h"

/******************************************************************************/
void putn(int n) {
	char s[20];
	itoa(n, s);
	puts(s);
}
/******************************************************************************/
void put_line(char *s, byte row) {
	byte lidx, i;
	char *p, *q;

	lidx = line_ptr + row;
	if (lidx >= rows_total)
		lidx -= rows_total;

	p = (char *)(VIDEO_RAM + ((row + rows_offset) << 7));
	q = s;
	i = 0;
	while (*q && i < V_COLS) {
		*(p++) = *(q++);
		i++;
	}
	while (i < V_COLS) {
		*(p++) = ' ';
		i++;
	}

	p = (char *)&linebuf[lidx][0];
	q = s;
	i = 0;
	while (*q && i < V_COLS) {
		*(p++) = *(q++);
		i++;
	}
	while (i < V_COLS) {
		*(p++) = ' ';
		i++;
	}
} // put_line
/******************************************************************************/
void write_inverse(byte row, byte col, char *s) {
	char *p = (char *)(0x1000 + (row << 7) + col);
	while (*s)
		*(p++) = *(s++) + 128;
} // write_inverse
/******************************************************************************/
void scrolldown() {
	byte i, lidx;

	if (line_ptr == 0)
		line_ptr = rows_total - 1;
	else
    	line_ptr--;
	memset(&linebuf[line_ptr][0], ' ', V_COLS);

	lidx = line_ptr;
	for (i = 0; i < rows_total; i++) {
		memcpy((byte *)(VIDEO_RAM + ((i + rows_offset) << 7)), &linebuf[lidx][0], V_COLS);
		if (++lidx == rows_total)
			lidx = 0;
	}

	if (cur_row < rows_total - 1)
		cur_row++;
} // scrolldown
/******************************************************************************/

