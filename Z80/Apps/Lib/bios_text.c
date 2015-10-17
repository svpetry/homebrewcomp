#include "defs.h"
#include "bios_text.h"

/******************************************************************************/
void clrscr() {
	bios_cmd = 0x01; // clear screen
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void showcursor() {
	bios_p1 = 1;
	bios_cmd = 0x02; // cursor control
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void hidecursor() {
	bios_p1 = 0;
	bios_cmd = 0x02; // cursor control
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void cursorpos(byte col, byte row) {
	bios_p1 = col;
	bios_p2 = row;
	bios_cmd = 0x03; // set cursor position
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void scrollup() {
	bios_cmd = 0x06; // scroll one line up
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void settextdim(byte offs, byte rows) {
	clrscr();
	bios_p1 = offs;
	bios_p2 = rows;
	bios_cmd = 0x07; // set text window dimensions
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void putchar(char c) {
	bios_p1 = c;
	bios_cmd = 0x04; // put char
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
char getchar(void) {
	bios_cmd = 0x10; // get char from keyboard
	__asm
		rst 0x0010
	__endasm;
	return bios_p1;
}
/******************************************************************************/
void puts(char *s) {
	bios_p1 = (word)s;
	bios_cmd = 0x05; // write text
	__asm
		rst 0x0010
	__endasm;

	bios_p1 = '\n';
	bios_cmd = 0x04; // write character
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/
void puts_nlb(char *s) {
	bios_p1 = (word)s;
	bios_cmd = 0x05; // write text
	__asm
		rst 0x0010
	__endasm;
}
/******************************************************************************/