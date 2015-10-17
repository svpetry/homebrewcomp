#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "../Lib/defs.h"
#include "../Lib/bios_cmd.h"
#include "space_main.h"
#include "video.h"
#include "utils.h"
#include "io.h"
#include "sound.h"


byte invader[6][9][10] = 
{
	{
		{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 1, 1, 1, 1, 0, 0, 0 },
		{ 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 0, 0, 1, 0, 1, 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 }
	},
	{
		{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 },
		{ 0, 0, 0, 1, 1, 1, 1, 0, 0, 0 },
		{ 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 0, 0, 1, 0, 1, 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 },
		{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 }
	},
	{
		{ 0, 0, 0, 1, 1, 1, 1, 0, 0, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 1, 0, 0, 1, 1, 1, 1 },
		{ 0, 0, 1, 0, 1, 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
	},
	{
		{ 0, 0, 0, 1, 1, 1, 1, 0, 0, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 1, 0, 0, 1, 1, 1, 1 },
		{ 0, 0, 1, 0, 1, 1, 0, 1, 0, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 }
	},
	{
		{ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 },
		{ 0, 1, 1, 0, 1, 1, 0, 1, 1, 0 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 0, 1, 1, 1, 1, 1, 1, 0, 1 },
		{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
		{ 0, 0, 0, 0, 1, 1, 0, 0, 0, 0 }
	},
	{
		{ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 },
		{ 1, 0, 0, 1, 0, 0, 1, 0, 0, 1 },
		{ 1, 0, 1, 1, 1, 1, 1, 1, 0, 1 },
		{ 1, 1, 1, 0, 1, 1, 0, 1, 1, 1 },
		{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0 },
		{ 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 }
	}
};

byte invader_destroyed[9][10] =
{
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
};

byte tank[8][7] =
{
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 0, 1, 0, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 0, 1, 1, 1, 0, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 0, 1, 1, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1, 1, 1 }
};

char tank_char[2][4];

byte invaders_alive[8][3];
byte inv_x_first, inv_x_last;

byte inv_pos_x, inv_pos_y;
byte inv_look;
char inv_dir;
byte inv_count;
byte tank_pos;

byte shot_y, shot_x;
byte inv_shot_y, inv_shot_x;

/******************************************************************************/
void ball_demo(void) {

	byte x, y;
	char dx, dy;

	x = 0;
	y = 0;
	dx = 1;
	dy = 1;

	while (1)
	{
		clrbuf();
		setpixel(x    , y    );
		setpixel(x + 1, y    );
		setpixel(x    , y + 1);
		setpixel(x + 1, y + 1);
		buf2screen();

		if (dx == 1)
		{
			if (++x == 158)
				dx = 0;
		}
		else
		{
			if (--x == 0)
				dx = 1;
		}

		if (dy == 1)
		{
			if (++y == 98)
				dy = 0;
		}
		else
		{
			if (--y == 0)
				dy = 1;
		}
	}

}
/******************************************************************************/
void space(void) {
	byte c;
	byte move_left, move_right;
	char delay_count;
	byte do_exit;

	move_left = 0;
	move_right = 0;
	shot_y = 0;
	shot_x = 0;
	inv_shot_y = 0;
	inv_shot_x = 0;
	do_exit = 0;

	clrbuf();
	init_game();

	delay_count = 0;
	do
	{
		clrbuf();
		draw_invaders();
		draw_tank(tank_pos);
		
		// tank shot
		tank_shot();

		// invader shot
		invaders_shot();

		buf2screen();

		// delay invader movement
		if (++delay_count >= 5 - ((char)inv_pos_y / 3))
		{
			delay_count = 0;
			move_invaders();
		}

		// delay
		if (inv_count < 14)
			delay_ms((14 - inv_count));

		// read keyboard
		c = io_read(129);
		if (c == 0xe0)
		{
			c = io_read(129);
			if (c == 0x6b) // left down
			{
				move_left = 1;
			}
			else if (c == 0x74) // right down
			{
				move_right = 1;
			}
			else if (c == 0x6b + 0x80) // left up
			{
				move_left = 0;
			}
			else if (c == 0x74 + 0x80) // right up
			{
				move_right = 0;
			}
		}
		else if (c == 0x29) // shoot
		{
			if (shot_y == 0)
			{
				shot_x = (tank_pos + 1) * 2 + 1;
				shot_y = 90;
			}
		}
		else if (c == 0x76) // escape
		{
			do_exit = 1;
		}

		// move tank
		if (move_left)
		{
			if (tank_pos > 0)
				tank_pos -= 1;
		}
		else if (move_right)
		{
			if (tank_pos < 76)
				tank_pos += 1;
		}

	} while (!do_exit);
}
/******************************************************************************/
void init_game() {
	byte x, y;
	byte *ip;
	register char *p;

	for (x = 0; x < INV_X_COUNT; x++)
		for (y = 0; y < INV_Y_COUNT; y++)
			invaders_alive[x][y] = 1;
	
	inv_x_first = 0;
	inv_x_last = INV_X_COUNT - 1;

	inv_pos_x = 1;
	inv_pos_y = 3;
	inv_dir = 1;
	inv_look = 0;
	inv_count = INV_X_COUNT * INV_Y_COUNT;

	tank_pos = 38;

	ip = &tank[0][0];

	for (y = 0; y < 8; y++)
	{
		for (x = 0; x < 7; x++)
		{
			if (*ip == 1)
			{
				SET_PIXEL(x, y);
			}
			ip++;
		}
	}

	ip = &tank_char[0][0];
	for (y = 0; y < 2; y++)
	{
		for (x = 0; x < 4; x++)
		{
			*ip = V_GETCHAR_BUF(x, y);
			ip++;
			V_SETCHAR_BUF(x, y, 0);
		}
	}
}
/******************************************************************************/
void move_invaders() {
	if (inv_dir == 1)
	{
		if (inv_pos_x < 80 - (inv_x_last - inv_x_first + 1) * 6)
			inv_pos_x++;
		else
		{
			inv_dir = -1;
			inv_pos_y++;
		}
	}
	else
	{
		if (inv_pos_x > 1)
			inv_pos_x--;
		else
		{
			inv_dir = 1;
			inv_pos_y++;
		}
	}
	inv_look = 1 - inv_look;
}
/******************************************************************************/
void invaders_shot()
{
	register char *p;
	byte i;

	if (inv_shot_y > 0)
	{
		SET_PIXEL(inv_shot_x, inv_shot_y);
		SET_PIXEL(inv_shot_x, inv_shot_y - 1);
		inv_shot_y += 3;
		if (inv_shot_y >= 100)
			inv_shot_y = 0;
	}
	else
	{
		if (tank_pos >= inv_pos_x && tank_pos < inv_pos_x + 6 * (inv_x_last - inv_x_first + 1))
		{
			i = inv_x_first + (tank_pos - inv_pos_x) / 6;
			if (invaders_alive[i][2])
			{
				inv_shot_y = inv_pos_y * 3 + 30;
				inv_shot_x = inv_pos_x * 2 + (i - inv_x_first) * 12 + 6;
			}
			else if (invaders_alive[i][1])
			{
				inv_shot_y = inv_pos_y * 3 + 20;
				inv_shot_x = inv_pos_x * 2 + (i - inv_x_first) * 12 + 6;
			}
			else if (invaders_alive[i][0])
			{
				inv_shot_y = inv_pos_y * 3 + 10;
				inv_shot_x = inv_pos_x * 2 + (i - inv_x_first) * 12 + 6;
			}

		}
	}
}
/******************************************************************************/
void tank_shot()
{
	register char *p;
	byte x, y, i;

	if (shot_y > 0)
	{
		SET_PIXEL(shot_x, shot_y);
		SET_PIXEL(shot_x, shot_y + 1);
		if (shot_y > 3)
		{
			shot_y -= 3;

			// test if an invader was hit
			if (getpixel(shot_x, shot_y))
			{
				x = (shot_x - inv_pos_x * 2) / 12 + inv_x_first;
				y = (shot_y - inv_pos_y * 3) / 10;

				if (y < 3 && x >= inv_x_first && x <= inv_x_last)
				{
					invaders_alive[x][y] = 0;
					inv_count--;

					if (x == inv_x_first)
					{
						i = inv_x_first;
						while (!invaders_alive[i][0] && !invaders_alive[i][1] && !invaders_alive[i][2] && i < INV_X_COUNT)
							i++;
						inv_pos_x += 6 * (i - inv_x_first);
						inv_x_first = i;
					}
					else if (x == inv_x_last)
					{
						i = inv_x_last;
						while (!invaders_alive[i][0] && !invaders_alive[i][1] && !invaders_alive[i][2] && i > 0)
							i--;
						inv_x_last = i;
					}
				}
				shot_y = 0;
			}
		}
		else
			shot_y = 0;
	}
}
/******************************************************************************/
void draw_invaders()
{
	byte x, y;

	for (x = 0; x <= inv_x_last - inv_x_first; x++)
	{
		for (y = 0; y < INV_Y_COUNT; y++)
		{
			if (invaders_alive[inv_x_first + x][y])
				draw_invader(inv_pos_x * 2 + x * 12, inv_pos_y * 3 + y * 10, y);
		}
	}
}
/******************************************************************************/
void draw_invader(byte xpos, byte ypos, byte no) {
	register char *p;
	register byte *ip;
	byte x, y;

	ip = &invader[no * 2 + inv_look][0][0];

	for (y = ypos; y < ypos + 9; y++)
	{
		for (x = xpos; x < xpos + 10; x++)
		{
			if (*ip == 1)
			{
				SET_PIXEL(x, y);
			}
			ip++;
		}
	}
}
/******************************************************************************/
void draw_tank(byte pos) {
	register byte *ip;
	byte x, y;

	ip = &tank_char[0][0];
	for (y = 23; y < 25; y++)
	{
		for (x = pos; x < pos + 4; x++)
		{
			V_SETCHAR_BUF(x, y, *ip);
			ip++;
		}
	}

}
/******************************************************************************/

