#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "utils.h"
#include "video.h"
#include "io.h"
#include "bios_cmd.h"

#pragma codeseg _CODE2

static char *m_dest;
static char *m_src;
static word m_size;
static char m_value;

/******************************************************************************/
void delay_ms(word ms) {
	word i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
}
/******************************************************************************/
void reverse(char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}
/******************************************************************************/
void itoa(int n, char s[])
{
	 int i, sign;

	 if ((sign = n) < 0)  /* record sign */
		 n = -n;          /* make n positive */
	 i = 0;
	 do {       /* generate digits in reverse order */
		 s[i++] = n % 10 + '0';   /* get next digit */
	 } while ((n /= 10) > 0);     /* delete it */
	 if (sign < 0)
		 s[i++] = '-';
	 s[i] = '\0';
	 reverse(s);
}
/******************************************************************************/
void ltoa(long i, char* buf)
{
	char reverse[14];
	char* s;
	char sign = i < 0;

	if (i < 0)
		i = -i;
	reverse[13] = 0;
	s = reverse + 13;
	do {
		*--s = "0123456789"[i % 10];
		i /= 10;
	} while (i);
	if (sign)
		*--s = '-';
	strcpy(buf, s);
}
/******************************************************************************/
void quit_app() {

	strcpy(sparam, "bios.bin");
	IO_WRITE(160, #29); // check if file exists
	while (busy);

//	if (!out_paramb)
//		show_message("waiting for bios.bin...");

	while (!out_paramb) {
    	delay_ms(1000);

		IO_WRITE(160, #0); // init mmc
		while (busy);

		if (io_read(161) == 0) { // check disk status
			IO_WRITE(160, #29); // check if file exists
			while (busy);
		}
	}

	DISABLE_VRAM;
	IO_WRITE(160, #27); // load program

	_asm
		halt
	_endasm;
}
/******************************************************************************/

