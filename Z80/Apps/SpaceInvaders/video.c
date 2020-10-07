#include <stdlib.h>
#include <string.h>

#include "../Lib/defs.h"
#include "../Lib/graphics.h"

byte num_small[10][3 * 5] =
{
	{
		1, 1, 1,
		1, 0, 1,
		1, 0, 1,
		1, 0, 1,
		1, 1, 1
	},
	{
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1
	},
	{
		1, 1, 1,
		0, 0, 1,
		1, 1, 1,
		1, 0, 0,
		1, 1, 1
	},
	{
		1, 1, 1,
		0, 0, 1,
		1, 1, 1,
		0, 0, 1,
		1, 1, 1
	},
	{
		1, 0, 1,
		1, 0, 1,
		1, 1, 1,
		0, 0, 1,
		0, 0, 1
	},
	{
		1, 1, 1,
		1, 0, 0,
		1, 1, 1,
		0, 0, 1,
		1, 1, 1
	},
	{
		1, 1, 1,
		1, 0, 0,
		1, 1, 1,
		1, 0, 1,
		1, 1, 1
	},
	{
		1, 1, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1
	},
	{
		1, 1, 1,
		1, 0, 1,
		1, 1, 1,
		1, 0, 1,
		1, 1, 1
	},
	{
		1, 1, 1,
		1, 0, 1,
		1, 1, 1,
		0, 0, 1,
		1, 1, 1
	}
};

/******************************************************************************/
void vputnum(byte x, byte y, byte num) {
	byte *p;
	register byte rowx;
	register byte xc, yc;

	p = &num_small[num][0];
	for (yc = 0; yc < 5; yc++) {
		rowx = x;
		for (xc = 0; xc < 3; xc++) {
			if (*p)
				setpixel(rowx, y);
			else
				clearpixel(rowx, y);
			rowx++;
			p++;
		}
		y++;
	}
}
/******************************************************************************/
