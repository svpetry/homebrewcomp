#include <stdlib.h>
#include <string.h>

#include "../Lib/defs.h"
#include "../Lib/io.h"
#include "selftest.h"
#include "video.h"

#pragma codeseg _CODE2

/******************************************************************************/
void delay_ms(unsigned int ms) {
	unsigned int i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
}
/******************************************************************************/
void beep(void) {
	IO_WRITE(4, #1);
	delay_ms(200);
	IO_WRITE(4, #0);
}
/******************************************************************************/
void send_sound_cmd(char *cmd) {
	unsigned int i;

	do {
		io_write(1, *cmd | 128);
		for (i = 0; i < 5; i++);
		io_write(1, 0);
		for (i = 0; i < 5; i++);
	} while (*(cmd++));

	delay_ms(1);
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
void error(byte _beep_count) {
	byte i;
	for (i = 0; i < _beep_count; i++) {
		beep();
		delay_ms(500);
	}
	while (1);
}
/******************************************************************************/
void check_vram() {
	word i;
	byte *p;
	byte v1, v2;

	DISABLE_VRAM;

	p = (void *)VIDEO_RAM;
	v1 = 0;
	for (i = 0; i < VRAM_SIZE; i++)
		v1 ^= *(p++);

	ENABLE_VRAM;
	p = (void *)VIDEO_RAM;
	for (i = 0; i < V_ROWS; i++) {
		memset(p, 0xaa, V_COLS);
		p += 0x80;
	}

	p = (void *)VIDEO_RAM;
	v2 = 0;
	for (i = 0; i < VRAM_SIZE; i++)
		v2 ^= *(p++);
	if (v1 != v2)
		error(3);

	p = (void *)VIDEO_RAM;
	for (i = 0; i < V_ROWS; i++) {
		memset(p, 0x55, V_COLS);
		p += 0x80;
	}

	p = (void *)VIDEO_RAM;
	v2 = 0;
	for (i = 0; i < VRAM_SIZE; i++)
		v2 ^= *(p++);
	if (v1 != v2)
		error(3);

	p = (void *)VIDEO_RAM;
	for (i = 0; i < V_ROWS; i++) {
		memset(p, ' ', V_COLS);
		p += 0x80;
	}

}
/******************************************************************************/
void check_ram_area(byte *_start, word _size, word _display_offs_kb) {
	char s[16];
	register byte *p;
	word i;
	byte j, err;
	char *text_pos;

	text_pos = (char *)VIDEO_RAM + 3 * 0x80 + 9;

	p = _start;
	i = 0;
	err = 0;
	while (i < _size && !err) {

		if ((i & 1023) == 0) {
			itoa((i >> 10) + _display_offs_kb + 1, s);
			strcat(s, " K");
			strcpy(text_pos, s);
		}

		for (j = 0; j < 2; j++) {
			*p = 0x55;
			if (*p != 0x55)
				err = 1;
			*p = 0xaa;
			if (*p != 0xaa)
				err = 1;
		}

		i++;
		p++;
	}
	if (err) {
		strcpy(text_pos, "ERROR!");
		error(2);
	}
}
/******************************************************************************/
void check_ram(void) {
	strcpy((char *)VIDEO_RAM + 3 * 0x80, "    RAM:");
	check_ram_area((void *)0x2800, 0x5800, 10);
	check_ram_area((void *)0x8000, 0x8000, 32);
	SELECT_BANK1;
	check_ram_area((void *)0x8000, 0x8000, 64);
	SELECT_BANK2;
	check_ram_area((void *)0x8000, 0x8000, 96);
	SELECT_BANK3;
	check_ram_area((void *)0x8000, 0x8000, 128);
	SELECT_BANK0;
}
/******************************************************************************/
void check_timer(void) {
	byte i;
	word count;
	char *text_pos;

	text_pos = (char *)VIDEO_RAM + 4 * 0x80 + 9;
	strcpy((char *)VIDEO_RAM + 4 * 0x80, "  TIMER:");

	cur_col = 9;
	cur_row = 4;

	// enable cursor
	bios_p1 = 1;
	bios_cmd = 0x02; 
	__asm
		rst 0x0010
	__endasm;

	count = 60000;
	for (i = 0; i < 8 && count > 0; i++) {
		while (cur_blink_count != i && count > 0);
			count--;
	}

	// disable cursor
	bios_p1 = 0;
	bios_cmd = 0x02; 
	__asm
		rst 0x0010
	__endasm;

	if (count == 0) {
		strcpy(text_pos, "ERROR!");
		error(1);
	}
	strcpy(text_pos, "OK");
}
/******************************************************************************/
void check_keyboard(void) {
	char *text_pos;
	byte key;
	long error_count;
	long count;

	text_pos = (char *)VIDEO_RAM + 5 * 0x80 + 9;
	strcpy((char *)VIDEO_RAM + 5 * 0x80, " KEYBRD:");

	count = 10000;
	error_count = 100000;
	while (count > 0 && error_count > 0) {
		key = io_read(129);
		if (key > 0)
			count = 10000;
		count--;
		error_count--;
	}
	if (error_count == 0) {
		strcpy(text_pos, "ERROR!");
		error(1);
	}
	strcpy(text_pos, "OK");
}
/******************************************************************************/
void play_sound(void) {
	send_sound_cmd("VOf");

	send_sound_cmd("WF01");
	send_sound_cmd("AD012");
	send_sound_cmd("SR08c");
	send_sound_cmd("SD004");
	
	send_sound_cmd("WF11");
	send_sound_cmd("AD112");
	send_sound_cmd("SR18c");
	send_sound_cmd("SD104");

	send_sound_cmd("WF21");
	send_sound_cmd("AD212");
	send_sound_cmd("SR28c");
	send_sound_cmd("SD204");

	send_sound_cmd("SN0");
	send_sound_cmd("NOC5 40");
	send_sound_cmd("EN");

	send_sound_cmd("SN1");
	send_sound_cmd("NOF5 40");
	send_sound_cmd("EN");

	send_sound_cmd("SN2");
	send_sound_cmd("NOA5 40");
	send_sound_cmd("EN");

	send_sound_cmd("PL01");
}
/******************************************************************************/
void selftest(void) {
	char *p, *dest;

	check_vram();

	p = "   homebrewcomp Z80 BIOS   V1.0   2015                                          ";
	dest = (char *)VIDEO_RAM;
	while (*p)
		(*dest++) = (*p++) + 0x80;
	
	strcpy((char *)VIDEO_RAM + 2 * 0x80, "    CPU: Zilog Z84C0020PEC");

	check_ram();

	check_timer();

	check_keyboard();

	play_sound();

	delay_ms(2000);
}
/******************************************************************************/
