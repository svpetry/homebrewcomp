#ifndef UTILS3D_H_
#define UTILS3D_H_

struct vector {
	int x;
	int y;
	int z;
};

struct point {
	unsigned char x;
	unsigned char y;
};

//extern const char sintable[384];

int sinus(int angle);
int cosinus(int angle);
void init_rotation(int ax, int ay, int az);
void rotate(struct vector *v);
void vec2point(struct vector *v, struct point *p);


#endif /* UTILS3D_H_ */
