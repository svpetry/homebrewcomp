#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "splashscreen.h"
#include "defs.h"
#include "io.h"
#include "utils.h"
#include "video.h"


/******************************************************************************/
const char picture[25][80] = {

	{

		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 128, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 64, 128, 192, 192,
		192, 192, 192, 192, 192, 192, 192, 192, 192, 192,
		192, 192, 192, 192, 192, 192, 64, 0, 0, 0
	}, {
		0, 128, 254, 127, 47, 47, 47, 47, 47, 47,
		47, 47, 47, 47, 47, 47, 47, 31, 31, 31,
		31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
		31, 31, 31, 31, 31, 31, 31, 31, 31, 31,
		31, 31, 63, 47, 47, 47, 47, 47, 47, 47,
		47, 47, 47, 47, 47, 47, 191, 127, 143, 15,
		159, 143, 15, 31, 47, 15, 79, 47, 143, 143,
		143, 143, 15, 159, 143, 15, 191, 245, 0, 0
	}, {
		0, 170, 255, 68, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 85, 187, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 23, 170,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 0, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 133, 254, 85, 187, 255,
		255, 255, 255, 0, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 133, 255, 95, 0, 0
	}, {
		0, 170, 255, 68, 223, 119, 127, 251, 187, 123,
		251, 123, 251, 123, 251, 187, 85, 170, 119, 127,
		123, 119, 127, 251, 187, 183, 223, 133, 254, 162,
		191, 123, 123, 247, 183, 191, 187, 183, 119, 127,
		123, 255, 0, 223, 247, 183, 191, 219, 7, 79,
		43, 247, 183, 95, 161, 255, 255, 85, 171, 187,
		183, 223, 255, 0, 255, 187, 187, 183, 183, 63,
		59, 55, 55, 191, 5, 250, 127, 1, 0, 0
	}, {
		0, 42, 255, 212, 201, 195, 203, 10, 219, 158,
		149, 95, 86, 195, 198, 197, 69, 170, 102, 215,
		151, 183, 7, 198, 203, 201, 225, 254, 255, 192,
		199, 198, 203, 42, 219, 155, 91, 117, 71, 195,
		203, 202, 64, 181, 167, 231, 173, 77, 42, 161,
		231, 173, 79, 224, 255, 87, 255, 85, 3, 67,
		69, 73, 73, 0, 27, 219, 155, 91, 221, 144,
		173, 253, 253, 210, 250, 255, 5, 0, 0, 0
	}, {
		0, 0, 11, 15, 15, 175, 255, 0, 85, 151,
		150, 22, 85, 238, 255, 255, 85, 170, 170, 170,
		170, 166, 130, 195, 131, 67, 67, 239, 255, 15,
		15, 255, 255, 162, 166, 166, 166, 173, 0, 255,
		255, 255, 85, 167, 166, 166, 166, 70, 32, 77,
		90, 153, 128, 143, 47, 255, 255, 85, 35, 110,
		106, 106, 106, 168, 82, 38, 101, 101, 101, 77,
		82, 175, 255, 79, 7, 1, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 90, 74,
		82, 70, 20, 238, 255, 255, 85, 32, 69, 153,
		138, 42, 34, 68, 149, 6, 232, 255, 23, 0,
		0, 255, 255, 8, 145, 37, 70, 154, 0, 255,
		255, 255, 85, 145, 37, 73, 25, 82, 2, 146,
		38, 70, 154, 34, 68, 43, 255, 85, 10, 146,
		38, 74, 82, 162, 255, 82, 6, 154, 34, 70,
		26, 80, 175, 253, 64, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 132, 4,
		153, 130, 4, 238, 255, 255, 85, 2, 146, 4,
		17, 69, 9, 194, 194, 232, 255, 23, 0, 0,
		0, 255, 255, 130, 4, 25, 138, 136, 0, 255,
		255, 255, 85, 4, 25, 34, 130, 4, 170, 80,
		9, 34, 132, 5, 26, 64, 43, 85, 130, 4,
		153, 136, 34, 136, 255, 255, 82, 4, 133, 6,
		146, 4, 18, 191, 253, 64, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 65, 34,
		128, 8, 0, 238, 255, 255, 85, 2, 132, 2,
		132, 2, 34, 255, 127, 31, 5, 0, 0, 0,
		0, 255, 255, 0, 34, 2, 16, 4, 0, 255,
		255, 255, 85, 2, 146, 2, 72, 0, 170, 255,
		82, 0, 33, 2, 136, 0, 65, 1, 0, 130,
		8, 128, 2, 162, 255, 127, 255, 82, 4, 34,
		64, 34, 0, 2, 191, 253, 64, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 0, 0,
		0, 0, 1, 238, 255, 255, 85, 0, 0, 4,
		0, 0, 162, 255, 85, 0, 0, 0, 0, 0,
		0, 255, 255, 0, 8, 0, 2, 0, 0, 255,
		255, 255, 85, 0, 0, 0, 0, 0, 170, 255,
		255, 80, 2, 0, 0, 0, 16, 0, 2, 0,
		4, 0, 0, 162, 255, 85, 43, 255, 80, 0,
		0, 2, 0, 0, 2, 191, 253, 64, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 0, 0,
		0, 0, 0, 238, 255, 255, 85, 0, 0, 0,
		0, 0, 8, 255, 245, 240, 240, 240, 240, 240,
		240, 255, 255, 0, 0, 0, 0, 0, 0, 255,
		255, 255, 85, 0, 0, 0, 0, 0, 170, 255,
		191, 255, 80, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 34, 191, 245, 240, 255, 255, 80,
		0, 0, 0, 0, 0, 2, 191, 253, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 0, 0,
		0, 0, 0, 238, 255, 255, 85, 0, 0, 0,
		0, 0, 2, 3, 3, 3, 3, 3, 3, 3,
		11, 255, 255, 0, 0, 0, 0, 0, 0, 255,
		255, 255, 85, 0, 0, 0, 0, 0, 170, 255,
		0, 175, 255, 80, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 3, 3, 3, 3, 1,
		0, 0, 0, 0, 0, 0, 170, 255, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 0, 0,
		0, 0, 0, 238, 255, 255, 85, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 10, 255, 0, 0, 0, 0, 0, 0, 255,
		255, 255, 85, 0, 0, 0, 0, 0, 170, 255,
		0, 0, 175, 253, 80, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 170, 255, 0, 0
	}, {
		0, 0, 0, 0, 0, 170, 255, 0, 0, 0,
		0, 0, 0, 238, 255, 255, 85, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 10, 0, 0, 0, 0, 0, 0, 255,
		255, 255, 85, 0, 0, 0, 0, 0, 170, 255,
		0, 0, 0, 175, 253, 64, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 170, 255, 0, 0
	}, {
		0, 0, 0, 0, 0, 10, 191, 252, 252, 252,
		252, 252, 252, 254, 31, 47, 253, 252, 252, 252,
		252, 252, 252, 252, 252, 252, 252, 252, 252, 252,
		252, 252, 252, 252, 252, 252, 252, 252, 252, 255,
		15, 191, 253, 252, 252, 252, 252, 252, 254, 127,
		0, 0, 0, 0, 47, 253, 252, 252, 252, 252,
		252, 252, 252, 252, 252, 252, 252, 252, 252, 252,
		252, 252, 252, 252, 252, 252, 254, 31, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}, {
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	}
};/******************************************************************************/
void show_splashscreen(void) {
	char *dest;
	byte x, y;

	io_write(5, 0);
	io_write(6, 0);

	dest = (char *)0x1000;

	for (y = 0; y < 25; y++) {
		for (x = 0; x < 80; x++) {
			*dest = picture[y][x];
			dest++;    
		}
		dest += 48;
	}

	delay_ms(500);

	io_write(5, 0);
	io_write(6, 2);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 10);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 5);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 15);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 63);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 15);

	getchar();

	io_write(5, 0);
	io_write(6, 15);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 5);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 10);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 2);

	delay_ms(120);

	io_write(5, 0);
	io_write(6, 0);

	clrbuf();
	buf2screen();

	io_write(5, 42);
	io_write(6, 15);
}
/******************************************************************************/

