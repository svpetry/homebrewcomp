#ifndef MALLOC_H_
#define MALLOC_H_

#include "defs.h"

struct s_header {
	struct s_header *ptr;
	word size;
};

typedef struct s_header header;

word malloc_free_ram();
void malloc_reset(word memaddr, word memsize);
void *malloc(word nbytes);
void free(void *ap);

#endif /* MALLOC_H_ */

