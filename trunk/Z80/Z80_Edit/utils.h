#ifndef UTILS_H_
#define UTILS_H_

#include "defs.h"

void delay_ms(word ms);
void reverse(char s[]);
void itoa(int n, char s[]);
void ltoa(long i, char* buf);
void strtolower(char *s);
void memcpy_f(byte *dest, byte *src, word size);

void quit_app();

#endif /* UTILS_H_ */
