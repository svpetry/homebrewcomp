#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "io.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"

static byte io_val;
static word io_addr;
static volatile byte __at 0x0080 filebuf[0x200];

/******************************************************************************/
void puts_nlb(char *s) {
	char *p = s;
	while (*p) {
		putchar(*p);
		p++;
	}
}
/******************************************************************************/
char getchar(void) {
	byte result;
	byte cnt = 0;
	do
	{
		if (cnt == 0)
			v_showcursor();
		result = io_read(128);
		if (result == 255) {
			delay_ms(15);
			if (cnt == 20)
				v_hidecursor();
			if (++cnt == 40)
				cnt = 0;
		}
	} while (result == 255);
	v_hidecursor();
	return result;
}
/******************************************************************************/
void beep(void) {
	IO_WRITE(4, #1);
	delay_ms(200);
	IO_WRITE(4, #0);
}
/******************************************************************************/
byte io_read(byte addr) {
	io_addr = addr;
	__asm
		push af
		push bc
		ld bc, (_io_addr)
		in a, (c)
		ld (_io_val), a
		pop bc
		pop af
	__endasm;
	return io_val;
}
/******************************************************************************/
void io_write(byte addr, byte val) {
	io_addr = addr;
	io_val = val;
	__asm
		push af
		push bc
		ld a,(_io_val)
		ld bc,(_io_addr)
		out (c),a
		pop bc
		pop af
	__endasm;
}
/******************************************************************************/
void list_dir() {
	char s[12], c;
	byte i;

//	puts("\n directory listing");
	puts_nlb("\n volume name: ");
	io_write(160, 26); // get volume name
	while (busy);
	puts(sparam);
	for (i = 0; i < 42; i++)
		putchar('-');
	putchar('\n');

	io_write(160, 10);
	while (busy);
	while (sparam[0]) {
		// output:
		// sparam: filename
		// param1w + param2: file size (dword)
		// outparam: attributes (only 1st byte), 'RHSVDA' (R = bit0)

		if ((out_paramb & 0x08) == 0) {
			putchar(' ');
			puts_nlb(sparam);

			ltoa((long)param1l, s);
			cur_col = 26 - strlen(s);
			puts_nlb(s);
			puts_nlb(" Bytes    ");

			for (i = 0; i < 5; i++)
				s[i] = '-';
			if (out_paramb & 0x01)
				s[0] = 'R';
			if (out_paramb & 0x02)
				s[1] = 'H';
			if (out_paramb & 0x04)
				s[2] = 'S';
			if (out_paramb & 0x16)
				s[3] = 'D';
			if (out_paramb & 0x32)
				s[4] = 'A';
			s[5] = 0;
			puts(s);
		}
		io_write(160, 11);
		while (busy);

		c = io_read(128);
		if (c == 27)
        	break;
		else if (c == 0)
			c = io_read(128);
	}
	putchar('\n');
}
/******************************************************************************/
void dump_file(char *file_name) {
	char c;
	byte i;

	strcpy(sparam, file_name);
	io_write(160, 20); // open file for reading
	while (busy);
	if (out_paramb) {
		i = 0;
		while (param1l > 0) {
			putchar(io_read(163));
			param1l--;

			if (++i == 80) {
				i = 0;
				c = io_read(128);
				if (c == 27) {
					putchar('\n');
					return;
				}
			}
		}
		putchar('\n');
	}
}
/******************************************************************************/
void delete_file(char *file_name) {
	strcpy(sparam, file_name);

	io_write(160, 28);
	while (busy);
	if (out_paramb == 1)
		puts("ok.");
	else
		puts("file not found.");
}
/******************************************************************************/

