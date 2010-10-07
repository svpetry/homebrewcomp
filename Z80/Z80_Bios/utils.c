#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "utils.h"

static char *m_dest;
static char *m_src;
static word m_size;
static char m_value;

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
void memcpy_f(byte *dest, byte *src, word size) {
	while (size-- > 0)
		*(dest++) = *(src++);
/*
	m_dest = dest;
	m_src = src;
	m_size = size;
	_asm
		push de
		push hl
		push bc

		ld de, (_m_dest)
		ld hl, (_m_src)
		ld bc, (_m_size)

$lbl01:
		ld a, (hl)
		ld (de), a
		inc de
		inc hl
		dec bc
		jr NZ, $lbl01

		pop bc
		pop hl
		pop de
//		ldir
	_endasm;
*/
}
/******************************************************************************/

void memset_f(byte *dest, char value, word size) {
	register char *p;
	register unsigned int i;

	i = size;
	p = dest;
	while (i > 0) {
        *(p++) = value;
		i--;
    }


//	m_dest = dest;
//	m_value = value;
//	m_size = size;
//	_asm
//		ld hl, (_m_dest)
//		ld de, (_m_dest)
//		inc de
//		ld bc, (_m_size)
//		dec bc
//		ld hl, (_m_value)
//		ldir
//	_endasm;
}

/******************************************************************************/

