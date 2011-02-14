#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "sound.h"
#include "io.h"
#include "defs.h"

#define INIT_CMD_COUNT 15
#define SONG_CMD_COUNT 6

/******************************************************************************/
const char *init_cmds[INIT_CMD_COUNT] = {
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
	"ST208"
};

const char *song_cmds[SONG_CMD_COUNT] = {
	"SN0",
	"EN",

	"SN1",
	"EN",

	"SN2",
	"EN"
};
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

	for (i = 0; i < INIT_CMD_COUNT; i++)
		send_sound_cmd(init_cmds[i]);

	for (i = 0; i < SONG_CMD_COUNT; i++)
		send_sound_cmd(song_cmds[i]);

	send_sound_cmd("PL0");

}
/******************************************************************************/

