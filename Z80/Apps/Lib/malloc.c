#include <stdlib.h>

#include "malloc.h"
#include "defs.h"

header *freep;

word heap_start;
word heap_size;

/******************************************************************************/
word malloc_free_ram() {
	word size;
	header *p;

	size = freep->size;
	p = freep->ptr;
	     
	while (p != freep) {
		size += p->size;
		p = p->ptr;
	}
	return size << 2;
}
/******************************************************************************/
void malloc_reset(word memaddr, word memsize) {
	heap_start = memaddr;
	heap_size = memsize;

	freep = (header *)heap_start;
	freep->size = heap_size >> 2;
	freep->ptr = (header *)heap_start;
}
/******************************************************************************/
void *malloc(word nbytes) {
	header *p, *prevp;
	word nunits;

	nunits = (nbytes + sizeof(header) - 1) / sizeof(header) + 1;

	prevp = freep;
	for (p = prevp->ptr; ; prevp = p, p = p->ptr) {

		if (p->size >= nunits) {  /* big enough */
			if (p->size == nunits)  /* exactly */
				prevp->ptr = p->ptr;
			else {              /* allocate tail end */
				p->size -= nunits;
				p += p->size;
				p->size = nunits;
			}
			freep = prevp;

			return (void *)(p + 1);
		}
		if (p == freep)  /* wrapped around free list */
			return NULL;    /* none left */
	}
}
/******************************************************************************/
void free(void *ap) {
	header *bp, *p;

	bp = (header *)ap - 1;    /* point to block header */
	for (p = freep; !(bp > p && bp < p->ptr); p = p->ptr)
		if (p >= p->ptr && (bp > p || bp < p->ptr))
			break;  /* freed block at start or end of arena */

	if (bp + bp->size == p->ptr) {    /* join to upper nbr */
		bp->size += p->ptr->size;
		bp->ptr = p->ptr->ptr;
	} else
		bp->ptr = p->ptr;
	if (p + p->size == bp) {          /* join to lower nbr */
		p->size += bp->size;
		p->ptr = bp->ptr;
	} else
		p->ptr = bp;
	freep = p;
}
/******************************************************************************/

