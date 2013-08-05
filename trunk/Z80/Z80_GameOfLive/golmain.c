#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "golmain.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "io.h"
#include "defs.h"

/******************************************************************************/
void start_gol()
{
	register byte x, y;
	byte max_x, max_y;
	byte start_x, start_y, end_x, end_y;
	byte ncount;
	byte p11, p12, p21, p22, p31, p32;

	p11 = 0; p12 = 0; p21 = 0; p22 = 0; p31 = 0; p32 = 0;


	if (prog_paramcount == 2)
	{
		max_x = atoi(prog_params[0]);
		max_y = atoi(prog_params[1]);
	}
	else if (prog_paramcount == 1)
	{
		max_x = atoi(prog_params[0]);
		max_y = max_x;
	}
	else
	{
		max_x = 60;
		max_y = 60;
	}

	start_x = (160 - max_x) / 2;
	end_x = start_x + max_x;
	start_y = (100 - max_y) / 2;
	end_y = start_y + max_y;

	clrbuf();

	vputs(10, 10, "PLEASE WAIT");
	buf2screen();

	clrbuf();

	for (y = start_y; y < end_y; y++)
	{
		for (x = start_x; x < end_x; x++)
		{
			if ((rand() % 2) == 0)
				setpixel(x, y);
		}
	}
	buf2screen();

	while (io_read(128) == 255) {

		clrbuf();

		for (y = start_y; y < end_y; y++)
		{
			for (x = start_x; x < end_x; x++)
			{
				ncount = 0;

				if (x > start_x)
				{
					ncount = p11 + p12 + p21 + p31 + p32;

					p11 = p12;
					p21 = p22;
					p31 = p32;

					if (getpixel(x + 1, y - 1))
					{
						p12 = 1;
						ncount++;
					}
					else
						p12 = 0;
					
					if (getpixel(x + 1, y))
					{
						p22 = 1;
						ncount++;
					}
					else
						p22 = 0;

					if (getpixel(x + 1, y + 1))
					{
						ncount++;
						p32 = 1;
					}
					else
						p32 = 0;

					if (p21)
					{
						if (ncount == 2 || ncount == 3)
							setpixel(x, y);
					}
					else
					{
						if (ncount == 3)
							setpixel(x, y);
					}

				} else {

					if (getpixel(x + 1, y - 1))
					{
						p12 = 1;
						ncount++;
					}
					else
						p12 = 0;
					
					if (getpixel(x + 1, y))
					{
						p22 = 1;
						ncount++;
					}
					else
						p22 = 0;

					if (getpixel(x + 1, y + 1))
					{
						ncount++;
						p32 = 1;
					}
					else
						p32 = 0;

					if (getpixel(x, y - 1))
					{
						ncount++;
						p11 = 1;
					}
					else
						p11 = 0;

					if (getpixel(x, y + 1))
					{
						ncount++;
						p31 = 1;
					}
					else
						p31 = 0;

					if (getpixel(x, y))
					{
						p21 = 1;
						if (ncount == 2 || ncount == 3)
							setpixel(x, y);
					}
					else
					{
						p21 = 0;
						if (ncount == 3)
							setpixel(x, y);
					}
				}


			}
		}

		buf2screen();
	}
}
/******************************************************************************/
