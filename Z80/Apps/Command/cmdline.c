#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "cmdline.h"
#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/bios_file.h"
#include "../Lib/utils.h"
#include "../Lib/io.h"
#include "fileutils.h"

char last_cmdbuf[CMDLINE_MAXLEN];
char cmdbuf[CMDLINE_MAXLEN];
char *params[MAX_PARAMS];
byte paramcount;

/******************************************************************************/
void splitparams() {
	char *p;

	p = cmdbuf;

	while (*p == ' ')
		p++;

	if (*p) {
		params[0] = p;
		paramcount = 1;

		while (*p) {
			if (*p == ' ' || !*p) {
				*(p++) = 0;
				while (*p == ' ')
					p++;
				if (*p) {
					if (paramcount < MAX_PARAMS) {
						params[paramcount] = p;
						paramcount++;
					} else
						break;
				}
			} else
				p++;
		}
	} else
    	paramcount = 0;
}
/******************************************************************************/
void cmdline(void) {
	const char *wrong_parameter_count = "Wrong parameter count!";
	const char *cmd_prompt = "CMD>";

	char c;
	byte pos = 0;

	memset(cmdbuf, 0, CMDLINE_MAXLEN);
	last_cmdbuf[0] = 0;
	puts_nlb(cmd_prompt);
	while (1) {
		c = getchar();

		if (c == 0) {
			// special key
			c = getchar();
			if (c == 'H') {
				while (pos > 0) {
					putchar(8); // backspace
					pos--;
				}
				strcpy(cmdbuf, last_cmdbuf);
				puts_nlb(cmdbuf);
				pos = strlen(cmdbuf);
			}

		} else if (c == 10) {
			putchar('\n');
			strcpy(last_cmdbuf, cmdbuf);
			strtolower(cmdbuf);
			splitparams();

			if (paramcount > 0) {

				// BEEP
				if (!strcmp(params[0], "beep")) {
					beep();

				// CLS
				} else if (!strcmp(params[0], "cls")) {
					clrscr();

				// COPY
				} else if (!strcmp(params[0], "copy")) {
					if (paramcount != 3) {
						puts(wrong_parameter_count);
					} else {

					}

				// DEL
				} else if (!strcmp(params[0], "del")) {
					if (paramcount != 2) {
						puts(wrong_parameter_count);
					} else {
						delete_file(params[1]);
					}

				// DIR
				} else if (!strcmp(params[0], "dir")) {
					if (paramcount == 0)
						*(params[1]) = 0;
					list_dir(params[1]);

				// GRAPHCIS
				} else if (!strcmp(params[0], "graphics")) {
					if (paramcount != 2) {
						puts(wrong_parameter_count);
					} else {
						if (params[1][0] == '1')
							io_write(7, 3);
						else
							io_write(7, 1);
						delay_ms(200);
					}

				// HELP
				} else if (!strcmp(params[0], "help")) {
					puts("\nBEEP");
					puts("CLS");
					puts("COPY [src] [dest]");
					puts("DEL [file]");
					puts("DIR");
					puts("GRAPHICS (0|1)");
					puts("HELP");
					puts("INITMMC");
					puts("IOWRITE [port] [value]");
					puts("SETCOLOR [bg] [fg]");
					puts("UPTIME");
					puts("TYPE [file]");

				// INITMMC
				} else if (!strcmp(params[0], "initmmc")) {
					if (initdrive())
						puts("\nok.");
					else
						puts("\nerror.");

				// IOWRITE
				} else if (!strcmp(params[0], "iowrite")) {
					if (paramcount == 3)
						io_write(atoi(params[1]), atoi(params[2]));
					else
						puts(wrong_parameter_count);

				// SETCOLOR
				} else if (!strcmp(params[0], "setcolor")) {
					if (paramcount == 3) {
						io_write(5, atoi(params[1]));
						io_write(6, atoi(params[2]));
					} else if (paramcount == 1) {
						io_write(5, 16);
						io_write(6, 53);
					} else
						puts(wrong_parameter_count);

				// UPTIME
				} else if (!strcmp(params[0], "uptime")) {
					show_time();

				// TYPE
				} else if (!strcmp(params[0], "type")) {
					if (paramcount == 2) {
						dump_file(params[1]);
					} else
						puts(wrong_parameter_count);

				// execute program
				} else {
					exec_program();
				}
			} else {
			}
			memset(cmdbuf, 0, CMDLINE_MAXLEN);
			pos = 0;
			putchar('\n');
			puts_nlb(cmd_prompt);
		} else if (c == 8) {
        	// Backspace
			if (pos > 0) {
				putchar(8); // backspace
				pos--;
				cmdbuf[pos] = 0;
			}
		} else {
			if (pos < CMDLINE_MAXLEN - 1) {
				putchar(c);
				cmdbuf[pos++] = c;
			} else
				beep();
		}
	}
}
/******************************************************************************/
void exec_program(void) {
	byte i;
	byte found;
	char s[16];

	strcpy(s, params[0]);
	found = fexists(s);

	if (!found) {
		strcat(s, ".bin");
		found = fexists(s);
	}

	if (found) {
		puts("\nloading...");
		prog_paramcount = paramcount - 1;
		for (i = 0; i < prog_paramcount; i++)
			strcpy(prog_params[i], params[i + 1]);

		bios_p1 = (word)s;
		bios_cmd = 0x28; // load and start program
		__asm
			rst 0x0010
		__endasm;
		puts("\ncould not load file!");
	} else
		puts("\nfile not found.");
}
/******************************************************************************/
void show_time(void) {
	unsigned long ticks;
	int n;
	char s[8];

	ticks = io_read(130) +
		((unsigned long)io_read(131) << 8) +
		((unsigned long)io_read(132) << 16) +
		((unsigned long)io_read(133) << 24);
	ticks /= 10;

	puts_nlb("\n    ");

	n = ticks / 3600;
	itoa(n, s);
	if (s[1] == 0)
		putchar('0');
	puts_nlb(s);
	ticks = ticks - n * 3600;

	putchar(':');

	n = ticks / 60;
	itoa(n, s);
	if (s[1] == 0)
		putchar('0');
	puts_nlb(s);
	ticks = ticks - n * 60;

	putchar(':');

	itoa(ticks, s);
	if (s[1] == 0)
		putchar('0');
	puts(s);
}
/******************************************************************************/

