#ifndef UTILS3D_H_
#define UTILS3D_H_

struct vector {
	int x;
	int y;
	int z;
};

struct point {
	int x;
	int y;
};

//extern const char sintable[384];

int sinus(int angle);
int cosinus(int angle);
void init_rotation(int alpha, int beta, int gamma);
void rotate(struct vector *v);
void vec2point(struct vector *v, struct point *p);
void setpoint(struct point *p);

#endif /* UTILS3D_H_ */
