	;; Generic crt0.s for a Z80
	.module crt0
	.globl	_main
	.globl	_isr

	.area	_HEADER (ABS)
	;; Reset vector
	.org 	0
	jp	init

	.org	0x08
	reti
	.org	0x10
	reti
	.org	0x18
	reti
	.org	0x20
	reti
	.org	0x28
	reti
	.org	0x30
	reti
	.org	0x38
	reti

	.org	0x100
init:
	;; Stack at the top of memory.
	ld	sp,#0x7fff

	;; Initialize global variables
	call	_main
	halt

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE

	.area	_DATA
	.area   _BSS
	.area   _HEAP

	;; .area   _CODE
