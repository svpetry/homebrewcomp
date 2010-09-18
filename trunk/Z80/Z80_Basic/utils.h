#ifndef UTILS_H_
#define UTILS_H_

#include "defs.h"

void delay_ms(word ms);
void reverse(char s[]);
void itoa(int n, char s[]);
void ltoa(long i, char* buf);
char tolower1(char c);
void strtolower(char *s);
void memcpy_f(byte *dest, byte *src, word size);
//void memset_f(byte *dest, char value, word size);
byte iswhite(char c);
byte isletter(char c);
byte isnum(char c);
void quit_app();

#endif /* UTILS_H_ */
