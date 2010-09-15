	;; Generic crt0.s for a Z80
        .module crt0
       	.globl	_main

	.area	_HEADER (ABS)

	.org	0x0280
init:
	ld	sp,#0x77ff
        
	call	gsinit
	call	_main
        halt

	.area	_HOME
	.area	_CODE
	.area	_GSINIT
gsinit::
	.area	_GSFINAL
	ret
	.area	_DATA
	
	.area	_CODE2

