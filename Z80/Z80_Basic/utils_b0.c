#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "utils_b0.h"

/******************************************************************************/
char tolower1(char c) {
	if (c >= 'A' && c <= 'Z')
		return c - 'A' + 'a';
	return c;
}
/******************************************************************************/
void strtolower(char *s) {
	while (*s) {
		*s = tolower1(*s);
		s++;
    }
}
/******************************************************************************/
byte iswhite(char c) {
	return c == ' ' || c == '\t' || c == '\r';
}
/******************************************************************************/
byte isletter(char c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}
/******************************************************************************/
byte isnum(char c) {
	return (c >= '0' && c <= '9') || c == '.';
}
/******************************************************************************/
