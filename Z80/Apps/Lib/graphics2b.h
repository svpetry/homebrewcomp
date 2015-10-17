#include "defs.h"

#ifndef GRAPHICS_H_
#define GRAPHICS_H_

extern char vbuf1[0x0c80];
extern char vbuf2[0x0c80];
extern byte active_buf;

void setpixel(byte x, byte y);
void clearpixel(byte x, byte y);
byte getpixel(byte x, byte y);

void buf2screen(void);
void clrbuf(void);

void line(byte x0, byte y0, byte x1, byte y1);

void vputchar(byte x, byte y, char c);
void vputs(byte x, byte y, char *s);

#endif /* GRAPHICS_H_ */

