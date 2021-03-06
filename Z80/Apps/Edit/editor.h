#ifndef EDITOR_H_
#define EDITOR_H_

#include "../Lib/defs.h"

#define MAX_LINE_LENGTH 120
#define LINE_HEADER_SIZE 5
#define NEW_LINE_SIZE 20

struct line_header {
	struct line_header *next, *prev;
	byte size;
	char line[MAX_LINE_LENGTH + 1];
};

void init_editor();
void init_empty_file();
void init_line_base();
void start_lineedit();
void finish_lineedit();
void start_editor();
void trim_line(struct line_header *line, byte use_line_buf);
void show_status();
void display();
void load_file();
void save_file();
void prompt_load_file();
byte prompt_file_name();
void send_to_soundcard();
void stop_sound();

#endif /* EDITOR_H_ */

