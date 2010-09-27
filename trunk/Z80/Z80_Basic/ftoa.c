#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ftoa.h"
#include "utils.h"

#pragma codeseg _CODE2

/******************************************************************************/
#ifndef _DEBUG

typedef union {
	long	L;
	float	F;
} LF_t;

/******************************************************************************/
char *ftoa(float f, char outbuf[]) {
	long mantissa, int_part, frac_part;
	short exp2;
	LF_t x;
	char *p;

//	*status = 0;
	if (f < 0.00001) {
		outbuf[0] = '0';
		outbuf[1] = '.';
		outbuf[2] = '0';
		outbuf[3] = 0;
		return outbuf;
	}

	f += 0.00001;
	
	x.F = f;

	exp2 = (unsigned char)(x.L >> 23) - 127;
	mantissa = (x.L & 0xFFFFFF) | 0x800000;
	frac_part = 0;
	int_part = 0;

	if (exp2 >= 31) {
//		*status = _FTOA_TOO_LARGE;
		return 0;
	} else if (exp2 < -23) {
//		*status = _FTOA_TOO_SMALL;
		return 0;
	} else if (exp2 >= 23)
		int_part = mantissa << (exp2 - 23);
	else if (exp2 >= 0) {
		int_part = mantissa >> (23 - exp2);
		frac_part = (mantissa << (exp2 + 1)) & 0xFFFFFF;
	} else /* if (exp2 < 0) */
		frac_part = (mantissa & 0xFFFFFF) >> -(exp2 + 1);

	p = outbuf;

	if (x.L < 0)
		*p++ = '-';

	if (int_part == 0)
		*p++ = '0';
	else {
		ltoa(int_part, p);
		while (*p)
			p++;
	}
	*p++ = '.';

	if (frac_part == 0)
		*p++ = '0';
	else {
		char m, max;

		max = BUFFER_MAX - (p - outbuf) - 1;
		if (max > 5)
			max = 5;
		/* print BCD */
		for (m = 0; m < max; m++) {
			/* frac_part *= 10;	*/
			frac_part = (frac_part << 3) + (frac_part << 1);

			*p++ = (frac_part >> 24) + '0';
			frac_part &= 0xFFFFFF;
		}
		/* delete ending zeroes */
		for (--p; *p == '0' && *(p - 1) != '.'; --p);
		++p;
	}
	*p = 0;

	return outbuf;
}
#endif // _DEBUG
/******************************************************************************/
