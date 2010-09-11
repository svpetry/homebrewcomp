#include <string.h>

#include "io.h"
#include "video.h"
#include "defs.h"
#include "utils.h"

/* code:  0x0290-0x1fff
 * data:  0x2000-0x21ff
 * stack: 0x2200-0x23ff
 * free:  0x2400-0xffff
 */

const char scError[] = "ERROR! PRESS ANY KEY TO CONTINUE";
const char scFinished[] = "FINISHED! PRESS ANY KEY TO CONTINUE";
const word icBanks[] = {0x2400, 0x8000, 0x8000};
const char scTestBanks[][] = {" TESTING BANK 0+1", " TESTING BANK 2", " TESTING BANK 3"};

/******************************************************************************/
void init() {
	ENABLE_VRAM;
	v_cls();
	IO_WRITE(5, #0);
	IO_WRITE(6, #21);
}
/******************************************************************************/
void main() {
	char c;
	byte *p;
	byte i, j, k, l;
	char s[32];

    init();

	while (1) {
		v_cls();
		put_line(" 1: FULL RAM TEST", 6);
		put_line(" 2: RAM WRITE TEST", 7);
		put_line(" 3: RAM READ TEST", 8);
		put_line(" 4: VIDEO RAM TEST", 9);
		put_line(" 0: QUIT", 10);
		c = getchar();
		switch(c) {
			case '0':
				quit_app();
				break;
				
			case '1': // full ram test

				for (j = 0; j < 3; j++) {

					if (j == 1)
						SELECT_BANK1;
					else if (j == 2) {
						SELECT_BANK2;
					}

					put_line(scTestBanks[j], 12);
					p = (void *)icBanks[j];
					while (p > 0) {
						if (((word)p & 1023) == 0) {
							itoa((word)p >> 10, s);
							strcat(s, " kb");
							put_line(s, 14);
						}

						for (i = 0; i < 8; i++) {
							*p = 170;
							if (*p != 170) {
								put_line(scError, 16);
								getchar();
								put_line("", 16);
							}
							*p = 85;
							if (*p != 85) {
								put_line(scError, 16);
								getchar();
								put_line("", 16);
							}
						}
						p++;
					}
				}

				SELECT_BANK0;
				put_line(scFinished, 22);
				getchar();
				break;

			case '2': // ram write test
				for (j = 0; j < 3; j++) {

					if (j == 1)
						SELECT_BANK1;
					else if (j == 2) {
						SELECT_BANK2;
					}

					put_line(scTestBanks[j], 12);
					p = (void *)icBanks[j];
					while (p > 0) {
						if (((word)p & 1023) == 0) {
							itoa((word)p >> 10, s);
							strcat(s, " kb");
							put_line(s, 14);
						}

						for (i = 0; i < 16; i++) {
							*p = 255;
							*p = 170;
							*p = 85;
							*p = 0;
						}
						p++;
					}
				} // for (i = 0; i < 3; i++) {

				SELECT_BANK0;
				put_line(scFinished, 22);
				getchar();
				break;

			case '3': // ram read test
				for (j = 0; j < 3; j++) {

					if (j == 1)
						SELECT_BANK1;
					else if (j == 2) {
						SELECT_BANK2;
					}

					put_line(scTestBanks[j], 12);
					p = (void *)icBanks[j];
					while (p > 0) {
						if (((word)p & 1023) == 0) {
							itoa((word)p >> 10, s);
							strcat(s, " kb");
							put_line(s, 14);
						}

						for (i = 0; i < 64; i++) {
							k = *p;
						}
						p++;
					}
				} // for (i = 0; i < 3; i++) {

				SELECT_BANK0;
				put_line(scFinished, 22);
				getchar();
				break;

			case '4':
            	v_cls();
				for (k = 0; k < 26; k++)
					for (l = 0; l < 10; l++)
						for (i = 0; i < 25; i++)
							for (j = 0; j < 80; j += 2)
								V_SETCHAR(j, i, 'A' + k);
				break;
		}
	}
	return;
}
/******************************************************************************/

