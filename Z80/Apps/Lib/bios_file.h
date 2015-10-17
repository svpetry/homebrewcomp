#ifndef BIOS_FILE_H_
#define BIOS_FILE_H_

#include "defs.h"

#define FM_READ 0
#define FM_WRITE 1
#define FM_APPEND 2

#define DIR_FIRST 0
#define DIR_NEXT 1

struct dir_entry {
	char name[16];
	dword size;
	byte attr;
};

byte initdrive();
byte getvolname(char *name);
byte readdir(struct dir_entry *entry, byte read_next);
byte fexists(char *name);
byte fdelete(char *name);
byte fopen(char *name, byte mode, dword *size);
byte freadblock();
byte fwriteblock(word size);

#endif /* BIOS_FILE_H_ */
