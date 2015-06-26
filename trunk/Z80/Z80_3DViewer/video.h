#include "defs.h"

#ifndef VIDEO_H_
#define VIDEO_H_

// text mode

#define VIDEO_RAM 0x1000
#define VRAM_SIZE 0x0c80
#define VIDEO_BUFFER 0x7800
#define V_ROWS 25
#define V_COLS 80
#define V_ROWSIZE 128

#define V_SETCHAR(col, row, c) *((char *)VIDEO_RAM + (row << 7) + col) = c

static volatile char __at 0x0045 cur_col;
static volatile char __at 0x0046 cur_row;

void v_hidecursor();
void v_showcursor();
void v_cls();
void v_scrollup();
void v_backspace();

void putchar(char c);

// graphic mode

#define SET_PIXEL(x, y) \
p = vbuf + ((x) >> 1) + (((y) & 0b11111100) << 5); \
*p = *p | ((((x) & 1) + 1) << (((y) & 3) << 1));

#define CLEAR_PIXEL(x, y) \
p = vbuf + ((x) >> 1) + (((y) & 0b11111100) << 5); \
*p = *p & ~((((x) & 1) + 1) << (((y) & 3) << 1));

extern char vbuf[0x0c80];

void setpixel(byte x, byte y);
void clearpixel(byte x, byte y);
byte getpixel(byte x, byte y);

void buf2screen(void);
void clrbuf(void);

void line(byte x0, byte y0, byte x1, byte y1);

void vputchar(byte x, byte y, char c);
void vputs(byte x, byte y, char *s);

#endif /* VIDEO_H_ */

