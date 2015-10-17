#include <stdlib.h>
#include <string.h>

#include "video.h"
#include "../Lib/defs.h"

/******************************************************************************/
void v_showcursor(char show) {
	byte lidx;
	register byte *p;

	lidx = line_ptr + cur_row;
	if (lidx >= rows_total)
		lidx -= rows_total;
	p = (byte *)VIDEO_RAM + (((word)cur_row + rows_offset) << 7) + cur_col;
	*p = linebuf[lidx][cur_col] + (show ? 128 : 0);
}
/******************************************************************************/
void v_scrollup() {
	register byte i;
	byte lidx;

	memset(&linebuf[line_ptr][0], ' ', V_COLS);
	if (((byte)++line_ptr) == rows_total)
		line_ptr = 0;

	lidx = line_ptr;
	for (i = 0; i < rows_total; i++) {
		memcpy((byte *)(VIDEO_RAM + ((i + rows_offset) << 7)), &linebuf[lidx][0], V_COLS);
		if (++lidx == rows_total)
			lidx = 0;
	}

	if (cur_row > 0)
		cur_row--;
}
/******************************************************************************/
void putchar(char c) {
	byte lidx, next_col;

	if (c == '\n') { // line feed
		cur_col = 0;
		if ((byte)(++cur_row) == rows_total)
			v_scrollup();
	} else if (c == '\t') { // tab
    	cur_col++;
		while (cur_col & 3  > 0)
			cur_col++;
		if (cur_col >= V_COLS) {
			cur_col = 0;
			if ((byte)(++cur_row) == rows_total)
				v_scrollup();
		}
	} else {
		if (c == '\r') // ignore carriage return
			return;

		next_col = 1;
		if (c == 8) { // backspace
			c = ' ';
			next_col = 0;

			if (cur_col == 0) {
				if (cur_row == 0)
					return;
				cur_row--;
				cur_col = V_COLS - 1;
			}
			else
				cur_col--;
		}

		V_SETCHAR(cur_col, cur_row + rows_offset, c);

		lidx = line_ptr + cur_row;
		if (lidx >= rows_total)
			lidx -= rows_total;
		linebuf[lidx][cur_col] = c;

		if (next_col) {
			cur_col++;
			if (cur_col == V_COLS) {
				cur_col = 0;
				if (((byte)++cur_row) == rows_total)
					v_scrollup();
			}
		}
	}
}
/******************************************************************************/
