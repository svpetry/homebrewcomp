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

#define V_SETCHAR(col, row, c) *((char *)VIDEO_RAM + (row << 7) + col) = c

static volatile char __at 0x0045 cur_col;
static volatile char __at 0x0046 cur_row;

void v_cls();
void put_line(char *s, byte row);

#endif /* VIDEO_H_ */
