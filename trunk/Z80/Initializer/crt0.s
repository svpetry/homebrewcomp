	;; Generic crt0.s for a Z80
	.module crt0
	.globl	_main

	.area	_HEADER (ABS)
	;; Reset vector
	.org 	0

	;; Stack at the top of memory.
	ld	sp,#0x2fff

	;; Initialize global variables
	jp	_main

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE

	.area	_DATA
	.area   _BSS
	.area   _HEAP

	;; .area   _CODE
