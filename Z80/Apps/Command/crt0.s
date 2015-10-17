	;; Generic crt0.s for a Z80
	.module crt0
	.globl	_main
	.globl	_bios_cmd

	.area	_HEADER (ABS)

	.org	0x1280
init:
	;; Stack at the top of memory.
	ld	sp,#0x7800

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
