#include <stdlib.h>
#include <string.h>

#include "graphics2b.h"
#include "defs.h"
#include "utils.h"


char vbuf1[0x0c80];
char vbuf2[0x0c80];
byte active_buf = 0;

const byte num[10][5 * 7] =
{
	{
		0, 1, 1, 1, 0,  // 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 1, 1, 
		1, 0, 1, 0, 1, 
		1, 1, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0
	}, {
		0, 0, 1, 0, 0,  // 1, 
		0, 1, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 1, 1, 1, 0
	}, {
		0, 1, 1, 1, 0,  // 2
		1, 0, 0, 0, 1, 
		0, 0, 0, 0, 1, 
		0, 0, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 1, 0, 0, 0, 
		1, 1, 1, 1, 1
	}, {
		1, 1, 1, 1, 1,  // 3
		0, 0, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 0, 1, 0, 
		0, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0
	}, {
		0, 0, 0, 1, 0,  // 4
		0, 0, 1, 1, 0, 
		0, 1, 0, 1, 0, 
		1, 0, 0, 1, 0, 
		1, 1, 1, 1, 1, 
		0, 0, 0, 1, 0, 
		0, 0, 0, 1, 0
	}, {
		1, 1, 1, 1, 1,  // 5
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 0, 
		0, 0, 0, 0, 1, 
		0, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0
	}, {
		0, 0, 1, 1, 0,  // 6
		0, 1, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0
	}, {
		1, 1, 1, 1, 1,  // 7
		0, 0, 0, 0, 1, 
		0, 0, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0
	}, {
		0, 1, 1, 1, 0,  // 8
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0
	}, {
		0, 1, 1, 1, 0,  // 9
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 1, 
		0, 0, 0, 0, 1, 
		0, 0, 0, 1, 0, 
		0, 1, 1, 0, 0
	}
};

const byte alpha[26][5 * 7] =
{
	{
		0, 1, 1, 1, 0,  // A
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1 
	}, {
		1, 1, 1, 1, 0,  // B
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 0
	}, {
		0, 1, 1, 1, 0,  // C
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0 
	}, {
		1, 1, 1, 0, 0,  // D
		1, 0, 0, 1, 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 1, 0, 
		1, 1, 1, 0, 0 
	}, {
		1, 1, 1, 1, 1,  // E
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 1 
	}, {
		1, 1, 1, 1, 1,  // F
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0 
	}, {
		0, 1, 1, 1, 0,  // G
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 0, 
		1, 0, 1, 1, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 1 
	}, {
		1, 0, 0, 0, 1,  // H
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1 
	}, {
		0, 1, 1, 1, 0,  // I
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 1, 1, 1, 0 
	}, {
		0, 0, 1, 1, 1,  // J
		0, 0, 0, 1, 0, 
		0, 0, 0, 1, 0, 
		0, 0, 0, 1, 0, 
		0, 0, 0, 1, 0, 
		1, 0, 0, 1, 0, 
		0, 1, 1, 0, 0 
	}, {
		1, 0, 0, 0, 1,  // K
		1, 0, 0, 1, 0, 
		1, 0, 1, 0, 0, 
		1, 1, 0, 0, 0, 
		1, 0, 1, 0, 0, 
		1, 0, 0, 1, 0, 
		1, 0, 0, 0, 1 
	}, {
		1, 0, 0, 0, 0,  // L
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 1 
	}, {
		1, 0, 0, 0, 1,  // M
		1, 1, 0, 1, 1, 
		1, 0, 1, 0, 1, 
		1, 0, 1, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1 
	}, {
		1, 0, 0, 0, 1,  // N
		1, 0, 0, 0, 1, 
		1, 1, 0, 0, 1, 
		1, 0, 1, 0, 1, 
		1, 0, 0, 1, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1 
	}, {
		0, 1, 1, 1, 0,  // O
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0 
	}, {
		1, 1, 1, 1, 0,  // P
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0 
	}, {
		0, 1, 1, 1, 0,  // Q
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 1, 0, 1, 
		1, 0, 0, 1, 0, 
		0, 1, 1, 0, 1 
	}, {
		1, 1, 1, 1, 0,  // R
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 1, 1, 1, 0, 
		1, 0, 1, 0, 0, 
		1, 0, 0, 1, 0, 
		1, 0, 0, 0, 1 
	}, {
		0, 1, 1, 1, 1,  // S
		1, 0, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		0, 1, 1, 1, 0, 
		0, 0, 0, 0, 1, 
		0, 0, 0, 0, 1, 
		1, 1, 1, 1, 0 
	}, {
		1, 1, 1, 1, 1,  // T
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0 
	}, {
		1, 0, 0, 0, 1,  // U
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 1, 1, 0 
	}, {
		1, 0, 0, 0, 1,  // V
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		0, 1, 0, 1, 0, 
		0, 0, 1, 0, 0 
	}, {
		1, 0, 0, 0, 1,  // W
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1, 
		1, 0, 1, 0, 1, 
		1, 0, 1, 0, 1, 
		1, 1, 0, 1, 1, 
		1, 0, 0, 0, 1 
	}, {
		1, 0, 0, 0, 1,  // X
		1, 0, 0, 0, 1, 
		0, 1, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 1, 0, 1, 0, 
		1, 0, 0, 0, 1, 
		1, 0, 0, 0, 1 
	}, {
		1, 0, 0, 0, 1,  // Y
		1, 0, 0, 0, 1, 
		0, 1, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0, 
		0, 0, 1, 0, 0 
	}, {
		1, 1, 1, 1, 1,  // Z
		0, 0, 0, 0, 1, 
		0, 0, 0, 1, 0, 
		0, 0, 1, 0, 0, 
		0, 1, 0, 0, 0, 
		1, 0, 0, 0, 0, 
		1, 1, 1, 1, 1
	}
};

/******************************************************************************/
void setpixel(byte x, byte y) {
	register char *p;
	if (active_buf == 0)
		p = vbuf1;
	else
		p = vbuf2;
	p = p + (x >> 1) + ((y & 0b11111100) << 5);
	*p = *p | (((x & 1) + 1) << ((y & 3) << 1));
}
/******************************************************************************/
void clearpixel(byte x, byte y) {
	register char *p;
	if (active_buf == 0)
		p = vbuf1;
	else
		p = vbuf2;
	p = p + (x >> 1) + ((y & 0b11111100) << 5);
	*p = *p & ~(((x & 1) + 1) << ((y & 3) << 1));
}
/******************************************************************************/
byte getpixel(byte x, byte y) {
	register char *p;
	if (active_buf == 0)
		p = vbuf2;
	else
		p = vbuf1;
	p = p + (x >> 1) + ((y & 0b11111100) << 5);
	return (*p & (((x & 1) + 1) << ((y & 3) << 1))) > 0;
}
/******************************************************************************/
void buf2screen() {
	register char *src;
	register char *dest;
	register byte i;

	if (active_buf == 0)
		src = vbuf1;
	else
		src = vbuf2;

	dest = (char *)0x1000;

	for (i = 0; i < 25; i++) {
		memcpy(dest, src, 80);
		dest += 128;
		src += 128;        
	}

	active_buf = 1 - active_buf;
}
/******************************************************************************/
void clrbuf() {
	register byte i;
	char *p;

	if (active_buf == 0)
		p = vbuf1;
	else
		p = vbuf2;

	for (i = 0; i < 25; i++) {
		memset(p, 0, 80);
		p += 0x80;
	}
}
/******************************************************************************/
void line(byte x0, byte y0, byte x1, byte y1) {
	int dy = y1 - y0;
	int dx = x1 - x0;
	char stepx, stepy;

	if (dy < 0) { dy = -dy;  stepy = -1; } else { stepy = 1; }
	if (dx < 0) { dx = -dx;  stepx = -1; } else { stepx = 1; }
	dy <<= 1;                                                  // dy is now 2*dy
	dx <<= 1;                                                  // dx is now 2*dx

	setpixel(x0, y0);
	if (dx > dy) {
		register int fraction = dy - (dx >> 1);                // same as 2*dy - dx
		while (x0 != x1) {
			if (fraction >= 0) {
				y0 += stepy;
				fraction -= dx;                                // same as fraction -= 2*dx
			}
			x0 += stepx;
			fraction += dy;                                    // same as fraction -= 2*dy
			setpixel(x0, y0);
		}
	} else {
		register int fraction = dx - (dy >> 1);
		while (y0 != y1) {
			if (fraction >= 0) {
				x0 += stepx;
				fraction -= dy;
			}
			y0 += stepy;
			fraction += dx;
			setpixel(x0, y0);
		}
	}
}
/******************************************************************************/
void vputchar(byte x, byte y, char c) {
	byte *p;
	register byte rowx;
	register byte xc, yc;

	if (c >= '0' && c <= '9')
		p = &num[c - '0'][0];
	else if (c >= 'A' && c <= 'Z')
		p = &alpha[c - 'A'][0];
	else if (c == ' ') {
		for (yc = 0; yc < 7; yc++) {
			rowx = x;
			for (xc = 0; xc < 6; xc++) {
				clearpixel(rowx, y);
				rowx++;
			}
			y++;
		}
		return;
	} else
		return;

	for (yc = 0; yc < 7; yc++) {
		rowx = x;
		for (xc = 0; xc < 5; xc++) {
			if (*p) {
				setpixel(rowx, y);
			} else {
				clearpixel(rowx, y);
			}
			rowx++;
			p++;
		}
		y++;
	}
}
/******************************************************************************/
void vputs(byte x, byte y, char *s) {
	while (*s) {
		vputchar(x, y, *s);
		x += 6;
		s++;
	}
}
/******************************************************************************/

