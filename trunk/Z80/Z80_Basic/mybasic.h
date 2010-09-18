#ifndef _MYBASIC_H
#define _MYBASIC_H

#include "defs.h"
#include "vars.h"
#include "basic_helpers.h"

void load_program(char *file_name);
void error(byte errno);
void next_line();
void build_label_list();
void set_strvar(char *varname, char *value);
struct s_num *find_numvar(char *varname);
void set_numvar(char *varname, struct s_num *value);
void get_next_token();
void get_numvar(char *name, struct s_num *result);
void get_strvar(char *name, char *result, int *l);
void put_back();
void assign_numvar();
void assign_strvar();
void start_basic();

#endif // _MYBASIC_H
