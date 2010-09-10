#include "io.h"
#include "video.h"
#include "defs.h"
#include "utils.h"

/* code:  0x0290-0x1fff
 * data:  0x2000-0x21ff
 * stack: 0x2200-0x23ff
 * free:  0x2400-0xffff
 */

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
	byte i, j;
	word n;
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
				
			case '1':

				put_line(" TESTING BANK 0+1", 12);
				p = (void *)0x2400;
				while (p > 0) {
					if (((word)p & 1023) == 0) {
						itoa((word)p >> 10, s);
						put_line(s, 14);
					}

					for (i = 0; i < 8; i++) {
						*p = 170;
						if (*p != 170) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
						*p = 85;
						if (*p != 85) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
					}
					p++;
				}

				SELECT_BANK1;
				put_line(" TESTING BANK 2", 12);
				p = (void *)0x8000;
				while (p > 0) {
					if (((word)p & 1023) == 0) {
						itoa((word)p >> 10, s);
						put_line(s, 14);
					}

					for (i = 0; i < 8; i++) {
						*p = 170;
						if (*p != 170) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
						*p = 85;
						if (*p != 85) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
					}
					p++;
				}

				SELECT_BANK2;
				put_line(" TESTING BANK 3", 12);
				p = (void *)0x8000;
				while (p > 0) {
					if (((word)p & 1023) == 0) {
						itoa((word)p >> 10, s);
						put_line(s, 14);
					}

					for (i = 0; i < 8; i++) {
						*p = 170;
						if (*p != 170) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
						*p = 85;
						if (*p != 85) {
							put_line("ERROR! PRESS ANY KEY TO CONTINUE", 16);
							getchar();
							put_line("", 16);
						}
					}
					p++;
				}

				SELECT_BANK0;
				put_line("FINISHED! PRESS ANY KEY TO CONTINUE", 22);
				getchar();
				break;

			case '2':
				break;

			case '3':
				break;

			case '4':
				break;
		}
	}
	return;
}
/******************************************************************************/

