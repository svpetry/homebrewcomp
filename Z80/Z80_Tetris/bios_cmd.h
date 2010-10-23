#include "defs.h"

#ifndef BIOS_CMD_H_
#define BIOS_CMD_H_

#define MAX_PARAMS 8
#define CMDLINE_MAXLEN 64

volatile dword __at 0x0040 sector; // Sektor bei Disk-Operationen
volatile byte  __at 0x0044 busy;

volatile byte  __at 0x0050 cmd;
volatile byte  __at 0x0051 param1b;
volatile word  __at 0x0051 param1w;
volatile dword __at 0x0051 param1l;
volatile word  __at 0x0053 param2;
volatile byte  __at 0x0055 out_paramb;
volatile word  __at 0x0055 out_paramw;

volatile char __at 0x0060 sparam[0x20];
volatile char __at 0x0080 disk_buffer[0x200];

volatile byte __at 0x0058 prog_paramcount;
volatile char __at 0x0080 prog_params[MAX_PARAMS - 1][CMDLINE_MAXLEN];

#endif /* BIOS_CMD_H_ */
