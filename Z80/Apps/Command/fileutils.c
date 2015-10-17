#include <stdlib.h>
#include <string.h>

#include "fileutils.h"
#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/bios_file.h"
#include "../Lib/utils.h"
#include "../Lib/io.h"

/******************************************************************************/
void list_dir(char *wildcard) {
	char s[16], c;
	byte i;
	char *p;
	struct dir_entry d_entry;

	p = wildcard;
	while (*p) {
		*p = (*p >= 'a' && *p <= 'z') ? (*p - 'a' + 'A') : *p;
		p++;
	}

	puts_nlb("\n volume name: ");
	getvolname(s);
	puts(s);
	for (i = 0; i < 42; i++)
		putchar('-');
	putchar('\n');

	readdir(&d_entry, DIR_FIRST);
	while (d_entry.name[0]) {

		// attributes: 'RHSVDA' (R = bit0)

		if (matches(d_entry.name, wildcard) && (d_entry.attr & 8) == 0) {
			putchar(' ');
			puts_nlb(d_entry.name);

			ltoa((long)d_entry.size, s);
			cursorpos(26 - strlen(s), cur_row);
			puts_nlb(s);
			puts_nlb(" Bytes    ");

			for (i = 0; i < 5; i++)
				s[i] = '-';
			if (d_entry.attr & 1)
				s[0] = 'R';
			if (d_entry.attr & 2)
				s[1] = 'H';
			if (d_entry.attr & 4)
				s[2] = 'S';
			if (d_entry.attr & 16)
				s[3] = 'D';
			if (d_entry.attr & 32)
				s[4] = 'A';
			s[5] = 0;
			puts(s);
		}
		readdir(&d_entry, DIR_NEXT);

		c = io_read(128);
		if (c == 27)
        	break;
		else if (c == 0)
			c = io_read(128);
	}
	putchar('\n');
}
/******************************************************************************/
byte matches(char *file_name, char *wildcard) {
	char *p1, *p2;

	if (wildcard[0] == '*' && wildcard[1] == '.') {
		p1 = file_name + strlen(file_name) - 1;
		p2 = wildcard + strlen(wildcard) - 1;
		while (*p1 != '.' || *p2 != '.') {
			if (*p1 != *p2)
				return 0;
			p1--;
			p2--;
		}
	}

	return 1;	
} // char matches(char *file_name, char *wildcard)
/******************************************************************************/
void dump_file(char *file_name) {
	char c;
	byte i;
	word buf_pos;
	dword size;

	if (fopen(file_name, FM_READ, &size)) {
		i = 0;
		while (size > 0) {
			freadblock();
			for (buf_pos = 0; buf_pos < 512 && size > 0; buf_pos++, size--) {
				putchar(disk_buffer[buf_pos]);
				if (++i == 80) {
					i = 0;
					c = io_read(128);
					if (c == 27) {
						putchar('\n');
						return;
					}
				}
			}
		}
		putchar('\n');
	} else
		puts("file not found.");
}
/******************************************************************************/
void delete_file(char *file_name) {
	if (fdelete(file_name))
		puts("ok.");
	else
		puts("file not found.");
}
/******************************************************************************/

