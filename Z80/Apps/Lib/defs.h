#ifndef _DEFS_H
#define _DEFS_H

typedef unsigned char byte;
typedef unsigned int word;
typedef unsigned long dword;

/******************************************************************************/

#define MAX_PARAMS 6
#define CMDLINE_MAXLEN 64

#define VIDEO_RAM 0x1000
#define VRAM_SIZE 0x0c80
#define VIDEO_BUFFER 0x0280
#define V_ROWS 25
#define V_COLS 80
#define V_ROWSIZE 128

/******************************************************************************/

// controller variables
volatile dword __at 0x0040 sector; // sector for disk operations
volatile byte  __at 0x0044 busy; // disk I/O busy flag

volatile byte  __at 0x0050 cmd;
volatile byte  __at 0x0051 param1b;
volatile word  __at 0x0051 param1w;
volatile dword __at 0x0051 param1l;
volatile word  __at 0x0053 param2;
volatile byte  __at 0x0055 out_paramb;
volatile word  __at 0x0055 out_paramw;
volatile char  __at 0x0080 sparam[0x20];

volatile char  __at 0x0080 disk_buffer[0x200];

// bios variables
volatile char  __at 0x0045 cur_col;
volatile char  __at 0x0046 cur_row;
volatile byte  __at 0x0047 cur_enabled;
volatile char  __at 0x0048 line_ptr;
volatile byte  __at 0x0049 cur_blink_count;
volatile byte  __at 0x004a rows_offset;
volatile byte  __at 0x004b rows_total;

volatile byte  __at VIDEO_BUFFER linebuf[V_ROWS][V_COLS];

volatile byte  __at 0x0060 bios_cmd;
volatile word  __at 0x0061 bios_p1;
volatile word  __at 0x0063 bios_p2;
volatile byte  __at 0x0065 bios_result_code; // 1 = ok, 0 = error

// application parameters
volatile byte  __at 0x0058 prog_paramcount;
volatile char  __at 0x0180 prog_params[MAX_PARAMS - 1][CMDLINE_MAXLEN];

/******************************************************************************/

#define IO_WRITE(addr, val) \
__asm \
	push af \
	ld a, val \
	out (addr), a \
	pop af \
__endasm

#define V_SETCHAR(col, row, c) *((char *)VIDEO_RAM + (row << 7) + col) = c

#define ENABLE_VRAM io_write(7, 1)
#define DISABLE_VRAM io_write(7, 0)
#define SELECT_BANK0 io_write(0, 1)
#define SELECT_BANK1 io_write(0, 2)
#define SELECT_BANK2 io_write(0, 4)
#define SELECT_BANK3 io_write(0, 8)

#endif // _DEFS_H
