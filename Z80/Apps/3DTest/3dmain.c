#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "3dmain.h"
#include "../Lib/defs.h"
#include "../Lib/utils3d.h"
#include "../Lib/graphics.h"
#include "../Lib/utils.h"
#include "../Lib/io.h"

/******************************************************************************/

const struct vector cube[8] = {
	{-50, -50, 50},
	{50, -50, 50},
	{50, 50, 50},
	{-50, 50, 50},
	{-50, -50, -50},
	{50, -50, -50},
	{50, 50, -50},
	{-50, 50, -50}
};
const byte cube_lines[12][2] = {
	{0, 1},
	{1, 2},
	{2, 3},
	{3, 0},
	{4, 5},
	{5, 6},
	{6, 7},
	{7, 4},
	{0, 4},
	{1, 5},
	{2, 6},
	{3, 7}
};

const struct vector zed[20] = {
	{-40, -40, 18},
	{40, -40, 18},
	{40, -20, 18},
	{-20, 40, 18},
	{40, 40, 18},
	{40, 60, 18},
	{-40, 60, 18},
	{-40, 40, 18},
	{20, -20, 18},
	{-40, -20, 18},
	{-40, -40, -18},
	{40, -40, -18},
	{40, -20, -18},
	{-20, 40, -18},
	{40, 40, -18},
	{40, 60, -18},
	{-40, 60, -18},
	{-40, 40, -18},
	{20, -20, -18},
	{-40, -20, -18}
};
const byte zed_lines[30][2] = {
	{0, 1},
	{1, 2},
	{2, 3},
	{3, 4},
	{4, 5},
	{5, 6},
	{6, 7},
	{7, 8},
	{8, 9},
	{9, 0},
	{10, 11},
	{11, 12},
	{12, 13},
	{13, 14},
	{14, 15},
	{15, 16},
	{16, 17},
	{17, 18},
	{18, 19},
	{19, 10},
	{0, 10},
	{1, 11},
	{2, 12},
	{3, 13},
	{4, 14},
	{5, 15},
	{6, 16},
	{7, 17},
	{8, 18},
	{9, 19},
};


/******************************************************************************/
void start3d(void) {

	byte i;
	struct point points[20];
	struct point *p1, *p2;

	int alpha = 0, beta = 0, gamma = 0;

	while (io_read(128) == 255) {
		clrbuf();

		init_rotation(alpha, beta, gamma);

		for (i = 0; i < 8; i++)
			vec2point(&cube[i], &points[i]);

		for (i = 0; i < 12; i++) {
			p1 = &points[cube_lines[i][0]];
			p2 = &points[cube_lines[i][1]];
			line(p1->x, p1->y, p2->x, p2->y);
		}

		buf2screen();

		alpha += 10;
		if (alpha >= 1024)
			alpha = 0;
		beta += 7;
		if (beta >= 1024)
			beta = 0;
		gamma += 12;
		if (gamma >= 1024)
			gamma = 0;
	}

	alpha = beta = gamma = 0;
	while (io_read(128) == 255) {
		clrbuf();

		init_rotation(alpha, beta, gamma);

		for (i = 0; i < 20; i++)
			vec2point(&zed[i], &points[i]);

		for (i = 0; i < 30; i++) {
			p1 = &points[zed_lines[i][0]];
			p2 = &points[zed_lines[i][1]];
			line(p1->x, p1->y, p2->x, p2->y);
		}

		buf2screen();

		alpha += 10;
		if (alpha >= 1024)
			alpha = 0;
		beta += 7;
		if (beta >= 1024)
			beta = 0;
		gamma += 12;
		if (gamma >= 1024)
			gamma = 0;
	}

}
/******************************************************************************/

