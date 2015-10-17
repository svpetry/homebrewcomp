#ifndef CMDLINE_H_
#define CMDLINE_H_

#include "defs.h"

#define MAX_PARAMS 8
#define CMDLINE_MAXLEN 64

extern const char CMD_PROMPT[];
extern char last_cmdbuf[CMDLINE_MAXLEN];
extern char cmdbuf[CMDLINE_MAXLEN];
extern char *params[MAX_PARAMS];
extern byte paramcount;

void splitparams();
void cmdline(void);
void exec_program(void);
void show_time(void);

#endif /* CMDLINE_H_ */
