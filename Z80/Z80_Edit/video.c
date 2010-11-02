#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "video.h"
#include "defs.h"
#include "utils.h"

char cur_col = 0;
char cur_row = 0;

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
void v_scrolldown() {
	byte i, lidx;

	if (line_ptr == 0)
		line_ptr = V_ROWS - 1;
	else
    	line_ptr--;
	memset(&linebuf[line_ptr][0], ' ', V_COLS);

	lidx = line_ptr;
	for (i = 0; i < V_ROWS; i++) {
		memcpy((byte *)(VIDEO_RAM + (i << 7)), &linebuf[lidx][0], V_COLS);
		if (++lidx == V_ROWS)
			lidx = 0;
	}

	if (cur_row < V_ROWS - 1)
		cur_row++;
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
void put_line(char *s, byte row) {
	byte lidx, i;
	char *p, *q;

	lidx = line_ptr + row;
	if (lidx >= V_ROWS)
		lidx -= V_ROWS;

	p = (char *)(VIDEO_RAM + (row << 7));
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
}
/******************************************************************************/
void write_inverse(byte row, byte col, char *s) {
	char *p = (char *)(0x1000 + (row << 7) + col);
	while (*s)
		*(p++) = *(s++) + 128;
}
/******************************************************************************/
void show_message(char *msg) {
	memset(0x1c00, ' ' + 128, 80);
	write_inverse(24, 1, msg);
}
/******************************************************************************/

