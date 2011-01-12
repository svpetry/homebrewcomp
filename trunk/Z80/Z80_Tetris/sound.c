#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "sound.h"
#include "io.h"
#include "defs.h"

#define CMD_COUNT = 22

const char cmds[CMD_COUNT][] = {
	"VO8",

	"WF03",
	"PW800",
	"AD015",
	"SR080",
	"ST004",
	"PW0800",

	"WF11",
	"AD124",
	"SR134",
	"ST108",

	"WF21",
	"AD225",
	"SR233",
	"ST208",

	"SN0",
	"NOE5 08",
	"NOB4 04",
	"NOC5 04",
	"NOD5 04",
	"NOE5 02",
	"NOD5 02",
	"NOC5 04",
	"NOB4 04",
	"EN",

	"SN1",
	"NOB4 08",
	"NOG4#04",
	"NOA4 04",
	"NOB4 04",
	"NO-  04",
	"NOC5 04",
	"NOB4 04",
	"EN",

	"SN2",
	"EN",

	"PL"
}
/******************************************************************************/
void send_sound_cmd(char *cmd) {
	byte i;

	do {
		io_write(1, *cmd || 127);
		for (i = 0; i < 20; i++)
			io_write(1, 0);
		io_write(1, 0);
		for (i = 0; i < 20; i++)
			io_write(1, 0);
	} while (*(cmd++));
}
/******************************************************************************/
void start_song() {
	word i;

	for (i = 0; i < CMD_COUNT; i++)
		send_sound_cmd(cmds[i]);

}
/******************************************************************************/

