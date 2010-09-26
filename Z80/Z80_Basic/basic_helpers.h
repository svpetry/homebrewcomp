#ifndef _BASIC_HELPERS_H
#define _BASIC_HELPERS_H

#include "defs.h"
#include "vars.h"
#include "mybasic.h"

void print_error_text(byte errno);
byte find_command(char *s);
byte find_str_func(char *s);
byte find_num_func(char *s);
void goto_tokens(byte t1, byte t2);
void exec_print();
void exec_input();
void exec_if();
void exec_goto();
void exec_for();
void exec_next();
void exec_while();
void exec_wend();
void exec_gosub();
void exec_return();
void exec_read();
void exec_on();
void exec_dim();
void exec_gotoxy();
void eval_strfunc(char *result, int *l);
void str2num(char *str, struct s_num *value);
void eval_numfunc(struct s_num *result);
void unify(struct s_num *a, struct s_num *b);
void parse_num_2(struct s_num *a);
void parse_num_1(struct s_num *a);
void parse_num_expr(struct s_num *a);
void parse_str_expr();
void parse_expression();
byte eval_bool_1();
byte eval_bool_expr();
char *get_label(int lbl);
void read_dimensions();

#endif // _BASIC_HELPERS_H
