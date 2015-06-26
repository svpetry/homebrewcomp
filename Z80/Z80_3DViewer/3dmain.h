#ifndef _3DMAIN_H_
#define _3DMAIN_H_

#include "defs.h"

#define MAX_VERT 100
#define MAX_EDGE 400
#define LINE_BUF_SIZE 80

#define IS_NUM_CHAR(c) ((c >= '0' && c <= '9') || c == '-')

byte file_read_line(void);
byte load_model(char *file_name);
void start3d(void);

#endif /* _3DMAIN_H_ */

