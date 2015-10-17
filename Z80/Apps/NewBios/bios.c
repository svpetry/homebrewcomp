#include <stdlib.h>
#include <string.h>

#include "../Lib/defs.h"
#include "../Lib/io.h"
#include "video.h"
#include "selftest.h"

#define USER_PROGRAM_ADDRESS 0x1280

/******************************************************************************/
void nmi_isr(void) __critical __interrupt {
	cur_blink_count++;
	if (cur_blink_count == 8) {
		cur_blink_count = 0;
		v_showcursor(1);
	} else if (cur_blink_count == 4)
		v_showcursor(0);
}
/******************************************************************************/
void isr(void) __interrupt {
	register byte i;
	register char *p;

	__asm
		ei
	__endasm;

	switch (bios_cmd) {

		// write character at cursor position
		case 0x04:
			__asm
				di
			__endasm;
			v_showcursor(0);
			putchar(bios_p1);
			goto reset_cursor;
			break;

		// set cursor position
		case 0x03:
			__asm
				di
			__endasm;
			v_showcursor(0);
			cur_col = bios_p1;
			cur_row = bios_p2;
			goto reset_cursor;
			break;

		// write text at cursor position
		case 0x05:
			__asm
				di
			__endasm;
			v_showcursor(0);
			p = (char *)bios_p1;
			while (*p)
				putchar(*(p++));
			goto reset_cursor;
			break;

		// scroll one line up
		case 0x06:
			__asm
				di
			__endasm;
			v_scrollup();
			break;

		// cursor visibility control
		case 0x02:
			__asm
				di
			__endasm;
			if (cur_enabled != bios_p1) {
				cur_enabled = bios_p1;
				v_showcursor(cur_enabled);
				cur_blink_count = 0;
			}
			break;

		// clear screen
		case 0x01:
			__asm
				di
			__endasm;
			p = (char *)VIDEO_RAM;
			for (i = 0; i < rows_total; i++) {
				if (i >= rows_offset)
					memset(p, ' ', V_COLS);
				p += V_ROWSIZE;
			}
			p = (char *)&linebuf[0][0];
			for (i = 0; i < rows_total; i++) {
				memset(p, ' ', V_COLS);
				p += V_COLS;
			}
			line_ptr = 0;
			cur_col = 0;
			cur_row = 0;
			goto reset_cursor;
			break;

		// set text window dimensions
		case 0x07:
			__asm
				di
			__endasm;
			rows_offset = bios_p1;
			rows_total = bios_p2;
			goto reset_cursor;
			break;

		// read character from keyboard
		case 0x10:
			do
			{
				i = io_read(128);
			} while (i == 255);
			bios_p1 = i;
			break;

		// init drive
		case 0x20:
			io_write(160, 0); // init mmc
			goto check_disk;
			break;

		// read volume name
		case 0x21:
			io_write(160, 26); // get volume name
			while (busy);
			strcpy((char *)bios_p1, sparam);
			goto check_disk;
			break;

		// read directory
		case 0x22:
			switch (bios_p2) {

				// read first dir entry
				case 0:
					io_write(160, 10);
					break;

				// read next dir entry
				case 1:
					io_write(160, 11);
					break;
			}

			while (busy);

			p = (char *)bios_p1;
			strcpy(p, sparam); // file name
			p += 16;
			memcpy(p, &param1l, 4); // size
			p += 4;
			*p = out_paramb; // attributes

			goto check_disk;
			break;

		// check if file exists
		case 0x23:
			strcpy(sparam, (char *)bios_p1);
			io_write(160, 29); // check if file exists
			while (busy);
			bios_p2 = out_paramb;
			goto check_disk;
			break;

		// delete file
		case 0x24:
			strcpy(sparam, (char *)bios_p1);
			io_write(160, 28); // delete file
			goto check_disk;
			break;

		// open file
		case 0x25:
			strcpy(sparam, (char *)bios_p1);
			
			switch (bios_p2) {
				// read
				case 0:
					io_write(160, 20);
					while (busy);
					bios_p1 = param1w;
					bios_p2 = param2;
					break;

				// write new
				case 1:
					io_write(160, 21);
					break;

				// append
				case 2:
					io_write(160, 22);
					break;

				// unknown
				default:
					bios_result_code = 0;
					goto end;
					break;
			}
			goto check_disk;
			break;

		// read block
		case 0x26:
			io_write(160, 23);
			goto check_disk;
			break;

		// write block
		case 0x27:
			param1w = bios_p1;
			io_write(160, 24);
			goto check_disk;
			break;

		// load and start program
		case 0x28:
			DISABLE_VRAM;
			strcpy(sparam, (char *)bios_p1);
			param1w = USER_PROGRAM_ADDRESS;
			//io_write(160, 25);
			__asm
				ld	a, #25
				out	(#160), a
			__endasm;

			while (busy);
			//bios_result_code = io_read(161);
			__asm
				ld	bc, #161
				in	a, (c)
				ld	iy, #_bios_result_code
				ld	0 (iy), a
			__endasm;

			if (bios_result_code == 1) {
				// enable VRAM and jump to program start address
				__asm
					ld	a, #1
					out	(#7), a
					jp	USER_PROGRAM_ADDRESS
				__endasm;
			}
			
			ENABLE_VRAM;
			break;
	}
	goto end;

reset_cursor:
	if (cur_enabled)
	{
		cur_blink_count = 0;
		v_showcursor(1);
	}
	goto end;

check_disk:
	while (busy);
	bios_result_code = io_read(161);
end:
	__asm
		ei
	__endasm;
}
/******************************************************************************/
main() {
	const char *command_file = "command.bin";
	const char *error_msg = "no command.bin\n";

	byte i;

	__asm
		ld a, #1
		out (0), a // activate RAM bank 0
		out (7), a // enable VRAM & activate textmode

		xor a, a
		out (1), a // ext. Port = 0
		out (2), a // ext. Port = 0
		out (3), a // LED off
		out (4), a // PC Speaker off
		ld a, #16
		out (5), a // Background color
		ld a, #53
		out (6), a // Foreground color
	__endasm;
	
	cur_enabled = 0;
	rows_offset = 0;
	rows_total = V_ROWS;

	bios_cmd = 0x01; // clear screen
	__asm
		rst 0x0010
	__endasm;

//	if (*((byte *)0x2000) == 0xdd)
//		selftest();


	bios_cmd = 0x01; // clear screen
	__asm
		rst 0x0010
	__endasm;

	bios_cmd = 0x02; // show cursor
	bios_p1 = 1;
	__asm
		rst 0x0010
	__endasm;
	
	while (1) {

		for (i = 0; i < 3; i++) {
			bios_p1 = (word)command_file;
			bios_cmd = 0x28; // load and start program
			__asm
				rst 0x0010
			__endasm;
			delay_ms(500);
		}

		bios_p1 = (word)error_msg;
		bios_cmd = 0x05; // write text
		__asm
			rst 0x0010
		__endasm;

		bios_cmd = 0x10; // read character from keyboard
		__asm
			rst 0x0010
		__endasm;
	}
}
