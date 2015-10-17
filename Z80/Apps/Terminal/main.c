#include <string.h>
#include <stdlib.h>

#include "main.h"
#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/utils.h"
#include "../Lib/textutils.h"
#include "../Lib/io.h"

/******************************************************************************/
void init_terminal() {
	settextdim(1, 24);
	memset((void *)0x1000, ' ' + 128, 80);
	write_inverse(0, 0, " F2: ECHO ON                                 F8: CLEAR SCREEN  F10: QUIT");
}
/******************************************************************************/
void start_terminal() {
	char c;
	byte echo = 1, cnt = 0;

	write_inverse(6, 30, " SELECT BAUD RATE   ");
	write_inverse(7, 30, " 1: 1200            ");
	write_inverse(8, 30, " 2: 2400            ");
	write_inverse(9, 30, " 3: 4800            ");
	write_inverse(10, 30, " 4: 9600            ");
	write_inverse(11, 30, " 5: 19200           ");
	write_inverse(12, 30, " 6: 38400           ");
	write_inverse(13, 30, " 7: 57600           ");
	write_inverse(14, 30, " 8: 115200          ");

	do
	{
		c = getchar();
	}
	while (!(c >= '1' && c <= '8'));

	// set baud rate
	io_write(170, c - '0');

	switch (c)
	{
		case '1':
			write_inverse(0, 20, "1200 BAUD");
			break;
		case '2':
			write_inverse(0, 20, "2400 BAUD");
			break;
		case '3':
			write_inverse(0, 20, "4800 BAUD");
			break;
		case '4':
			write_inverse(0, 20, "9600 BAUD");
			break;
		case '5':
			write_inverse(0, 20, "19200 BAUD");
			break;
		case '6':
			write_inverse(0, 20, "38400 BAUD");
			break;
		case '7':
			write_inverse(0, 20, "57600 BAUD");
			break;
		case '8':
			write_inverse(0, 20, "115200 BAUD");
			break;
	}
	
	clrscr();
	showcursor();

	while (1) {
		c = getchar();		

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
					clrscr();
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
				putchar(c);
		} // if (c == 0) else

		if (io_read(174))
		{
			hidecursor();
			do
			{
				c = io_read(173);
				if (c)
					putchar(c);
			} while (c);
			showcursor();
		}
	} // while (1)
} // start_terminal
/******************************************************************************/

