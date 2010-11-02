#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "video.h"
#include "defs.h"
#include "utils.h"

byte cur_col = 0;
byte cur_row = 0;

static volatile byte __at VIDEO_BUFFER linebuf[V_ROWS][V_COLS];
static volatile byte line_ptr = 0;

/******************************************************************************/
void v_hidecursor() {
	byte lidx;
	byte *p;

	lidx = line_ptr + cur_row;
	if (lidx >= V_ROWS)
		lidx -= V_ROWS;
	p = (byte *)VIDEO_RAM + (cur_row << 7) + cur_col;
	*p = linebuf[lidx][cur_col];
}
/******************************************************************************/
void v_showcursor() {
	byte lidx;
	byte *p;

	lidx = line_ptr + cur_row;
	if (lidx >= V_ROWS)
		lidx -= V_ROWS;
	p = (byte *)VIDEO_RAM + (cur_row << 7) + cur_col;
	*p = linebuf[lidx][cur_col] + 128;
}
/******************************************************************************/
void v_cls() {
	register byte i;
    register char *dest;

	dest = (char *)VIDEO_RAM;
	for (i = 0; i < V_ROWS; i++) {
		memset(dest, ' ', V_COLS);
		dest += V_ROWSIZE;
	}
	memset(&linebuf[0][0], ' ', V_ROWS * V_COLS);
	line_ptr = 0;
	cur_col = 0;
	cur_row = 0;
}
/******************************************************************************/
void v_scrollup() {
	byte i, lidx;

	memset(&linebuf[line_ptr][0], ' ', V_COLS);
	if (++line_ptr == V_ROWS)
		line_ptr = 0;

	lidx = line_ptr;
	for (i = 0; i < V_ROWS; i++) {
		memcpy((byte *)(VIDEO_RAM + (i << 7)), &linebuf[lidx][0], V_COLS);
		if (++lidx == V_ROWS)
			lidx = 0;
	}

	if (cur_row > 0)
		cur_row--;
}
/******************************************************************************/
void v_backspace() {
	byte lidx;

	if (cur_col > 0) {
        cur_col--;

		V_SETCHAR(cur_col, cur_row, ' ');

		lidx = line_ptr + cur_row;
		if (lidx >= V_ROWS)
			lidx -= V_ROWS;
		linebuf[lidx][cur_col] = ' ';
	}
}
/******************************************************************************/
void putchar(char c) {
	byte lidx;

	if (c == '\n') {
		cur_col = 0;
		if (++cur_row == V_ROWS)
			v_scrollup();
	} else if (c == '\t') {
    	cur_col++;
		while (cur_col & 3  > 0)
			cur_col++;
		if (cur_col >= V_COLS) {
			cur_col = 0;
			if (++cur_row == V_ROWS)
				v_scrollup();
		}
	} else {
		if (c == '\r')
			return;

		V_SETCHAR(cur_col, cur_row, c);

		lidx = line_ptr + cur_row;
		if (lidx >= V_ROWS)
			lidx -= V_ROWS;
		linebuf[lidx][cur_col] = c;

		cur_col++;
		if (cur_col == V_COLS) {
			cur_col = 0;
			if (++cur_row == V_ROWS)
				v_scrollup();
		}
	}
}
/******************************************************************************/

