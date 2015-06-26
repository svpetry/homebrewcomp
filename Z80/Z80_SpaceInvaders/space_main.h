#ifndef TMAIN_H_
#define TMAIN_H_

#include "defs.h"

void ball_demo(void);

void space(void);
void init_game(void);
void move_invaders(void);
void invaders_shot(void);
void tank_shot(void);
void draw_invaders(void);
void draw_invader(byte xpos, byte ypos, byte no);
void draw_tank(byte pos);

#define INV_X_COUNT 8
#define INV_Y_COUNT 3

#endif /* TMAIN_H_ */

