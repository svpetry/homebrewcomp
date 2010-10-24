#ifndef TMAIN_H_
#define TMAIN_H_

#include "defs.h"

void tetris(void);

void move_right(void);
void move_left(void);
byte move_down(void);
byte is_block_set(char x, char y);

void draw_playfield(void);

void draw_curr_part(void);
void clear_curr_part(void);
void select_part(byte n);
byte rotate_curr_part();

void clear_block(char x, char y);
void draw_block(char x, char y);
void clear_playfield(void);

#endif /* TMAIN_H_ */

