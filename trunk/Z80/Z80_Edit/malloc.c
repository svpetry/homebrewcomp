#include <stdio.h>

#include "malloc.h"

static Header *freep = NULL;

/******************************************************************************/
void malloc_reset() {
	freep = NULL;
}
/******************************************************************************/
void *malloc(unsigned int nbytes) {
	Header *p, *prevp;
	unsigned int nunits;

//	printf("\nmalloc %u called\n", nbytes);

	nunits = (nbytes + sizeof(Header) - 1) / sizeof(Header) + 1;

//	printf("nunits: %u\n", nunits);

	if ((prevp = freep) == NULL) {   /* no free list yet */
//		printf("freep and prevp initialized\n");

		freep = prevp = (Header *)HEAP_START;
		freep->size = HEAP_SIZE;
		freep->ptr = (Header *)HEAP_START;
	}
	for (p = prevp->ptr; ; prevp = p, p = p->ptr) {

//		printf("p->ptr: %u\n", p->ptr);
//		printf("p->size: %u\n", p->size);

		if (p->size >= nunits) {  /* big enough */
			if (p->size == nunits)  /* exactly */
				prevp->ptr = p->ptr;
			else {              /* allocate tail end */
//				printf("p1: %u\n", p);
				p->size -= nunits;
				p += p->size;
				p->size = nunits;
//				printf("p1->size: %u\n", p->size);
			}
			freep = prevp;

//			printf("p: %u\n", p);
//			printf("malloc returned: %u\n", p + 1);

			return (void *)(p + 1);
		}
		if (p == freep)  /* wrapped around free list */
			return NULL;    /* none left */
	}
}
/******************************************************************************/
void free(void *ap) {
	Header *bp, *p;

	bp = (Header *)ap - 1;    /* point to block header */
	for (p = freep; !(bp > p && bp < p->ptr); p = p->ptr)
		if (p >= p->ptr && (bp > p || bp < p->ptr))
			break;  /* freed block at start or end of arena */

	if (bp + bp->size == p->ptr) {    /* join to upper nbr */
		bp->size += p->ptr->size;
		bp->ptr = p->ptr->ptr;
	} else
		bp->ptr = p->ptr;
	if (p + p->size == bp) {            /* join to lower nbr */
		p->size += bp->size;
		p->ptr = bp->ptr;
	} else
		p->ptr = bp;
	freep = p;
}
/******************************************************************************/

