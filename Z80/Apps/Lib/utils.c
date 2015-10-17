#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "utils.h"
#include "defs.h"
#include "bios_text.h"

char *m_dest;
char *m_src;
word m_size;
char m_value;

/******************************************************************************/
void beep(void) {
	IO_WRITE(4, #1);
	delay_ms(200);
	IO_WRITE(4, #0);
}
/******************************************************************************/
void delay_ms(word ms) {
	word i, j;
	for (i = 0; i < ms; i++) {
		for (j = 0; j < 650; j++);
	}
}
/******************************************************************************/
void reverse(char s[])
{
	int i, j;
	char c;

	for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}
/******************************************************************************/
void itoa(int n, char s[])
{
	 int i, sign;

	 if ((sign = n) < 0)  /* record sign */
		 n = -n;          /* make n positive */
	 i = 0;
	 do {       /* generate digits in reverse order */
		 s[i++] = n % 10 + '0';   /* get next digit */
	 } while ((n /= 10) > 0);     /* delete it */
	 if (sign < 0)
		 s[i++] = '-';
	 s[i] = '\0';
	 reverse(s);
}
/******************************************************************************/
void ltoa(long i, char* buf)
{
	char reverse[14];
	char* s;
	char sign = i < 0;

	if (i < 0)
		i = -i;
	reverse[13] = 0;
	s = reverse + 13;
	do {
		*--s = "0123456789"[i % 10];
		i /= 10;
	} while (i);
	if (sign)
		*--s = '-';
    strcpy(buf, s);
}
/******************************************************************************/
void strtolower(char *s) {
	while (*s) {
		*s = tolower(*s);
		s++;
    }
}
/******************************************************************************/
void quit_app(void) __naked {
	__asm
		rst 0
	__endasm;
}
/******************************************************************************/

