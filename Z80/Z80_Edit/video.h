#include "defs.h"

#ifndef VIDEO_H_
#define VIDEO_H_

#define VIDEO_RAM 0x1080
#define VRAM_SIZE 0x0b80
#define VIDEO_BUFFER 0x4800
#define V_ROWS 23
#define V_COLS 80
#define V_ROWSIZE 128

#define V_SETCHAR(col, row, c) *((char *)VIDEO_RAM + (row << 7) + col) = c
#define V_GETCHAR(col, row) *((char *)VIDEO_RAM + (row << 7) + col)

static volatile char __at 0x0045 cur_col;
static volatile char __at 0x0046 cur_row;

void v_hidecursor();
void v_showcursor();
void v_cls();
void v_scrollup();
void v_scrolldown();
void v_backspace();

void putchar(char c);
void put_line(char *s, byte row);
void write_inverse(byte row, byte col, char *s);
void show_message(char *msg);

#endif /* VIDEO_H_ */

