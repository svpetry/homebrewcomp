#include "defs.h"

#ifndef VIDEO_H_
#define VIDEO_H_

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

