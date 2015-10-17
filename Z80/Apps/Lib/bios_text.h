#ifndef BIOS_TEXT_H_
#define BIOS_TEXT_H_

#include "defs.h"

void clrscr();
void showcursor();
void hidecursor();
void cursorpos(byte col, byte row);
void scrollup();
void settextdim(byte offs, byte rows);

void putchar(char c);
char getchar(void);
void puts(char *s);
void puts_nlb(char *s);

#endif /* BIOS_TEXT_H_ */
