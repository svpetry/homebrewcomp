#ifndef MALLOC_H_
#define MALLOC_H_

#define HEAP_START  0x8000
#define HEAP_SIZE	0x2000

struct header {
	struct header *ptr;
	unsigned int size;
};

typedef struct header Header;

unsigned int malloc_free_ram();
void malloc_reset();
void *malloc(unsigned int nbytes);
void free(void *ap);

#endif /* MALLOC_H_ */

