#include <string.h>

static unsigned char io_val;
static unsigned int io_addr;

/******************************************************************************/
//unsigned char io_read(unsigned char addr) {
//	io_addr = addr;
//	_asm
//		push af
//		push bc
//		ld bc, (_io_addr)
//		in a, (c)
//		ld (_io_val), a
//		pop bc
//		pop af
//	_endasm;
//	return io_val;
//}
/******************************************************************************/
void io_write(unsigned char addr, unsigned char val) {
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
void delay_ms(unsigned int ms) {
	unsigned int i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
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
main() {

	__asm
		ld a, #1
		out (0), a // RAM-Bank 0 aktivieren
		out (7), a // enable VRAM & activate textmode
	__endasm;

	delay_ms(50);

	__asm
		xor a, a
		out (1), a // ext. Port = 0
		out (2), a // ext. Port = 0
		out (3), a // LED aus
		out (4), a // PC-Speaker aus
		ld a, #16
		out (5), a // Hintergrundfarbe
		ld a, #53
		out (6), a // Vordergrundfarbe
	__endasm;

	delay_ms(200);

	memset(0x1000, 32, 0x0C80);
	strcpy(0x1000, "Zilog Z84C0020PEC CPU, 131.072 Bytes RAM. Waiting for bios.bin...");

	delay_ms(300);

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

	__asm
		xor a, a
		out (7), a // disable VRAM

		halt
	__endasm;
	return 0;
}
