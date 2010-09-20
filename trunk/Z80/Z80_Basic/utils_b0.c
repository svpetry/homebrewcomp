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
/*
void memset_f(byte *dest, char value, word size) {
	m_dest = dest;
	m_value = value;
	m_size = size;
	_asm
		ld hl, (_m_dest)
		ld de, (_m_dest)
		inc de
		ld bc, (_m_size)
		dec bc
		ld hl, (_m_value)
		ldir
	_endasm;
}
*/
/******************************************************************************/
byte iswhite(char c) {
	return c == ' ' || c == '\t';
}
/******************************************************************************/
byte isletter(char c) {
	return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}
/******************************************************************************/
byte isnum(char c) {
	return c >= '0' && c <= '9' || c == '.';
}
/******************************************************************************/

