#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "tmain.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "io.h"
#include "defs.h"


#define BLOCK_SIZE 5
#define PLAYF_WIDTH 10
#define PLAYF_HEIGHT 18
#define PLAYF_X 20
#define PLAYF_Y 4


struct part {
	char x[4];
	char y[4];
};

const struct part parts[7] = {
	{
		{-1, -1, -1, -1},
		{-2, -1, 0, 1}
	},
	{
		{-1, 0, -1, 0},
		{-1, -1, 0, 0}
	},
	{
		{-1, -1, -1, 0},
		{-1, 0, 1, 1}
	},
	{
		{0, 0, -1, 0},
		{-1, 0, 1, 1}
	},
	{
		{-1, -1, 0, 0},
		{-1, 0, 0, 1}
	},
	{
		{0, -1, 0, -1},
		{-1, 0, 0, 1}
	},
	{
		{-1, -1, 0, -1},
		{-1, 0, 0, 1}
    }
};

struct part curr_part;
char curr_x, curr_y;

/******************************************************************************/
void tetris(void) {
//	byte n;

	draw_playfield();




//	n = 0;
	curr_x = 5;
	curr_y = 1;

	select_part(5);
	draw_curr_part();
	
	while (io_read(128) != 27) {
		buf2screen();
		rotate_curr_part();
		delay_ms(500);
    }



//	while (io_read(128) != 27) {
//		select_part(n);
//		draw_curr_part();
//		buf2screen();
//
//		clear_curr_part();
//
//		if (n == 6)
//			n = 0;
//		else
//        	n++;
//    }

	getchar();

}
/******************************************************************************/
void move_left(void) {
	byte i;

	for (i = 0; i < 4; i++) {
		if (curr_x + curr_part.x[i] == 0)
			return;
	}

	clear_curr_part();
	curr_x--;
	draw_curr_part();
}
/******************************************************************************/
void move_right(void) {
	byte i;

	for (i = 0; i < 4; i++) {
		if (curr_x + curr_part.x[i] == PLAYF_WIDTH - 1)
			return;
	}

	clear_curr_part();
	curr_x++;
	draw_curr_part();
}
/******************************************************************************/
byte move_down(void) {
	byte i;

	clear_curr_part();
	curr_y++;

	for (i = 0; i < 4; i++) {
		if (curr_y + curr_part.y[i] == PLAYF_HEIGHT - 1) {
			draw_curr_part();
			return 1;
		}
	}

	for (i = 0; i < 4; i++) {
		if (is_block_set(curr_part.x[i] + curr_x, curr_part.y[i] + curr_y + 1)) {
			draw_curr_part();
			return 1;
		}

	}

	draw_curr_part();
	return 0;
}
/******************************************************************************/
byte is_block_set(char x, char y) {
	return getpixel(PLAYF_X + x * BLOCK_SIZE, PLAYF_Y + y * BLOCK_SIZE);
}
/******************************************************************************/
void draw_playfield(void) {
	byte x, y;

	for (y = PLAYF_Y - 2; y < PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE + 2; y++) {
		if (y & 1) {
			setpixel(PLAYF_X - 1, y);
			setpixel(PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE + 1, y);
		} else {
			setpixel(PLAYF_X - 2, y);
			setpixel(PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE + 2, y);
		}
	}

	for (x = PLAYF_X - 2; x < PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE + 3; x++) {
		if (x & 1) {
			setpixel(x, PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE + 1);
		} else {
			setpixel(x, PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE + 2);
		}
	}

	vputs(100, 5, "TETRIS");
	buf2screen();
}
/******************************************************************************/
void draw_curr_part(void) {
	byte i;
	char x, y;

	for (i = 0; i < 4; i++) {
		x = curr_part.x[i];
		y = curr_part.y[i];
		draw_block(x + curr_x, y + curr_y);
	}
}
/******************************************************************************/
void clear_curr_part(void) {
	byte i;
	char x, y;

	for (i = 0; i < 4; i++) {
		x = curr_part.x[i];
		y = curr_part.y[i];
		clear_block(x + curr_x, y + curr_y);
	}
}
/******************************************************************************/
void select_part(byte n) {
	struct part *p;
    byte i;

	p = &parts[n];

	for (i = 0;i < 4; i++) {
		curr_part.y[i] = p->y[i];
		curr_part.x[i] = p->x[i];
	}
}
/******************************************************************************/
void rotate_curr_part() {
	char *x, *y;
	char tmp;
	byte i;

	clear_curr_part();

	x = curr_part.x;
	y = curr_part.y;
	for (i = 0; i < 4; i++) {
		tmp = *x;
		*x = -*y;
		*y = tmp;
		x++;
		y++;
	}

	draw_curr_part();
}
/******************************************************************************/
void clear_block(char x, char y) {
	byte x1;
	byte x_start;
	byte y1;
    register byte xc, yc;

	x_start = PLAYF_X + BLOCK_SIZE * x;
	y1 = PLAYF_Y + BLOCK_SIZE * y;

	for (yc = 0; yc < BLOCK_SIZE; yc++) {
		x1 = x_start;
		for (xc = 0; xc < BLOCK_SIZE; xc++) {
			clearpixel(x1, y1);
			x1++;
		}
		y1++;
	}
}
/******************************************************************************/
void draw_block(char x, char y) {
	byte x_start, y_start, x1, y1;
	byte i;

	x_start = PLAYF_X + BLOCK_SIZE * x;
	y_start = PLAYF_Y + BLOCK_SIZE * y;

	x1 = x_start;
	y1 = y_start + BLOCK_SIZE - 1;
	for (i = 0; i < BLOCK_SIZE; i++) {
		setpixel(x1, y_start);
		setpixel(x1, y1);
		x1++;
	}

	x1 = x_start + BLOCK_SIZE - 1;
	y1 = y_start + 1;
	for (i = 0; i < BLOCK_SIZE - 2; i++) {
		setpixel(x_start, y1);
		setpixel(x1, y1);
		y1++;
	}

	setpixel(x_start + 2, y_start + 2);
}
/******************************************************************************/

