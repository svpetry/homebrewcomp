/*
 * video.h
 *
 *  Created on: 08.06.2010
 *      Author: Sven
 */

#include "defs.h"

#ifndef VIDEO_H_
#define VIDEO_H_

#define VIDEO_RAM 0x1000
#define VRAM_SIZE 0x0c80
#define VIDEO_BUFFER 0x7800
#define V_ROWS 25
#define V_COLS 80
#define V_ROWSIZE 128

#define V_SETCHAR(col, row, c) *((char *)VIDEO_RAM + (row << 7) + col) = c

extern byte cur_col;
extern byte cur_row;

void v_hidecursor();
void v_showcursor();
void v_cls();
void v_scrollup();
void v_backspace();

void putchar(char c);

#endif /* VIDEO_H_ */
