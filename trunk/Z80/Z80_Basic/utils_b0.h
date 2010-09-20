#ifndef UTILS_B0_H_
#define UTILS_B0_H_

#include "defs.h"

char tolower1(char c);
void strtolower(char *s);
void memcpy_f(byte *dest, byte *src, word size);
//void memset_f(byte *dest, char value, word size);
byte iswhite(char c);
byte isletter(char c);
byte isnum(char c);

#endif /* UTILS_B0_H_ */
