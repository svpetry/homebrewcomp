#ifndef STD_UTILS_H_
#define STD_UTILS_H_

#include "defs.h"
#include "video.h"

byte strlen(char s[]);
char *strcpy(char *target, const char *source);
byte strcmp(const char* a, const char* b);
char tolower(char c);
word atoi(char const* str);
void memcpy(byte *dest, byte *src, word size);
void memset(char *p, char c, word l);
void puts(char *s);

#endif /* STD_UTILS_H_ */
