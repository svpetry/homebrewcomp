#include <string.h>
#include <stdlib.h>

#include "sound.h"
#include "io.h"

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

