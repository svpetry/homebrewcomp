#ifndef _MYBASIC_H
#define _MYBASIC_H

#include "defs.h"
#include "vars.h"
#include "basic_helpers.h"

void load_program(char *file_name);
void error(byte errno);
void next_line(void);
void build_label_list(void);
void set_strvar(char *varname, char *value, int vd1, int vd2, int vd3);
struct s_num *find_numvar(char *varname);
void set_numvar(char *varname, struct s_num *value, int vd1, int vd2, int vd3);
void get_next_token(void);
void get_numvar(char *varname, struct s_num *result);
void get_strvar(char *varname, char *result, int *l);
void put_back(void);
void put_back_undo(void);
void assign_numvar(void);
void assign_strvar(void);
void start_basic(void);
void *malloc_checked(unsigned int size);

#endif // _MYBASIC_H
