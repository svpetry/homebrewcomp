#include "bios_file.h"
#include "defs.h"

/******************************************************************************/
byte initdrive() {
	bios_cmd = 0x20; // init drive
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/
byte getvolname(char *name) {
	bios_p1 = (word)name;
	bios_cmd = 0x21; // read volume name
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/
byte readdir(struct dir_entry *entry, byte read_next) {
	bios_p1 = (word)entry;
	bios_p2 = read_next;
	bios_cmd = 0x22; // read directory
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/
byte fexists(char *name) {
	bios_p1 = (word)name;
	bios_cmd = 0x23; // check if file exists
	__asm
		rst 0x0010
	__endasm;
	return bios_p2;
}
/******************************************************************************/
byte fdelete(char *name) {
	bios_p1 = (word)name;
	bios_cmd = 0x24; // delete file
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/
byte fopen(char *name, byte mode, dword *size) {
	bios_p1 = (word)name;
	bios_p2 = mode;
	bios_cmd = 0x25; // open file
	__asm
		rst 0x0010
	__endasm;
	if (mode == FM_READ)
		*size = bios_p1 + ((dword)bios_p2 << 16);
	return bios_result_code;
}
/******************************************************************************/
byte freadblock() {
	bios_cmd = 0x26; // read block
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/
byte fwriteblock(word size) {
	bios_p1 = size;
	bios_cmd = 0x27; // write block
	__asm
		rst 0x0010
	__endasm;
	return bios_result_code;
}
/******************************************************************************/