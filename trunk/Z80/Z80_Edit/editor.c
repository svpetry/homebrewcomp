#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "editor.h"
#include "video.h"
#include "utils.h"
#include "bios_cmd.h"
#include "malloc.h"
#include "io.h"

static char line_buf[MAX_LINE_LENGTH + 1];
static char file_name[13];

static struct line_header *line_base;
static struct line_header *start_line; // 1st line of visible screen area
static struct line_header *curr_line; // cursor line

static byte edit_active = 0;

/******************************************************************************/
void init_editor() {
	memset(0x1000, ' ' + 128, 80);
	memset(0x1c00, ' ' + 128, 80);
	write_inverse(0, 0, " F2: SAVE   F8: DELETE   F10: QUIT");

	if (prog_paramcount) {
		strcpy(file_name, prog_params[0]);
		if (!load_file()) {
			quit_app();
		}
	} else {
		strcpy(file_name, "<new file>");
	}
	write_inverse(24, 1, file_name);
}
/******************************************************************************/
void start_editor() {
	char c, *s, *d;
	byte i;
	int l;
	struct line_header *line1, *line2;

	start_line = curr_line = line_base->next;
	display();

	while (1) {
		c = getchar();

		if (c == 0) {
        	// special key
			c = getchar();
			switch (c) {
				case 59: // F1
					break;
				case 60: // F2
                	save_file();
					break;
				case 61: // F3
					break;
				case 62: // F4
					break;
				case 63: // F5
					break;
				case 64: // F6
					break;
				case 65: // F7
					break;
				case 66: // F8
					line1 = curr_line;
					if (curr_line->next != NULL) {
						curr_line->prev->next = curr_line->next;
						curr_line->next->prev = curr_line->prev;
						if (start_line == curr_line)
							start_line = curr_line->next;
						curr_line = curr_line->next;
						free(line1);
					} else
						curr_line->line[0] = 0;
					display();
					break;
				case 67: // F9
					break;
				case 68: // F10
                	quit_app();
					break;
					
				case 72: // up
					if (cur_row > 0) {
						cur_row--;
						curr_line = curr_line->prev;
					} else {
						if (curr_line->prev != line_base) {
							cur_row--;
							v_scrolldown();
							start_line = curr_line = curr_line->prev;
							put_line(start_line->line, 0);
						}
					}
					break;
				case 80: // down
					if (curr_line->next != NULL) {
						if (cur_row < V_ROWS - 1) {
							cur_row++;
							curr_line = curr_line->next;
						} else {
							cur_row++;
							v_scrollup();
							start_line = start_line->next;
							curr_line = curr_line->next;
							put_line(curr_line->line, V_ROWS - 1);
						}
					}
					break;
				case 77: // left
					if (cur_col < V_COLS - 1) {
						cur_col++;
					}
					break;
				case 75: // right
					if (cur_col > 0) {
						cur_col--;
					}
					break;
				case 73: // page up
					if (start_line->prev == line_base) {
						cur_row = 0;
						curr_line = start_line;
					} else {
						i = V_ROWS;
						while (i > 0 && start_line->prev != line_base) {
							start_line = start_line->prev;
							curr_line = curr_line->prev;
							i--;
						}
					}
					display();
					break;
				case 81: // page down
					i = V_ROWS;
					while (i > 0 && start_line->next != NULL) {
						start_line = start_line->next;
						if (curr_line->next != NULL)
							curr_line = curr_line->next;
						else
                        	cur_row--;
						i--;
					}
					display();	
					break;
				case 71: // home
                	cur_col = 0;
					break;
				case 79: // end
					cur_col = strlen(curr_line->line);
					if (cur_col > 79)
                    	cur_col = 79;
					break;
			}

		} else { // if (c == 0)

			if (c == '\n') { // enter
				l = strlen(curr_line->line);
				if (cur_col >= l) {
					// cursor after text line
					if ((line2 = malloc(LINE_HEADER_SIZE + 1)) == NULL) {
						show_message("out of memory. (press key to continue)");
						getchar();
						quit_app();
					}
					line2->size = 0;
					line2->line[0] = 0;
					line2->prev = curr_line;
					line2->next = curr_line->next;
					if (line2->next != NULL)
						line2->next->prev = line2;
					line2->prev->next = line2;
					curr_line = line2;
					if (cur_row == V_ROWS - 1)
						start_line = start_line->next;
					else
						cur_row++;
				} else {
					// cursor in text line
                    line1 = curr_line;

					if ((line2 = malloc(LINE_HEADER_SIZE + l - cur_col + 1)) == NULL) {
						show_message("out of memory. (press key to continue)");
						getchar();
						quit_app();
					}

					i = l - cur_col;
					d = line2->line;
					s = curr_line->line + cur_col;
					while (i > 0) {
						*(d++) = *(s++);
						i--;
					}
					*d = 0;
					*(curr_line->line + cur_col) = 0;

					line2->size = cur_col - l;
					line2->prev = curr_line;
					line2->next = curr_line->next;
					if (line2->next != NULL)
						line2->next->prev = line2;
					line2->prev->next = line2;
					curr_line = line2;
					if (cur_row == V_ROWS - 1)
						start_line = start_line->next;
					else
						cur_row++;

					trim_line(line1);
				}

				cur_col = 0;
				display();
			} else if (c == 9) { // backspace
				l = strlen(curr_line->line);
				if (cur_col >= l) {


				} else if (cur_col == 0) {

				} else {

				}
			} else if (c >= ' ') {

			}
		} // if (c == 0)
	} // while (1)
}
/******************************************************************************/
void trim_line(struct line_header *line) {
	byte l;
	struct line_header *new_line;

	l = strlen(line->line);
	if (l + 2 < line->size) {
		new_line = malloc(LINE_HEADER_SIZE + l + 1);
		strcpy(new_line->line, line->line);
		new_line->size = l;
		new_line->next = line->next;
		new_line->prev = line->prev;
		new_line->prev->next = new_line;
		if (new_line->next != NULL)
			new_line->next->prev = new_line;
		if (curr_line == line)
			curr_line = new_line;
		if (start_line == line)
			start_line = new_line;
		free(line);
	}
}
/******************************************************************************/
void edit_begin() {
}
/******************************************************************************/
void edit_end() {
}
/******************************************************************************/
void display() {
	byte i;
	struct line_header *line;

	line = start_line;

	for (i = 0; i < V_ROWS && line != NULL; i++) {
		put_line(line->line, i);
		line = line->next;
	}
	while (i < V_ROWS)
		put_line("", i++);
}
/******************************************************************************/
byte load_file() {
	char c;
	byte i;
	struct line_header *line, *new_line;

	line_base = malloc(LINE_HEADER_SIZE + 1);
	line_base->next = NULL;
	line_base->prev = NULL;
	line_base->size = 0;
	line_base->line[0] = 0;
	line = line_base;

	strcpy(sparam, file_name);

	IO_WRITE(160, #20); // open file for reading
	while (busy);
	if (out_paramb) {
		show_message("loading...");

		i = 0;
		
		while (param1l > 0) {
			c = io_read(163);
			param1l--;

			if (c >= ' ' && (unsigned char)c < 128 ) {
				line_buf[i++] = c;
			} else if (c == '\t') {
				line_buf[i++] = ' ';
				while ((i & 0x03) > 0 && i < MAX_LINE_LENGTH)
                	line_buf[i++] = ' ';
			}
			if (param1l == 0 || i == MAX_LINE_LENGTH || c == '\n') {
				line_buf[i++] = 0;
				new_line = malloc(LINE_HEADER_SIZE + i);
				if (new_line == NULL) {
					malloc_reset();
					show_message("out of memory. (press key to continue)");
					getchar();
					return 0;
				}
				line->next = new_line;
				new_line->prev = line;
				strcpy(new_line->line, line_buf);
				new_line->size = i;

				line = new_line;
				i = 0;
			}
		}

		line->next = NULL;

		show_message("");
		return 1;
	} else {
		show_message("file not found! (press key to continue)");
		getchar();
		return 0;
	}
}
/******************************************************************************/
void save_file() {

}
/******************************************************************************/
