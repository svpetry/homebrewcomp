#ifndef VARS_H_
#define VARS_H_

#include "bdefs.h"
#include "defs.h"

/******************************************************************************/

extern const struct s_name_token cmd_names[];

extern const struct s_name_token str_func_names[];

extern const struct s_name_token num_func_names[];

/******************************************************************************/

extern volatile char at 0x8000 prog[32768];

extern char *ip;
extern char token_str[MAX_TOKEN_LEN + 1];
extern int token;
extern int token_type;
extern byte token_back;
extern byte print_pos;

extern struct s_expr_res expr_res;

extern struct s_strvar str_vars[MAX_STRING_VARS];
extern int str_var_count;
extern struct s_numvar num_vars[MAX_NUM_VARS];
extern int num_var_count;

extern struct s_label_stack_entry at 0xe000 labels[LABEL_STACK_SIZE];
extern int label_count;

extern char *if_starts[IF_STACK_SIZE];
extern byte if_count;

extern struct s_for_stack_entry for_stack[FOR_STACK_SIZE];
extern byte for_count;

extern char *while_stack[WHILE_STACK_SIZE];
extern byte while_count;

extern char *gosub_stack[GOSUB_STACK_SIZE];
extern byte gosub_count;

extern char *read_pointer;

#endif /* VARS_H_ */