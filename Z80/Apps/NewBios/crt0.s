	.module crt0
	.globl	_main
	.globl	_isr
	.globl	_nmi_isr

	.area	_HEADER (ABS)
	;; Reset vector
	.org 	0
	jp	init

	.org	0x08
	reti
	.org	0x10
	jp	_isr
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
	.org	0x66
	push	af
	ld      a, (0x0047)
	or	a, a
	jr	z, nmi_exit
	pop	af
	jp	_nmi_isr
nmi_exit:
	pop af
	retn

	.org	0x0a50
init:
	;; Stack
	ld	sp,#0x0280

	;; Initialize global variables
	call	_main
	rst	0

	;; Ordering of segments for the linker.
        .area	_HOME
        .area	_CODE
        .area	_DATA
	.area	_CODE2
