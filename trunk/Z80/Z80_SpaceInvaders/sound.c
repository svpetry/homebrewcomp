#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "sound.h"
#include "io.h"
#include "defs.h"

#define INIT_CMD_COUNT 16
#define SONG_CMD_COUNT 502

/******************************************************************************/
void send_sound_cmd(char *cmd) {
	word i;

	do {
		io_write(1, *cmd | 128);
		for (i = 0; i < 15; i++);
		io_write(1, 0);
		for (i = 0; i < 15; i++);
	} while (*(cmd++));

	for (i = 0; i < 350; i++);
}
/******************************************************************************/
void start_song() {


}
/******************************************************************************/

