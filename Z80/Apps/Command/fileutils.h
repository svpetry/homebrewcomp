#ifndef FILEUTILS_H_
#define FILEUTILS_H_

#include "../Lib/defs.h"

void list_dir(char *wildcard);
byte matches(char *file_name, char *wildcard);
void dump_file(char *file_name);
void delete_file(char *file_name);

#endif /* FILEUTILS_H_ */
