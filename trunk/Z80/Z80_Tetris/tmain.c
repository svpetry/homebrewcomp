#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "tmain.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "io.h"
#include "defs.h"
#include "splashscreen.h"
#include "sound.h"


#define BLOCK_SIZE 5
#define PLAYF_WIDTH 10
#define PLAYF_HEIGHT 18
#define PLAYF_X 20
#define PLAYF_Y 4
#define PREVIEW_X 102
#define PREVIEW_Y 20


struct part {
	char x[4];
	char y[4];
};

const struct part parts[7] = {
	{
		{-1, -1, -1, -1},
		{-1, 0, 1, 2}
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
char next_part_no;
int lines;

/******************************************************************************/
void tetris(void) {
	char c, part_no;
	byte i, stop, start;

	show_splashscreen();

	io_write(5, 42);
	io_write(6, 15);

	draw_playfield();
	start_song();
	start = 1;

	while (1) {

		if (start) {
			next_part_no = rand() % 7;
			lines = 0;
			curr_y = 10;
			remove_complete_lines();
			clear_next_part();

			while (io_read(128) != 255);

			do {
				vputs(95, 65, "GET READY");
				buf2screen();
				delay_ms(300);

				vputs(95, 65, "         ");
				buf2screen();
                delay_ms(300);
			} while (io_read(128) == 255);
				  

			start = 0;
		}

		stop = 0;
		curr_x = 5;
		curr_y = 1;

    	clear_next_part();
		part_no = next_part_no;
		next_part_no = rand() % 7;
		draw_next_part();

		select_part(part_no);
		draw_curr_part();
		buf2screen();

		while (!stop) {

			for (i = 0; i < 20 && !stop; i++) {
				if (lines < 20)
					delay_ms(35);
				else if (lines < 50)
					delay_ms(25);
				else if (lines < 70)
					delay_ms(18);
				else if (lines < 100)
					delay_ms(12);
				else
					delay_ms(8);

				if (!stop) {
					c = io_read(128);
					if (c == ' ') { // rotate part
						rotate_curr_part();
						buf2screen();
					} else if (c == 0) { // left, right, down
						c = io_read(128);
						if (c == 75) { // left
							move_left();
							buf2screen();
						} else if (c == 77) { // right
							move_right();
							buf2screen();
						} else if (c == 80) { // down
							while (!move_down())
								buf2screen();
							buf2screen();
							stop = 1;
						}
					} else if (c == 27)
						return;
				} // if (!stop)
			}

			if (!stop) {
				stop = move_down();
				buf2screen();
			}
		}

        remove_complete_lines();

		if (curr_y <= 2) {
			clear_playfield();
			vputs(95, 65, "GAME OVER");
			buf2screen();

			getchar();
			vputs(95, 65, "         ");
			start = 1;
		}
	}
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
	for (i = 0; i < 4; i++) {
		if (is_block_set(curr_part.x[i] + curr_x, curr_part.y[i] + curr_y)) {
			curr_x++;
			break;
		}
	}
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
	for (i = 0; i < 4; i++) {
		if (is_block_set(curr_part.x[i] + curr_x, curr_part.y[i] + curr_y)) {
			curr_x--;
			break;
		}
	}
	draw_curr_part();
}
/******************************************************************************/
byte move_down(void) {
	byte pg;

	clear_curr_part();
	if (!part_on_ground())
		curr_y++;

	pg = part_on_ground();
	draw_curr_part();
	return pg;
}
/******************************************************************************/
byte part_on_ground(void) {
	byte i;

	for (i = 0; i < 4; i++) {
		if (curr_y + curr_part.y[i] == PLAYF_HEIGHT - 1)
			return 1;
	}
	for (i = 0; i < 4; i++) {
		if (is_block_set(curr_part.x[i] + curr_x, curr_part.y[i] + curr_y + 1))
			return 1;
	}
	return 0;
}
/******************************************************************************/
byte is_block_set(char x, char y) {
	return getpixel(PLAYF_X + x * BLOCK_SIZE, PLAYF_Y + y * BLOCK_SIZE);
}
/******************************************************************************/
void draw_playfield(void) {
	byte x, y;

	for (y = PLAYF_Y - 2; y < PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE + 1; y++) {
		if (y & 1) {
			setpixel(PLAYF_X - 1, y);
			setpixel(PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE, y);
		} else {
			setpixel(PLAYF_X - 2, y);
			setpixel(PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE + 1, y);
		}
	}

	for (x = PLAYF_X - 2; x < PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE + 2; x++) {
		if (x & 1) {
			setpixel(x, PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE);
		} else {
			setpixel(x, PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE + 1);
		}
	}

	vputs(100, 5, "TETRIS");

	line(PREVIEW_X, PREVIEW_Y, PREVIEW_X + 30, PREVIEW_Y);
	line(PREVIEW_X, PREVIEW_Y + 30, PREVIEW_X + 30, PREVIEW_Y + 30);
	line(PREVIEW_X, PREVIEW_Y, PREVIEW_X, PREVIEW_Y + 30);
	line(PREVIEW_X + 30, PREVIEW_Y, PREVIEW_X + 30, PREVIEW_Y + 30);

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
void draw_next_part(void) {
	byte i;
	char x, y;
	struct part *p;

	p = &parts[next_part_no];

	for (i = 0; i < 4; i++) {
		x = p->x[i];
		y = p->y[i];
		draw_preview_block(x + 2, y + 2);
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
void clear_next_part(void) {
	byte x, y;

	for (x = PREVIEW_X + 5; x < PREVIEW_X + 25; x++) {
		for (y = PREVIEW_Y + 5; y < PREVIEW_Y + 25; y++)
        	clearpixel(x, y);
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
byte rotate_curr_part() {
	register char *x, *y;
	char tmp, yd, ori_x;
	byte i;
	struct part temp_part;

	clear_curr_part();

	memcpy(&temp_part, &curr_part, sizeof(temp_part));
	ori_x = curr_x;

	yd = -1;

	x = curr_part.x;
	y = curr_part.y;
	for (i = 0; i < 4; i++) {
		tmp = *x;
		*x = -*y;
		*y = tmp;

		if (*y > yd)
			yd = *y;

		while (curr_x + *x > PLAYF_WIDTH - 1)
			curr_x--;
		while (curr_x + *x < 0)
			curr_x++;

		x++;
		y++;
	}

	yd = 1 - yd;
	y = curr_part.y;
	for (i = 0; i < 4; i++) {
		*y += yd;
		y++;
	}

	// rotation allowed?
	for (i = 0; i < 4; i++) {
		if (is_block_set(curr_part.x[i] + curr_x, curr_part.y[i] + curr_y)) {
            // undo rotation
			memcpy(&curr_part, &temp_part, sizeof(temp_part));
			curr_x = ori_x;
			break;
		}
	}

	draw_curr_part();
	return 0;
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
void draw_preview_block(char x, char y) {
	byte x_start, y_start, x1, y1;
	byte i;

	x_start = PREVIEW_X + BLOCK_SIZE * x;
	y_start = PREVIEW_Y + BLOCK_SIZE * y;

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
void clear_playfield(void) {
	register byte x, y;

	for (y = PLAYF_Y; y < PLAYF_Y + PLAYF_HEIGHT * BLOCK_SIZE; y++)
		for (x = PLAYF_X; x < PLAYF_X + PLAYF_WIDTH * BLOCK_SIZE; x++)
			clearpixel(x, y);
}
/******************************************************************************/
void remove_complete_lines(void) {
	char s[8];
    byte row, x, y, complete;

	for (row = curr_y - 1; row < curr_y + 3 && row < PLAYF_HEIGHT; row++) {
		complete = 1;
		for (x = 0; x < PLAYF_WIDTH && complete; x++) {
			if (!is_block_set(x, row))
				complete = 0;
		}

		if (complete) {
			for (y = row; y > 0; y--) {
				for (x = 0; x < PLAYF_WIDTH; x++) {
					if (is_block_set(x, y - 1))
						draw_block(x, y);
					else
                    	clear_block(x, y);
				}
            }
			lines++;
			buf2screen();
		}
	}

	itoa(lines, s);
	vputs(100, 80, "LINES     ");
	vputs(135, 80, s);

}
/******************************************************************************/

