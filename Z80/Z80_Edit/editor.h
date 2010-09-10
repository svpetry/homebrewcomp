#ifndef EDITOR_H_
#define EDITOR_H_

#include "defs.h"

#define MAX_LINE_LENGTH 120
#define LINE_HEADER_SIZE 5
#define NEW_LINE_SIZE 20

struct line_header {
	struct line_header *next, *prev;
	byte size;
	char line[MAX_LINE_LENGTH + 1];
};

void init_editor();
void start_editor();
void trim_line(struct line_header *line);
void display();
byte load_file();
void save_file();

#endif /* EDITOR_H_ */

