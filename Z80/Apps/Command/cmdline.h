/*
 * cmdline.h
 *
 *  Created on: 09.06.2010
 *      Author: Sven
 */

#ifndef CMDLINE_H_
#define CMDLINE_H_

#include "../Lib/defs.h"

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
