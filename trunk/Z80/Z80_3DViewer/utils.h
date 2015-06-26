#ifndef UTILS_H_
#define UTILS_H_

#include "defs.h"

void putn(int n);
void delay_ms(word ms);
void reverse(char s[]);
void itoa(int n, char s[]);
void ltoa(long i, char* buf);
void strtolower(char *s);

void quit_app(void);
void halt(void);

#endif /* UTILS_H_ */
