#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "main.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "malloc.h"
#include "io.h"

/******************************************************************************/
void init_terminal() {
	memset(0x1000, ' ' + 128, 80);
	write_inverse(0, 0, " F2: ECHO ON                                 F8: CLEAR SCREEN  F10: QUIT");
}
/******************************************************************************/
void start_terminal() {
	char c;
	byte echo = 1, cnt = 0;

	write_inverse(6, 30, " SELECT BAUD RATE   ");
	write_inverse(7, 30, " 1: 4800            ");
	write_inverse(8, 30, " 2: 9600            ");
	write_inverse(9, 30, " 3: 19200           ");
	write_inverse(10, 30, " 4: 38400           ");
	write_inverse(11, 30, " 5: 57600           ");
	write_inverse(12, 30, " 6: 115200          ");

	do
	{
		c = getchar_nc();
	} while (!(c >= '1' && c <= '6'));
	io_write(170, c - '0');
	switch (c)
	{
		case '1':
			write_inverse(0, 20, "4800 BAUD");
			break;
		case '2':
			write_inverse(0, 20, "9600 BAUD");
			break;
		case '3':
			write_inverse(0, 20, "19200 BAUD");
			break;
		case '4':
			write_inverse(0, 20, "38400 BAUD");
			break;
		case '5':
			write_inverse(0, 20, "57600 BAUD");
			break;
		case '6':
			write_inverse(0, 20, "115200 BAUD");
			break;
	}
	
	v_cls();

	while (1) {
		if (cnt == 0)
			v_showcursor();
		c = io_read(128);
		if (((byte)c) == 255)
		{
			delay_ms(15);
			if (cnt == CURSOR_DELAY)
				v_hidecursor();
			if (++cnt == CURSOR_DELAY << 1)
				cnt = 0;
		} // if (c == 255)
		else
		{
			v_hidecursor();
			cnt = 0;

			if (c == 0)
			{
				// special key
				c = getchar();
				switch (c)
				{
					case 60: // F2
						echo = 1 - echo;
						if (echo)
							write_inverse(0, 0, " F2: ECHO ON ");
						else
							write_inverse(0, 0, " F2: ECHO OFF");
						break;
					case 66: // F8
						v_cls();
						break;
					case 68: // F10
						quit_app();
						break;
				} // switch (c)

			} // if (c == 0)
			else
			{
				io_write(171, c);

				if (echo)
				{
					if (c == 8)
						v_backspace();
					else
						putchar(c);
				} // if (echo)
			} // if (c == 0) else
		} // if (c == 255) else

		if (io_read(174))
		{
			v_hidecursor();
			do
			{
				c = io_read(173);
				if (c)
					putchar(c);
			} while (c);
		}
	} // while (1)
} // start_editor
/******************************************************************************/

