;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Mar 22 2009) (MINGW32)
; This file was generated Fri Aug 06 19:13:24 2010
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _delay_ms
	.globl _io_write
	.globl _io_read
	.globl _isr
	.globl _value
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_io_val:
	.ds 1
_io_addr:
	.ds 1
_value::
	.ds 1
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
;main.c:18: void isr (void) interrupt {
;	genLabel
;	genFunction
;	---------------------------------
; Function isr
; ---------------------------------
_isr_start::
_isr:
	push	af
	push	bc
	push	de
	push	hl
	push	iy
;main.c:20: }
;	genLabel
; peephole z12 removed unused label 00101$.
;	genEndFunction
	pop	iy
	pop	hl
	pop	de
	pop	bc
	pop	af
	reti
_isr_end::
;main.c:22: byte io_read(byte addr) {
;	genLabel
;	genFunction
;	---------------------------------
; Function io_read
; ---------------------------------
_io_read_start::
_io_read:
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:23: io_addr = addr;
;	genAssign
;	AOP_STK for 
	ld	a,4 (ix)
	ld	iy,#_io_addr
	ld	0 (iy),a
;main.c:32: _endasm;
;	genInline
	
		 push af
		 push bc
		 ld bc, (_io_addr)
		 in a, (c)
		 ld (_io_val), a
		 pop bc
		 pop af
		
;main.c:33: return io_val;
;	genRet
; Dump of IC_LEFT: type AOP_IY size 1
	ld	iy,#_io_val
	ld	l,0 (iy)
;	genLabel
; peephole z12 removed unused label 00101$.
;	genEndFunction
	pop	ix
	ret
_io_read_end::
;main.c:36: void io_write(byte addr, byte val) {
;	genLabel
;	genFunction
;	---------------------------------
; Function io_write
; ---------------------------------
_io_write_start::
_io_write:
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:37: io_addr = addr;
;	genAssign
;	AOP_STK for 
	ld	a,4 (ix)
	ld	iy,#_io_addr
	ld	0 (iy),a
;main.c:38: io_val = val;
;	genAssign
;	AOP_STK for 
	ld	a,5 (ix)
	ld	iy,#_io_val
	ld	0 (iy),a
;main.c:47: _endasm;
;	genInline
	
		 push af
		 push bc
		 ld a,(_io_val)
		 ld bc,(_io_addr)
		 out (c),a
		 pop bc
		 pop af
		
;	genLabel
; peephole z12 removed unused label 00101$.
;	genEndFunction
	pop	ix
	ret
_io_write_end::
;main.c:50: void delay_ms(int ms) {
;	genLabel
;	genFunction
;	---------------------------------
; Function delay_ms
; ---------------------------------
_delay_ms_start::
_delay_ms:
	push	ix
	ld	ix,#0
	add	ix,sp
;main.c:52: for (i = 0; i < ms; i++) {
;	genAssign
	ld	bc,#0x0000
;	genLabel
00104$:
;	genCmpLt
;	AOP_STK for 
	ld	a,c
	sub	a,4 (ix)
	ld	a,b
	sbc	a,5 (ix)
	jp	P,00108$
;main.c:53: for (j = 0; j < 650; j++);
;	genAssign
	ld	de,#0x028A
;	genLabel
00103$:
;	genMinus
	dec	de
;	genIfx
	ld	a,e
	or	a,d
; peephole 19 removed redundant or after or.
	jr	NZ,00103$
; peephole z16 changed absolute to relative conditional jump.
;main.c:52: for (i = 0; i < ms; i++) {
;	genPlus
;	genPlusIncr
	inc	bc
;	genGoto
	jr	00104$
; peephole z14 changed absolute to relative unconditional jump.
;	genLabel
00108$:
;	genEndFunction
	pop	ix
	ret
_delay_ms_end::
;main.c:59: main() {
;	genLabel
;	genFunction
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
;main.c:62: value = 0;
;	genAssign
	ld	iy,#_value
	ld	0 (iy),#0x00
;main.c:63: while (1) {
;	genLabel
00102$:
;main.c:64: io_write(0, value);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	a,(_value)
	push	af
	inc	sp
;	genIpush
	ld	a,#0x00
	push	af
	inc	sp
;	genCall
	call	_io_write
	pop	af
;main.c:67: delay_ms(20);
;	genIpush
; _saveRegsForCall: sendSetSize: 0 deInUse: 0 bcInUse: 0 deSending: 0
	ld	hl,#0x0014
	push	hl
;	genCall
	call	_delay_ms
	pop	af
;	genGoto
;main.c:71: return 0;
;	genLabel
; peephole z12 removed unused label 00104$.
;	genEndFunction
	jr	00102$
; peephole z14 changed absolute to relative unconditional jump.
; peephole z13 removed unused ret.
_main_end::
	.area _CODE
	.area _CABS
