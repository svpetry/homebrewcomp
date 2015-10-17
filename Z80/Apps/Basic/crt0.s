	;; Generic crt0.s for a Z80
        .module crt0
       	.globl	_main

	.area	_HEADER (ABS)

	.org	0x1280
init:
	ld	sp,#0x8000
        
	call	_main
	rst	0

	.area	_HOME
	.area	_CODE
	.area	_DATA
	
	.area	_CODE2

