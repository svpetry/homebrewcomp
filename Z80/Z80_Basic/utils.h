#ifndef UTILS_H_
#define UTILS_H_

#include "defs.h"

void putn(int n);
void delay_ms(word ms);
void reverse(char s[]);
#ifndef _DEBUG
void itoa(int n, char s[]);
void ltoa(long i, char* buf);
#endif // _DEBUG
void quit_app(void);

#endif /* UTILS_H_ */
