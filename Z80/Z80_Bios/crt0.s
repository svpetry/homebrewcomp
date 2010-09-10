	;; Generic crt0.s for a Z80
	.module crt0
	.globl	_main
	.globl	_bios_cmd
	.globl	_isr

	.area	_HEADER (ABS)
	;; Reset vector
	.org 	0
	jp	init

	.org	0x08
	reti
	.org	0x10
	jp	_bios_cmd
	.org	0x18
	reti
	.org	0x20
	reti
	.org	0x28
	reti
	.org	0x30
	reti
	.org	0x38
	jp	_isr

	.org	0x280
init:
	;; Stack at the top of memory.
	ld	sp,#0x77ff

	;; Initialize global variables
	call    gsinit
	call	_main
	halt

	;; Ordering of segments for the linker.
        .area	_HOME
        .area	_CODE
	.area	_GSINIT
	.area	_GSFINAL
        .area	_DATA

	.area	_GSINIT
gsinit::
	.area	_GSFINAL
	ret
