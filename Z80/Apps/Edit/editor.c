#include <string.h>
#include <stdlib.h>

#include "editor.h"
#include "../Lib/defs.h"
#include "../Lib/bios_text.h"
#include "../Lib/bios_file.h"
#include "../Lib/textutils.h"
#include "../Lib/utils.h"
#include "../Lib/malloc.h"
#include "../Lib/io.h"
#include "../Lib/sound.h"

#define HEAP_START 0x3800
#define HEAP_SIZE  0xc800

char line_buf[MAX_LINE_LENGTH + 1];
char file_name[13];

struct line_header *line_base;
struct line_header *start_line; // 1st line of visible screen area
struct line_header *curr_line; // cursor line

byte edit_active;

const char scOutOfMemory[] = "Out of memory. Press any key to continue.";

/******************************************************************************/
//void debug_print(byte col, word i) {
//	char s[12];
//	ltoa(i, s);
//	write_inverse(23, col, s);
//}
/******************************************************************************/
void init_editor() {
	malloc_reset(HEAP_START, HEAP_SIZE);

	settextdim(1, 23);

	memset((void *)0x1000, ' ' + 128, 80);
	memset((void *)0x1c00, ' ' + 128, 80);
	write_inverse(0, 0, " F2: SAVE   F3: LOAD   F5: PLAY   F6: STOP   F8: DELETE   F10: QUIT");

	if (prog_paramcount) {
		strcpy(file_name, prog_params[0]);
		load_file();
	} else {
		file_name[0] = 0;
		init_empty_file();
	}
	show_status();
}
/******************************************************************************/
void init_empty_file() {
	init_line_base();
	start_line = curr_line = malloc(LINE_HEADER_SIZE + 1);
	curr_line->next = NULL;
	curr_line->prev = line_base;
	line_base->next = curr_line;

	curr_line->size = 0;
	curr_line->line[0] = 0;
}
/******************************************************************************/
void init_line_base() {
	line_base = malloc(LINE_HEADER_SIZE + 1);
	line_base->next = NULL;
	line_base->prev = NULL;
	line_base->size = 0;
	line_base->line[0] = 0;
}
/******************************************************************************/
void show_message(char *msg) {
	memset((void *)0x1c00, ' ' + 128, 80);
	write_inverse(24, 1, msg);
}
/******************************************************************************/
void start_lineedit() {
	char *src, *dest;
    byte i;

	if (!edit_active) {
		src = curr_line->line;
		dest = line_buf;
		i = 0;
		while (*src) {
			*(dest++) = *(src++);
			i++;
		}
		while (i < MAX_LINE_LENGTH) {
			*(dest++) = ' ';
			i++;
		}
		*dest = 0;

		edit_active = 1;
	}
}
/******************************************************************************/
void finish_lineedit() {
	char *s;

	if (edit_active) {

		s = (char *)((word)line_buf + MAX_LINE_LENGTH - 1);
		while (*s == ' ' && s != line_buf)
			s--;
		if (*s == ' ')
			*s = 0;
		else
			*(s + 1) = 0;

		trim_line(curr_line, 1);
		edit_active = 0;
		show_status();
	}
}
/******************************************************************************/
void start_editor() {
	char c, *s, *d;
	byte i;
	int l;
	struct line_header *line1, *line2;

	edit_active = 0;
	start_line = curr_line = line_base->next;

	display();

	while (1) {
		showcursor();
		c = getchar();
		hidecursor();

		if (c == 0) {
        	// special key
			c = getchar();
			switch (c) {
				case 59: // F1
					break;
				case 60: // F2
					finish_lineedit();
					save_file();
					show_status();
					break;
				case 61: // F3
					finish_lineedit();
					prompt_load_file();
					show_status();
					break;
				case 62: // F4
					break;
				case 63: // F5
					finish_lineedit();
					stop_sound();
					send_to_soundcard();
					break;
				case 64: // F6
					stop_sound();
					break;
				case 65: // F7
					break;
				case 66: // F8
					finish_lineedit();
					line1 = curr_line;
					if (curr_line->next != NULL) {
						curr_line->prev->next = curr_line->next;
						curr_line->next->prev = curr_line->prev;
						if (start_line == curr_line)
							start_line = curr_line->next;
						curr_line = curr_line->next;
						free(line1);
						show_status();
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
						finish_lineedit();
						cur_row--;
						curr_line = curr_line->prev;
					} else {
						if (curr_line->prev != line_base) {
							finish_lineedit();
							cur_row--;
							scrolldown();
							start_line = curr_line = curr_line->prev;
							put_line(start_line->line, 0);
						}
					}
					break;
				case 80: // down
					if (curr_line->next != NULL) {
						finish_lineedit();
						if (cur_row < rows_total - 1) {
							cur_row++;
							curr_line = curr_line->next;
						} else {
							cur_row++;
							scrollup();
							start_line = start_line->next;
							curr_line = curr_line->next;
							put_line(curr_line->line, rows_total - 1);
						}
					}
					break;
				case 77: // right
					if (cur_col < V_COLS - 1) {
						cur_col++;
					}
					break;
				case 75: // left
					if (cur_col > 0) {
						cur_col--;
					}
					break;
				case 73: // page up
					finish_lineedit();
					if (start_line->prev == line_base) {
						cur_row = 0;
						curr_line = start_line;
					} else {
						i = rows_total;
						while (i > 0 && start_line->prev != line_base) {
							start_line = start_line->prev;
							curr_line = curr_line->prev;
							i--;
						}
					}
					display();
					break;
				case 81: // page down
					finish_lineedit();
					i = rows_total;
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
					if (edit_active) {
						s = (char *)((word)line_buf + MAX_LINE_LENGTH - 1);
						while (*s == ' ' && s != line_buf)
							s--;
						cur_col = (byte)((word)s - (word)line_buf) + 1;
					} else
						cur_col = strlen(curr_line->line);
					if (cur_col > 79)
                    	cur_col = 79;
					break;
			}

		} else { // if (c == 0)

			if (c == '\n') { // enter
				finish_lineedit();

				l = strlen(curr_line->line);
				if (cur_col >= l) {
					// cursor after text line
					if ((line2 = malloc(LINE_HEADER_SIZE + 1)) == NULL) {
						show_message(scOutOfMemory);
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
					if (cur_row == rows_total - 1)
						start_line = start_line->next;
					else
						cur_row++;
					show_status();
				} else {
					// cursor in text line
                    line1 = curr_line;

					if ((line2 = malloc(LINE_HEADER_SIZE + l - cur_col + 1)) == NULL) {
						show_message(scOutOfMemory);
						getchar();
						quit_app();
					}

					i = l - cur_col;
					d = line2->line;
					s = (char *)((word)curr_line->line + cur_col);
					while (i > 0) {
						*(d++) = *(s++);
						i--;
					}
					*d = 0;
					*((char *)((word)curr_line->line + cur_col)) = 0;

					line2->size = cur_col - l;
					line2->prev = curr_line;
					line2->next = curr_line->next;
					if (line2->next != NULL)
						line2->next->prev = line2;
					line2->prev->next = line2;
					curr_line = line2;
					if (cur_row == rows_total - 1)
						start_line = start_line->next;
					else
						cur_row++;

					trim_line(line1, 0);
					show_status();
				}

				cur_col = 0;
				display();
			} else if (c == 8) { // backspace
				l = strlen(curr_line->line);
				if (cur_col > l && !edit_active) {
					if (cur_col > 0)
						cur_col--;
				} else if (cur_col > 0) {
					start_lineedit();
					s = (char *)((word)line_buf + cur_col);
					while (*s) {
						*(s - 1) = *s;
						s++;
					}
					*(s - 1) = ' ';
					put_line(line_buf, cur_row);
					cur_col--;
				} else {

				}
			} else if (c == 9) { // tab

			} else if (c >= ' ') {
				// other characters
				start_lineedit();
				s = line_buf + MAX_LINE_LENGTH - 2;
				while (s >= (char *)((word)line_buf + cur_col)) {
					*(s + 1) = *(s);
					s--;
				}
				*(s + 1) = c;
				put_line(line_buf, cur_row);
				if (cur_col < V_COLS - 1)
					cur_col++;
			}
		} // if (c == 0)
	} // while (1)
} // start_editor
/******************************************************************************/
void trim_line(struct line_header *line, byte use_line_buf) {
	byte l;
	struct line_header *new_line;

	if (use_line_buf)
		l = strlen(line_buf);
	else
		l = strlen(line->line);

	if (l + 2 < line->size || use_line_buf) {
		if ((new_line = malloc(LINE_HEADER_SIZE + l + 1)) == NULL) {
			show_message(scOutOfMemory);
			getchar();
			quit_app();
		}
		if (use_line_buf)
			strcpy(new_line->line, line_buf);
		else
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
} // trim_line
/******************************************************************************/
void show_status() {
	char s[20];

	show_message("");
	if (file_name[0] == 0)
		write_inverse(24, 1, "<new file>");
	else
		write_inverse(24, 1, file_name);
	write_inverse(24, 20, "Free RAM: ");
	ltoa(malloc_free_ram(), s);
	strcat(s, " Bytes");
	write_inverse(24, 30, s);
} // show_status
/******************************************************************************/
void display() {
	byte i;
	struct line_header *line;

	line = start_line;

	for (i = 0; i < rows_total && line != NULL; i++) {
		put_line(line->line, i);
		line = line->next;
	}
	while (i < rows_total)
		put_line("", i++);
} // display
/******************************************************************************/
void load_file() {
	char c;        
	byte i, col;
	struct line_header *line, *new_line;
	dword size;

	init_line_base();
	line = line_base;

	if (fopen(file_name, FM_READ, &size)) {
		show_message("Loading...");
		col = 0;

		i = 0;
		
		while (size > 0) {
			c = io_read(163);
			size--;

			if (c >= ' ' && (unsigned char)c < 128 ) {
				line_buf[i++] = c;
			} else if (c == '\t') {
				line_buf[i++] = ' ';
				while ((i & 0x03) > 0 && i < MAX_LINE_LENGTH)
                	line_buf[i++] = ' ';
			}
			if (i == MAX_LINE_LENGTH || c == '\n') {
				line_buf[i++] = 0;
				new_line = malloc(LINE_HEADER_SIZE + i + 1);
				if (new_line == NULL) {
					malloc_reset(HEAP_START, HEAP_SIZE);
					show_message(scOutOfMemory);
					getchar();
					quit_app();
				}
				line->next = new_line;
				new_line->prev = line;
				strcpy(new_line->line, line_buf);
				new_line->size = i;

				line = new_line;
				i = 0;
			}
		}

		line_buf[i++] = 0;
		new_line = malloc(LINE_HEADER_SIZE + i + 1);
		if (new_line == NULL) {
			malloc_reset(HEAP_START, HEAP_SIZE);
			show_message(scOutOfMemory);
			getchar();
			quit_app();
		}
		line->next = new_line;
		new_line->prev = line;
		strcpy(new_line->line, line_buf);
		new_line->size = i;
		new_line->next = NULL;

	} else {
		init_empty_file();
		show_message("File not found! Press any key to continue.");
		getchar();
	}
} // load_file
/******************************************************************************/
void save_file() {
	word bidx;
	byte l, i;
	struct line_header *line;
	char *s;

	if (prompt_file_name()) {

		show_message("Saving...");

		if (fopen(file_name, FM_WRITE, NULL)) {

			bidx = 0;
			line = line_base->next;

			while (line != NULL) {
				l = strlen(line->line);
				if (bidx + l + 2 > 0x200) {
					fwriteblock(bidx);
					bidx = 0;
				}
				s = line->line;
				for (i = 0; i < l; i++)
					disk_buffer[bidx++] = *(s++);
				if (line->next != NULL) {
					disk_buffer[bidx++] = 13;
					disk_buffer[bidx++] = 10;
				}

				line = line->next;
			}
			if (bidx > 0)
				fwriteblock(bidx);

		} else {
			show_message("Error! Press any key to continue.");
			getchar();
		}
	}

} // save_file
/******************************************************************************/
void prompt_load_file() {
	if (prompt_file_name()) {
		malloc_reset(HEAP_START, HEAP_SIZE);
		load_file();
		edit_active = 0;
		start_line = curr_line = line_base->next;
		display();
	}
} // prompt_load_file
/******************************************************************************/
byte prompt_file_name() {
	char s[13];
	byte pos;
	char c, col;
	byte esc = 0;

	const byte pos_offset = 11;

	pos = strlen(file_name);
	strcpy(s, file_name);
	show_message("");
	write_inverse(24, 1, "Filename: ");
	write_inverse(24, pos_offset, s);

	c = 0;
	while (c != '\n' && !esc) {

		col = pos_offset + pos;
		V_SETCHAR(col, 24, '_' + 128);
		c = getchar();
		V_SETCHAR(col, 24, ' ' + 128);

		if ((c >= 'A' && c <= 'Z')
			|| (c >= 'a' && c <= 'z')
			|| (c >= '0' && c <= '9')
			|| c == ' ' || c == '_' || c == '-' || c == '.')
		{
			if (pos < 12) {
				s[pos] = c;
				*((char *)0x1c00 + pos + pos_offset) = c + 128;
				pos++;
			}

		} else if (c == 8) { // backspace
			if (pos > 0) {
				pos--;
				s[pos] = ' ';
				*((char *)0x1c00 + pos + pos_offset) = ' ' + 128;
			}
		} else if (c == 27) // escape
			esc = 1;
		else if (c == 0)
			getchar();
	}
	
	if (esc)
		return 0;

	s[pos] = 0;
	strcpy(file_name, s);
	return 1;
} // prompt_file_name
/******************************************************************************/
void send_to_soundcard() {
	struct line_header *line;

	line = line_base->next;

	while (line) {
		if (line->line[0] && line->line[0] != '#')
			send_sound_cmd(line->line);
		line = line->next;
    }
} // send_to_soundcard
/******************************************************************************/
void stop_sound() {
	send_sound_cmd("ST");
} // stop_sound
/******************************************************************************/
