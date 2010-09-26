#include "vars.h"

#include "bdefs.h"
#include "defs.h"

/******************************************************************************/

const struct s_name_token cmd_names[] = {
	{"print", T_PRINT},
	{"input", T_INPUT},
	{"if", T_IF},
	{"then", T_THEN},
	{"else", T_ELSE},
	{"endif", T_ENDIF},
	{"cls", T_CLS},
	{"for", T_FOR},
	{"to", T_TO},
	{"next", T_NEXT},
	{"let", T_LET},
	{"goto", T_GOTO},
	{"gosub", T_GOSUB},
	{"return", T_RETURN},
	{"end", T_END},
	{"dim", T_DIM},
	{"read", T_READ},
	{"data", T_DATA},
	{"gotoxy", T_GOTOXY},
	{"rem", T_REM},
	{"on", T_ON},
	{"let", T_LET},
	{"step", T_STEP},
	{"while", T_WHILE},
	{"wend", T_WEND},
	{"stop", T_STOP},
	{"on", T_ON},
	{"beep", T_BEEP},
	{"", 0}
};

const struct s_name_token str_func_names[] = {
	{"mid$", T_MID},
	{"left$", T_LEFT},
	{"right$", T_RIGHT},
	{"tab", T_TAB},
	{"str", T_STR},
	{"chr$", T_CHR},
	{"", 0}
};

const struct s_name_token num_func_names[] = {
	{"len", T_LEN},
	{"rnd", T_RND},
	{"int", T_INT},
	{"val", T_VAL},
	{"sin", T_SIN},
	{"cos", T_COS},
	{"abs", T_ABS},
	{"sqr", T_SQR},
	{"asc", T_ASC},
	{"tan", T_TAN},
	{"log", T_LOG},
	{"", 0}
};

/******************************************************************************/

volatile char at 0x8000 prog[32768];

char *ip;
char token_str[MAX_TOKEN_LEN + 1];
int token;
int token_type;
byte token_back = 0;
byte print_pos;

word dim1;
word dim2;
word dim3;

struct s_expr_res expr_res;

struct s_strvar str_vars[MAX_STRING_VARS];
int str_var_count = 0;
struct s_numvar num_vars[MAX_NUM_VARS];
int num_var_count = 0;
struct s_strdvar str_dvars[MAX_STRING_DVARS];
int str_dvar_count = 0;
struct s_numdvar num_dvars[MAX_NUM_DVARS];
int num_dvar_count = 0;

struct s_label_stack_entry at 0xe000 labels[LABEL_STACK_SIZE];
int label_count = 0;

char *if_starts[IF_STACK_SIZE];
byte if_count = 0;

struct s_for_stack_entry for_stack[FOR_STACK_SIZE];
byte for_count = 0;

char *while_stack[WHILE_STACK_SIZE];
byte while_count = 0;

char *gosub_stack[GOSUB_STACK_SIZE];
byte gosub_count = 0;

char *read_pointer = 0;

/******************************************************************************/

