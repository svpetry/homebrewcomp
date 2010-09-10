;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (MINGW32)
; This file was generated Fri Sep 10 23:01:12 2010
;--------------------------------------------------------
	.module video
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _v_cls
	.globl _put_line
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;video.c:10: void v_cls() {
;	genLabel
;	genFunction
;	---------------------------------
; Function v_cls
; ---------------------------------
_v_cls_start::
_v_cls:
;video.c:11: memset(VIDEO_RAM, ' ', VRAM_SIZE);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0C80
	push	hl
;	genIpush
	ld	a,#0x20
	push	af
	inc	sp
;	genIpush
	ld	hl,#0x1000
	push	hl
;	genCall
	call	_memset
	pop	af
	pop	af
	inc	sp
;	genLabel
; peephole z12 removed unused label 00101$.
;	genEndFunction
	ret
_v_cls_end::
;video.c:14: void put_line(char *s, byte row) {
;	genLabel
;	genFunction
;	---------------------------------
; Function put_line
; ---------------------------------
_put_line_start::
_put_line:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;video.c:18: p = (char *)(VIDEO_RAM + (row << 7));
;	genCast
;	AOP_STK for 
	ld	c,6 (ix)
	ld	b,#0x00
;	genLeftShift
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
;	genPlus
;	genPlusIncr
	ld	hl,#0x1000
	add	hl,bc
	ld	c,l
	ld	b,h
;	genCast
;video.c:20: while (*s && i < 80) {
;	genAssign
;	AOP_STK for 
;	AOP_STK for _put_line_sloc0_1_0
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;	genAssign
;	(registers are the same)
;	genAssign
	ld	e,#0x00
;	genLabel
00102$:
;	genPointerGet
;	AOP_STK for _put_line_sloc0_1_0
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	ld	d,(hl)
;	genIfx
	xor	a,a
	or	a,d
; peephole 19 removed redundant or after or.
	jr	Z,00114$
; peephole z15 changed absolute to relative conditional jump.
;	genCmpLt
	ld	a,e
	sub	a,#0x50
	jr	NC,00114$
; peephole z18 changed absolute to relative conditional jump.
;video.c:21: *(p++) = *(s++);
;	genAssign
	ld	a,d
;	genPlus
;	AOP_STK for _put_line_sloc0_1_0
;	genPlusIncr
	inc	-2 (ix)
	jr	NZ,00119$
; peephole z16 changed absolute to relative conditional jump.
	inc	-1 (ix)
00119$:
;	genAssign (pointer)
;	isBitvar = 0
	ld	(bc),a
;	genPlus
;	genPlusIncr
	inc	bc
;video.c:22: i++;
;	genPlus
;	genPlusIncr
; peephole -1 removed redundant load.
	inc	e
;	genGoto
	jr	00102$
; peephole z14 changed absolute to relative unconditional jump.
;video.c:24: while (i < 80) {
;	genLabel
00114$:
;	genAssign
;	(registers are the same)
;	genAssign
;	(registers are the same)
;	genLabel
00105$:
;	genCmpLt
	ld	a,e
	sub	a,#0x50
	jr	NC,00108$
; peephole z18 changed absolute to relative conditional jump.
;video.c:25: *(p++) = ' ';
;	genAssign (pointer)
;	isBitvar = 0
	ld	a,#0x20
	ld	(bc),a
;	genPlus
;	genPlusIncr
	inc	bc
;video.c:26: i++;
;	genPlus
;	genPlusIncr
; peephole -1 removed redundant load.
	inc	e
;	genGoto
	jr	00105$
; peephole z14 changed absolute to relative unconditional jump.
;	genLabel
00108$:
;	genEndFunction
	ld	sp,ix
	pop	ix
	ret
_put_line_end::
	.area _CODE
	.area _CABS
