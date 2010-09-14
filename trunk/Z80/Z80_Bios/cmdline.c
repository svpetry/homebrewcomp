#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "cmdline.h"
#include "defs.h"
#include "utils.h"
#include "video.h"
#include "io.h"
#include "bios_cmd.h"

const char *CMD_PROMPT = "CMD>";

char last_cmdbuf[CMDLINE_MAXLEN];
char cmdbuf[CMDLINE_MAXLEN];
char *params[MAX_PARAMS];
byte paramcount;

const char *scWrongParameterCount = "Wrong parameter count!";

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
	char c;
	byte pos = 0;

	memset(cmdbuf, 0, CMDLINE_MAXLEN);
	last_cmdbuf[0] = 0;
	puts_nlb(CMD_PROMPT);
	while (1) {
		c = getchar();
		if (c == 0) {
			// special key
			c = getchar();
			if (c == 'H') {
				while (pos > 0) {
					v_backspace();
					pos--;
				}
				strcpy(cmdbuf, last_cmdbuf);
				puts_nlb(cmdbuf);
				pos = strlen(cmdbuf);
			}

		} else if (c == '\n') {
			putchar('\n');
			strcpy(last_cmdbuf, cmdbuf);
			strtolower(cmdbuf);
			splitparams();

			if (paramcount > 0) {
				if (!strcmp(params[0], "beep")) {
					beep();
				} else if (!strcmp(params[0], "cls")) {
					v_cls();
				} else if (!strcmp(params[0], "copy")) {
					if (paramcount != 3) {
						puts(scWrongParameterCount);
					} else {

					}
				} else if (!strcmp(params[0], "del")) {
					if (paramcount != 2) {
						puts(scWrongParameterCount);
					} else {
                        delete_file(params[1]);
					}
				} else if (!strcmp(params[0], "dir")) {
					list_dir();
				} else if (!strcmp(params[0], "help")) {
					puts("\nBEEP");
					puts("CLS");
					puts("COPY [src] [dest]");
					puts("DEL [file]");
					puts("DIR");
					puts("HELP");
					puts("INITMMC");
					puts("SETCOLOR [bg] [fg]");
					puts("TYPE [file]");
				} else if (!strcmp(params[0], "initmmc")) {
					IO_WRITE(160, #0);
					while (busy);
					if (io_read(161))
						puts("\nok.");
					else
						puts("\nerror.");
				} else if (!strcmp(params[0], "setcolor")) {
					if (paramcount == 3) {
						io_write(5, atoi(params[1]));
						io_write(6, atoi(params[2]));
					} else if (paramcount == 1) {
						io_write(5, 16);
						io_write(6, 53);
					} else
						puts(scWrongParameterCount);
				} else if (!strcmp(params[0], "type")) {
					if (paramcount == 2) {
                    	dump_file(params[1]);
					} else
						puts(scWrongParameterCount);
				} else {
					// execute program
					exec_program();
				}
			} else {
			}
			memset(cmdbuf, 0, CMDLINE_MAXLEN);
			pos = 0;
			putchar('\n');
			puts_nlb(CMD_PROMPT);
		} else if (c == 8) {
        	// Backspace
			if (pos > 0) {
				v_backspace();
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
	byte l, i;
	byte found;
	char *s;

	strcpy(sparam, params[0]);
	IO_WRITE(160, #29); // check if file exists
	while (busy);

	if (!out_paramb) {
		strcat(sparam, ".bin");
		IO_WRITE(160, #29); // check if file exists
		while (busy);
	}

	if (out_paramb) {
		s = sparam;
		strtolower(s);
		l = strlen(s);
		found = 0;
		if (l > 4) {
			 if (s[l - 4] == '.' && s[l - 3] == 'b' && s[l - 2] == 'i' && s[l - 1] == 'n')
				found = 1;
		}

		if (found) {
			puts("\nloading...");
			prog_paramcount = paramcount - 1;
			for (i = 0; i < prog_paramcount; i++)
				strcpy(prog_params[i], params[i + 1]);
			DISABLE_VRAM;
			IO_WRITE(160, #27); // load program
			_asm
            	halt
			_endasm;
		} else
        	puts("\nno bin file.");
	} else
		puts("\nfile not found.");
}
/******************************************************************************/