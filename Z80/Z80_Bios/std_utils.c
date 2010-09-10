#include "std_utils.h"


/******************************************************************************/
byte strlen(char s[]) {
	char *sc;
	for (sc = s; *sc; sc++);
	return sc - s;
}
/******************************************************************************/
char *strcpy(char *target, const char *source)
{
	char *orig_target = target;

	while (*source)
		*target++ = *source++;
	*target = '\0';

	return orig_target;
}
/******************************************************************************/
byte strcmp(const char* a, const char* b)
{
	while (*a++ == *b++) {
		if (*a == '\0' && *b == '\0')
			return 0;
	}
	return -1;
}
/******************************************************************************/
char tolower(char c) {
	if (c >= 'A' && c <= 'Z')
		c = c - 'A' + 'a';
	return c;
}
/******************************************************************************/
word atoi(char const* str)
{
	char c;
	int result = 0;
	
	while (c = *str++)
		result = result * 10 + (c - '0');
	return result;
}
/******************************************************************************/
void memcpy(byte *dest, byte *src, word size) {
	while (size-- > 0)
		*(dest++) = *(src++);
}
/******************************************************************************/
void memset(char *p, char c, word l) {
	while (l > 0) {
		*(p++) = c;
		l--;
	}
}
/******************************************************************************/
void puts(char *s) {
	char *p = s;
	while (*p) {
		putchar(*p);
		p++;
	}
	putchar('\n');
}
/******************************************************************************/
