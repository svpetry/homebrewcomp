#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

#include "mybasic.h"
#include "defs.h"
#include "utils.h"
#include "bdefs.h"
#include "video.h"
#include "malloc.h"

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

struct s_expr_res expr_res;

struct s_strvar str_vars[MAX_STRING_VARS];
int str_var_count = 0;
struct s_numvar num_vars[MAX_NUM_VARS];
int num_var_count = 0;

struct s_label_stack_entry labels[LABEL_STACK_SIZE];
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
void error(byte errno) {
	switch (errno) {
		case E_SYNTAX:
			puts("\nsyntax error:");
			break;
		case E_STR_TOO_LONG:
			puts("\nstring too long:");
			break;
		case E_TOKEN_TOO_LONG:
			puts("\ntoken too long:");
			break;
		case E_VARNAME_TOO_LONG:
			puts("\nvarname too long:");
			break;
		case E_DIVZERO:
			puts("\ndivision by zero:");
			break;
		case E_TOO_MANY_VARS:
			puts("\ntoo many variables:");
			break;
		case E_LBL_NOT_FOUND:
			puts("\ngoto label not found:");
			break;
		case E_STACK_OVERFLOW:
			puts("\nstack overflow:");
			break;
		case E_ENDIF_WITHOUT_IF:
			puts("\nendif without if:");
			break;
		case E_ELSE_WITHOUT_IF:
			puts("\else without if:");
			break;
		case E_ENDIF_MISSING:
			puts("\missing endif:");
			break;
		case E_LABEL_ORDER:
			puts("\nwrong label order:");
			break;
		case E_NEXT_WITHOUT_FOR:
			puts("\nnext without for:");
			break;
		case E_WEND_WITHOUT_WHILE:
			puts("\nwend without while:");
			break;
		case E_RETURN_WITHOUT_GOSUB:
			puts("\nreturn without gosub:");
			break;
		case E_WRONG_VALUE:
			puts("\nwrong value:");
			break;
		case E_NO_DATA:
			puts("\nno data:");
			break;
	}

	ip--;
	while (ip > prog && *ip != '\n' && *ip != '\r')
		ip--;
	ip++;
	while (*ip && *ip != '\n' && *ip != '\r')
		putchar(*(ip++));
	putchar('\n');
	getchar();
	quit_app();
} // void error(byte errno)
/******************************************************************************/
void next_line() {
	while (*ip != '\r' && *ip != '\n' && *ip)
		ip++;
	while ((*ip == '\r' || *ip == '\n') && *ip)
		ip++;
} // void next_line()
/******************************************************************************/
void build_label_list() {
	char *pos;
	char val[MAX_NUMSTR_LEN + 1];
	byte l;
	int lbl, last_lbl = 0;

	while (*ip) {
		while (iswhite(*ip))
			ip++;
		l = 0;
		while (isnum(*ip))
			val[l++] = *(ip++);
		pos = ip;
		if (l > 0) {
			lbl = atoi(val);
			if (last_lbl >= lbl)
				error(E_LABEL_ORDER);
			last_lbl = lbl;

			val[l] = 0;
			labels[label_count].pos = pos;
			labels[label_count].label = lbl;
			label_count++;
		}
		next_line();
	}
	ip = prog;
} // void build_label_list()
/******************************************************************************/
byte find_command(char *s) {
	byte i;

	for (i = 0; cmd_names[i].token; i++) {
		if (!strcmp(s, cmd_names[i].name))
			return cmd_names[i].token;
	}
	return 0;
} // byte find_command(char *s)
/******************************************************************************/
void set_strvar(char *varname, char *value) {
	int i;

	for (i = 0; i < str_var_count; i++) {
		if (!strcmp(varname, str_vars[i].name))
			break;
	}
	if (i == str_var_count) {
		if (str_var_count == MAX_STRING_VARS)
			error(E_TOO_MANY_VARS);
		str_var_count++;
		strcpy(str_vars[i].name, varname);
	}
	strcpy(str_vars[i].value, value);
} // void set_strvar(char *varname, char *value)
/******************************************************************************/
struct s_num *find_numvar(char *varname) {
	int i;

	for (i = 0; i < num_var_count; i++) {
		if (!strcmp(varname, num_vars[i].name))
			break;
	}
	if (i == num_var_count) {
		if (num_var_count == MAX_NUM_VARS)
			error(E_TOO_MANY_VARS);
		num_var_count++;
		strcpy(num_vars[i].name, varname);
	}
    return &num_vars[i].value;
} //struct s_num *find_numvar(char *varname)
/******************************************************************************/
void set_numvar(char *varname, struct s_num *value) {
    struct s_num *var;

	var = find_numvar(varname);
	(*var).ival = (*value).ival;
	(*var).fval = (*value).fval;
	(*var).isint = (*value).isint;
} // void set_numvar(char *varname, struct s_num *value)
/******************************************************************************/
byte find_str_func(char *s) {
	register byte i;

	for (i = 0; str_func_names[i].token; i++) {
		if (!strcmp(s, str_func_names[i].name))
			return str_func_names[i].token;
	}
	return 0;
} // byte find_str_func(char *s)
/******************************************************************************/
byte find_num_func(char *s) {
	register byte i;

	for (i = 0; num_func_names[i].token; i++) {
		if (!strcmp(s, num_func_names[i].name))
			return num_func_names[i].token;
	}
	return 0;
} // byte find_num_func(char *s)
/******************************************************************************/
void get_next_token() {
	int i;
	char *src;

	if (token_back) {
		token_back = 0;
		return;
	}

	while (iswhite(*ip))
		ip++;

	if (!(*ip)) {
		*token_str = 0;
		token = T_EOP;
		token_type = TT_SPECIAL;
		return;

	} else if (isnum(*ip)) {
		// numeric value
		byte isint = 1;

		i = 0;
		do {
			if (*ip == '.')
            	isint = 0;
			token_str[i++] = *(ip++);
		} while (isnum(*ip));
		token_str[i] = 0;
		token = isint ? T_INTVAL : T_FLOATVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
		return;

	} else if (*ip == '"') {
		// string value
		i = 0;
		do {
			token_str[i++] = *(ip++);
		} while (*ip != '"' && i < MAX_TOKEN_LEN);
		token_str[i++] = *(ip++);
		token_str[i] = 0;
		token = T_STRVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
		return;

	} else if (isletter(*ip)) {

		i = 0;
		do {
			token_str[i++] = tolower(*(ip++));
		} while ((isletter(*ip) || *ip == '$') && i < MAX_TOKEN_LEN);
		token_str[i] = 0;
		if (i == MAX_TOKEN_LEN ) {
			error(E_TOKEN_TOO_LONG);
		}

		token = find_command(token_str);
		if (token) {
			// command
			token_type = TT_COMMAND;
			return;
		}

		token = find_str_func(token_str);
		if (token) {
			// string function
			token_type = TT_STRFUNC;
			return;
		}

		token = find_num_func(token_str);
		if (token) {
			// numeric function
			token_type = TT_NUMFUNC;
			return;
		}

		if (!strcmp(token_str, "and")) {
			// logic and
			token_type = TT_LOGIC_OP;
			token = T_AND;
			return;
		}

		if (!strcmp(token_str, "or")) {
			// logic or
			token_type = TT_LOGIC_OP;
			token = T_OR;
			return;
		}

		// variable
		token_type = TT_VARIABLE;
		if (token_str[i - 1] == '$') {
			token = T_STRVAR;
			if (i > MAX_VAR_NAME_LEN + 1)
				error(E_VARNAME_TOO_LONG);
		} else {
			token = T_NUMVAR;
			if (i > MAX_VAR_NAME_LEN)
				error(E_VARNAME_TOO_LONG);
		}
		return;
		
	} else if (*ip == '\r' || *ip == '\n') {
		ip++;
		if (*ip == '\n' || *ip == '\r')
			ip++;
		// end of line
		token_str[0] = '\n';
		token_str[1] = 0;
		token_type = TT_SPECIAL;
		token = T_LINEEND;

	} else if (*ip == ':') {
		// colon
		token_str[0] = ':';
		token_str[1] = 0;
		token_type = TT_SPECIAL;
		token = T_COLON;
		ip++;

	} else if (strchr("+-*^/%=;(),><", *ip)) {
		// special character
		token_str[0] = *ip;
		token_str[1] = 0;
		token_type = TT_SPECIAL;
		token = T_SPECIAL;
		ip++;
	} else
    	error(E_SYNTAX);
} // void get_next_token()
/******************************************************************************/
void eval_strfunc(char *result, int *l) {
	char s[256];
	char *p, *q;
	int a, b;
	int func_token = token;

	get_next_token();
	if (token_str[0] != '(')
    	error(E_SYNTAX);

	switch (func_token) {
		case T_MID:
			parse_expression();
			if (expr_res.type != VT_STRING)
				error(E_SYNTAX);
			strcpy(s, expr_res.sval);

			get_next_token();
			if (token_str[0] != ',')
				error(E_SYNTAX);

			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			a = expr_res.ival;

			get_next_token();
			if (token_str[0] != ',')
				error(E_SYNTAX);

			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			b = expr_res.ival;

			p = s;
			while (--a && *p)
				p++;
			q = result;
			while (b > 0 && *l < MAX_STRING_LEN && *p) {
				*(q++) = *(p++);
				(*l)++;
				b--;
			}
			(*q) = 0;
			break;

		case T_LEFT:
			parse_expression();
			if (expr_res.type != VT_STRING)
				error(E_SYNTAX);
			strcpy(s, expr_res.sval);

			get_next_token();
			if (token_str[0] != ',')
				error(E_SYNTAX);

			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			a = expr_res.ival;

			p = s;
			q = result;
			while (*p && *l < MAX_STRING_LEN && a > 0) {
				*(q++) = *(p++);
				(*l)++;
				a--;
			}
			(*q) = 0;
			break;

		case T_RIGHT:
			parse_expression();
			if (expr_res.type != VT_STRING)
				error(E_SYNTAX);
			strcpy(s, expr_res.sval);

			get_next_token();
			if (token_str[0] != ',')
				error(E_SYNTAX);

			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			a = expr_res.ival;

			p = s;
			while (*p)
				p++;
			while (a > 0) {
				p--;
				a--;
            }

			q = result;
			while (*p && *l < MAX_STRING_LEN) {
				*(q++) = *(p++);
				(*l)++;
			}
			(*q) = 0;
			break;
			
		case T_TAB:
			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			a = expr_res.ival - print_pos;

			q = result;
			while (a > 0 && *l < MAX_STRING_LEN) {
				*(q++) = ' ';
				a--;
				(*l)++;
			}
			*q = 0;

			break;

		case T_STR:
			// Todo
			break;

		case T_CHR:
			parse_expression();
			if (expr_res.type != VT_INT)
				error(E_SYNTAX);
			if (*l < MAX_STRING_LEN) {
				*result = expr_res.ival;
				(*l)++;                
			}
			break;
	}

	get_next_token();
	if (token_str[0] != ')')
		error(E_SYNTAX);
} // void eval_strfunc(char *result, int *l)
/******************************************************************************/
void str2num(char *str, struct s_num *value) {
	char *src, *dest;
	char s[MAX_NUMSTR_LEN + 1];
	byte isint, l;

	src = str;
	dest = s;
	isint = 1;
	l = 0;
	while (*src && l < MAX_NUMSTR_LEN) {
		if ((*src >= '0' && *src <= '9') || *src == '.') {
			if (*src == '.')
				isint = 0;
			*(dest++) = *src;
			l++;
		}
		src++;
	}
	*dest = 0;

	(*value).isint = isint;
	if (isint)
		(*value).ival = atoi(s);
	else
		(*value).fval = atof(s);
} // void str2num(char *str, struct s_num *value)
/******************************************************************************/
void eval_numfunc(struct s_num *result) {
	int func_token = token;
	char *src, *dest;

	get_next_token();
	if (token_str[0] != '(')
		error(E_SYNTAX);

	switch (func_token) {
		case T_LEN:
			parse_expression();
			if (expr_res.type != VT_STRING)
				error(E_SYNTAX);
			(*result).isint = 1;
			(*result).ival = strlen(expr_res.sval);
			break;

		case T_RND:
			parse_expression();
			(*result).isint = 0;
			(*result).fval = rand() / (float)RAND_MAX;
			break;

		case T_INT:
			parse_expression();
			(*result).isint = 1;
			if (expr_res.type == VT_FLOAT) {
				(*result).ival = (int)expr_res.fval;
			} else if (expr_res.type == VT_INT) {
				(*result).ival = expr_res.ival;
			} else
            	error(E_SYNTAX);
			break;

		case T_VAL:
			parse_expression();
			if (expr_res.type == VT_STRING)
				str2num(expr_res.sval, result);
			else
				error(E_SYNTAX);
			break;

		case T_SIN:
			(*result).isint = 0;
			parse_expression();
//			if (expr_res.type == VT_FLOAT) {
//				(*result).fval = sin(expr_res.fval);
//			} else if (expr_res.type == VT_FLOAT) {
//				(*result).fval = sin(expr_res.ival);
//			} else
//				error(E_SYNTAX);
			break;

		case T_COS:
			(*result).isint = 0;
			parse_expression();
//			if (expr_res.type == VT_FLOAT) {
//				(*result).fval = cos(expr_res.fval);
//			} else if (expr_res.type == VT_FLOAT) {
//				(*result).fval = cos(expr_res.ival);
//			} else
//				error(E_SYNTAX);
			break;

		case T_ABS:
			parse_expression();
			if (expr_res.type == VT_FLOAT) {
            	(*result).isint = 0;
				(*result).fval = expr_res.fval > 0 ? expr_res.fval : -expr_res.fval;
			} else if (expr_res.type == VT_INT) {
				(*result).isint = 1;
				(*result).ival = expr_res.ival > 0 ? expr_res.ival : -expr_res.ival;
			} else
				error(E_SYNTAX);
			break;

		case T_SQR:
			parse_expression();
//			if (expr_res.type == VT_FLOAT) {
//				(*result).fval = sqrt(expr_res.fval);
//			} else if (expr_res.type == VT_INT) {
//				(*result).fval = sqrt(expr_res.ival);
//			} else
//				error(E_SYNTAX);
			(*result).isint = 0;
			break;

		case T_ASC:
			parse_expression();
			if (expr_res.type == VT_STRING) {
				(*result).isint = 1;
				(*result).ival = expr_res.sval[0];
			} else
				error(E_SYNTAX);
			break;

		case T_TAN:
			(*result).isint = 0;
			parse_expression();
//			if (expr_res.type == VT_FLOAT) {
//				(*result).fval = tan(expr_res.fval);
//			} else if (expr_res.type == VT_FLOAT) {
//				(*result).fval = tan(expr_res.ival);
//			} else
//				error(E_SYNTAX);
			break;

	}
	
	get_next_token();
	if (token_str[0] != ')')
		error(E_SYNTAX);
} // void eval_numfunc(struct s_num *result)
/******************************************************************************/
void get_numvar(char *name, struct s_num *result) {
	struct s_num *var;
	byte i;

	for (i = 0; i < num_var_count; i++) {
		if (!strcmp(name, num_vars[i].name)) {
			var = &(num_vars[i].value);
			(*result).isint = (*var).isint;
			(*result).fval = (*var).fval;
			(*result).ival = (*var).ival;
			return;
		}
	}

	if (name[0] == 'p' && name[1] == 'i' && name[2] == 0) {
		(*result).isint = 0;
		(*result).fval = 3.141593;
	} else {
		(*result).isint = 1;
		(*result).ival = 0;
	}
} // void get_numvar(char *name, struct s_num *result)
/******************************************************************************/
void get_strvar(char *name, char *result, int *l) {
	char *src;
	int i;

	src = name;
	while (*src != '$')
		src++;
	*src = 0;

	for (i = 0; i < str_var_count; i++) {
		if (!strcmp(name, str_vars[i].name)) {
			src = str_vars[i].value;
			while (*src && *l < MAX_STRING_LEN)
				result[(*l)++] = *(src++);
			return;
		}
	}

} // void get_strvar(char *name, char *result, int *l)
/******************************************************************************/
void put_back() {
	token_back = 1;
}
/******************************************************************************/
void unify(struct s_num *a, struct s_num *b) {
	if ((*a).isint && !(*b).isint) {
		(*a).isint = 0;
		(*a).fval = (*a).ival;
	} else if (!(*a).isint && (*b).isint) {
		(*b).isint = 0;
		(*b).fval = (*b).ival;
	}
}
/******************************************************************************/
void parse_num_2(struct s_num *a) {
	byte neg = 0;

	get_next_token();
	if (token_str[0] == '(') {
		parse_num_expr(a);
		get_next_token();
		if (token_str[0] != ')')
			error(E_SYNTAX);
	} else {
		if (token_str[0] == '-') {
			neg = 1;
			get_next_token();
		}
		if (token == T_INTVAL) {
			(*a).isint = 1;
			(*a).ival = atoi(token_str);
		} else if (token == T_FLOATVAL) {
			(*a).isint = 0;
			(*a).fval = atof(token_str);
		} else if (token == T_NUMVAR) {
			get_numvar(token_str, a);
		} else if (token_type == TT_NUMFUNC) {
			eval_numfunc(a);
		} else
			error(E_SYNTAX);

		if (neg) {
			if ((*a).isint)
				(*a).ival = -(*a).ival;
			else
				(*a).fval = -(*a).fval;
		}

	}
} // void parse_num_2(struct s_num *a)
/******************************************************************************/
void parse_num_1(struct s_num *a) {
	struct s_num b;
	char op;

	parse_num_2(a);

	get_next_token();
	while (token_str[0] == '*' || token_str[0] == '/') {
		op = token_str[0];
		parse_num_2(&b);
		unify(a, &b);
		if (op == '*') {
			if ((*a).isint)
				(*a).ival *= b.ival;
			else
				(*a).fval *= b.fval;
		} else {
			if ((*a).isint) {
				if (!b.ival)
					error(E_DIVZERO);
				if ((*a).ival % b.ival > 0) {
					(*a).fval = (float)(*a).ival / (float)b.ival;
					(*a).isint = 0;
				} else
					(*a).ival /= b.ival;
				
			} else {
				if (b.fval == 0.0)
					error(E_DIVZERO);
				(*a).fval /= b.fval;
            }
		}
		get_next_token();
	}
	put_back();
} // void parse_num_1(struct s_num *a)
/******************************************************************************/
void parse_num_expr(struct s_num *a) {
	struct s_num b;
	char op;

	parse_num_1(a);

	get_next_token();
	while (token_str[0] == '+' || token_str[0] == '-') {
		op = token_str[0];
		parse_num_1(&b);
		unify(a, &b);
		if (op == '+') {
			if ((*a).isint)
				(*a).ival += b.ival;
			else
				(*a).fval += b.fval;
		} else {
			if ((*a).isint)
				(*a).ival -= b.ival;
			else
				(*a).fval -= b.fval;
		}
		get_next_token();
	}
	put_back();
} // void parse_num_expr(struct s_num *a)
/******************************************************************************/
void parse_str_expr() {
	int l = 0;
	char result[MAX_STRING_LEN - 1];
	char *res;
	char *s;

	res = result;
	while (1) {
		get_next_token();
		if (token_type == TT_STRFUNC) {
			eval_strfunc(res, &l);
			res = result + l;
		} else if (token == T_STRVAR) {
			get_strvar(token_str, res, &l);
			res = result + l;
		} else if (token == T_STRVAL) {
			s = token_str + 1;
			while (*s != '"' && l < MAX_STRING_LEN) {
				*(res++) = *(s++);
				l++;
			}
		} else {
			put_back();
			break;
		}

		get_next_token();
		if (token == T_SPECIAL && token_str[0] == '+') {
			// do nothing
		} else {
			put_back();
			break;
		}
	}
	(*res) = 0;
	strcpy(expr_res.sval, result);
} // void parse_str_expr()
/******************************************************************************/
void parse_expression() {
	struct s_num a;

	expr_res.type = 0;
	get_next_token();

	if (token_type == TT_NUMFUNC || token == T_FLOATVAL || token == T_INTVAL ||
		token == T_NUMVAR || token_str[0] == '-' || token_str[0] == '(')
	{
		put_back();
		parse_num_expr(&a);
		if (a.isint) {
			expr_res.ival = a.ival;
			expr_res.type = VT_INT;
		} else {
			expr_res.fval = a.fval;
			expr_res.type = VT_FLOAT;
		}
	} else if (token_type == TT_STRFUNC || token == T_STRVAL || token == T_STRVAR) {
		put_back();
		parse_str_expr();
		expr_res.type = VT_STRING;
	}
} // void parse_expression()
/******************************************************************************/
byte eval_bool_1() {
	byte result;
	struct s_num a, b;
	char op1;
	char str[MAX_STRING_LEN + 1];

	get_next_token();
	if (token_str[0] == '(') {
		result = eval_bool_expr();
		get_next_token();
		if (token_str[0] != ')')
			error(E_SYNTAX);
	} else {
    	put_back();
		parse_expression();
		get_next_token();
		op1 = token_str[0];
		if (op1 == '<') {
			get_next_token();
			if (token_str[0] == '>')
				op1 = '#'; // not equal
			else if (token_str[0] == '=') {
				op1 = '{'; // lesser equal
			} else
				put_back();
		} else if (op1 == '>') {
			get_next_token();
			if (token_str[0] == '=')
				op1 = '}'; // greater equal
			else
				put_back();
		}

		if (op1 == '=' || op1 == '>' || op1 == '<' || op1 == '#' || op1 == '{' || op1 == '}') {
			if (expr_res.type == VT_STRING) {

				// string comparison
				strcpy(str, expr_res.sval);
				parse_expression();
				if (expr_res.type != VT_STRING)
					error(E_SYNTAX);
				if (op1 == '=')
					return !strcmp(str, expr_res.sval);
				if (op1 == '#')
					return strcmp(str, expr_res.sval);
				error(E_SYNTAX);

			} else {

				// numeric comparison
				a.ival = expr_res.ival;
				a.fval = expr_res.fval;
				a.isint = expr_res.type == VT_INT;

				parse_expression();
				if (expr_res.type != VT_FLOAT && expr_res.type != VT_INT)
					error(E_SYNTAX);

				b.ival = expr_res.ival;
				b.fval = expr_res.fval;
				b.isint = expr_res.type == VT_INT;

				unify(&a, &b);

				if (op1 == '=') {
					if (a.isint)
						return a.ival == b.ival;
					else
						return a.fval == b.fval;
				}
				if (op1 == '>') {
					if (a.isint)
						return a.ival > b.ival;
					else
						return a.fval > b.fval;
				}
				if (op1 == '<') {
					if (a.isint)
						return a.ival < b.ival;
					else
						return a.fval < b.fval;
				}
				if (op1 == '}') {
					if (a.isint)
						return a.ival >= b.ival;
					else
						return a.fval >= b.fval;
				}
				if (op1 == '{') {
					if (a.isint)
						return a.ival <= b.ival;
					else
						return a.fval <= b.fval;
				}
				if (op1 == '#') {
					if (a.isint)
						return a.ival != b.ival;
					else
						return a.fval != b.fval;
				}
				error(E_SYNTAX);

			}
		} else
        	error(E_SYNTAX);
    }
    return result;
} // byte eval_bool_1()
/******************************************************************************/
byte eval_bool_expr() {
	byte a, b;
	byte op_token;

	a = eval_bool_1();

	get_next_token();

	while (token_type == TT_LOGIC_OP) {
		op_token = token;
		b = eval_bool_1();
		if (op_token == T_AND)
			a = a && b;
		else
			a = a || b;
		get_next_token();
	}
	put_back();
	return a;
} // byte eval_bool_expr()
/******************************************************************************/
void assign_numvar() {
	char varname[MAX_VAR_NAME_LEN + 1];
	struct s_num value;

	strcpy(varname, token_str);

	get_next_token();
	if (token_str[0] != '=')
		error(E_SYNTAX);
	parse_expression();
	if (expr_res.type != VT_FLOAT && expr_res.type != VT_INT)
		error(E_SYNTAX);

	value.ival = expr_res.ival;
	value.fval = expr_res.fval;
	value.isint = expr_res.type = VT_INT ? 1 : 0;
	set_numvar(varname, &value);
} // void assign_numvar()
/******************************************************************************/
void assign_strvar() {
	char *src, *dest;
	char varname[MAX_VAR_NAME_LEN + 1];

	src = token_str;
	dest = varname;
	while (*src != '$')
		*(dest++) = *(src++);
	*dest = 0;

	get_next_token();
	if (token_str[0] != '=')
		error(E_SYNTAX);
	parse_expression();
	if (expr_res.type != VT_STRING)
		error(E_SYNTAX);

	set_strvar(varname, expr_res.sval);
} // void assign_strvar()
/******************************************************************************/
char *get_label(int lbl) {
	int pos, len, new_pos, label;

	pos = 0;
	len = label_count;
	do {
		len = len / 2;
		new_pos = pos + len;
		if (new_pos > label_count - 1)
        	new_pos = label_count - 1;
		label = labels[new_pos].label;
		if (label < lbl)
			pos = new_pos + 1;
		else if (label == lbl) {
			return labels[new_pos].pos;
		}
	} while (len > 0);
	error(E_LBL_NOT_FOUND);
	return 0;
} // char *get_label(int lbl)
/******************************************************************************/
void goto_tokens(byte t1, byte t2) {
	byte if_cnt = 0, while_cnt = 0;

	token = 255;
	while (token != t1 && token != t2 && token != T_EOP) {
		get_next_token();
		switch (token) {
			case T_IF:
				get_next_token();
				if (token == T_LINEEND || token == T_COLON)
					if_cnt++;
				else
					put_back();
				break;
			case T_ENDIF:
				if (if_cnt > 0) {
					if_cnt--;
					token = 0;
				}
				break;
			case T_ELSE:
				if (if_cnt > 0)
					token = 0;
				break;
			case T_REM:
				next_line();
				break;
			case T_WHILE:
				while_cnt++;
				break;
			case T_WEND:
				if (while_cnt > 0) {
					while_cnt--;
					token = 0;
				}
				break;
		}
	}
} // void goto_tokens(byte t1, byte t2)
/******************************************************************************/
void exec_print() {
	char *s;
	byte last_sc = 0;
	byte last_num = 1;

	print_pos = 0;

	while (1) {
		parse_expression();
		switch (expr_res.type) {
			case VT_STRING:
				last_num = 0;
				break;
			case VT_INT:
				if (last_sc && !last_num)
					putchar(' ');
				sprintf(expr_res.sval, "%d", expr_res.ival);
				last_num = 1;
				break;
			case VT_FLOAT:
				if (last_sc && !last_num)
					putchar(' ');
				sprintf(expr_res.sval, "%f", expr_res.fval);
				last_num = 1;
				break;
			default:
				putchar('\r');
				putchar('\n');
				return;
		}

		s = expr_res.sval;
		while (*s) {
			putchar(*(s++));
			print_pos++;
		}
		if (last_num)
        	putchar(' ');

		get_next_token();
		if (token == T_COLON || token == T_LINEEND) {
			putchar('\r');
			putchar('\n');
			return;
		} else if (*token_str == ',') {
			byte p = 8 - print_pos % 8;
			last_sc = 0;
			while (p) {
				putchar(' ');
				print_pos++;
				p--;
			}
		} else if (*token_str == ';') {
			last_sc = 1;
			get_next_token();
			if (token == T_COLON || token == T_LINEEND)
				return;
			else
				put_back();
		}
	}
} // void exec_print()
/******************************************************************************/
void exec_input() {
	char *s;
	char varname[MAX_VAR_NAME_LEN + 1];
	char input[MAX_STRING_LEN + 1];
	int l;
	char c;
	byte var_token;
	struct s_num value;

	get_next_token();
	if (token == T_STRVAL) {
		s = token_str + 1;
		while (*s != '"')
			putchar(*(s++));
		get_next_token();
		if (token_str[0] != ';' && token_str[0] != ',')
			error(E_SYNTAX);
		get_next_token();
	}

	if (token_type != TT_VARIABLE)
		error(E_SYNTAX);
	strcpy(varname, token_str);
	var_token = token;
	
	putchar('?');
	putchar(' ');
	l = 0;
	while (l < MAX_STRING_LEN && (c = getchar()) != '\r') {
		putchar(c);
		input[l++] = c;
	}
	input[l] = 0;
	putchar('\r');
	putchar('\n');

	if (var_token == T_STRVAR) {
		varname[strlen(varname) - 1] = 0;
		set_strvar(varname, input);
	} else {
		str2num(input, &value);
		set_numvar(varname, &value);
    }
} // void exec_input()
/******************************************************************************/
void exec_if() {
	byte cond;
    char *if_start = ip;

	cond = eval_bool_expr();
	get_next_token();
	if (token != T_THEN)
		error(E_SYNTAX);
	get_next_token();
	if (token == T_LINEEND || token == T_COLON) {
		if (cond) {
			// execute then block
			if (if_count == IF_STACK_SIZE - 1)
				error(E_STACK_OVERFLOW);
			if_starts[if_count++] = if_start;
		} else {
			// jump over then block
			goto_tokens(T_ELSE, T_ENDIF);
			if (token == T_ELSE) {
				// else block present
				if (if_count == IF_STACK_SIZE - 1)
					error(E_STACK_OVERFLOW);
				if_starts[if_count++] = if_start;
			}
		}
	} else {
		// one-line if-statement
		if (!cond)
			next_line();
		else {
			if (token == T_INTVAL)
				ip = get_label(atoi(token_str));
			else
            	put_back();
		}
	}
} // void exec_if()
/******************************************************************************/
void exec_goto() {
	char *lbl;

	parse_expression();
	if (expr_res.type != VT_INT)
		error(E_SYNTAX);
	lbl = get_label(expr_res.ival);
	if (if_count) {
		if (lbl < if_starts[if_count - 1])
			if_count--;
		else {
			goto_tokens(T_ENDIF, 0);
			if (lbl > ip)
            	if_count--;
        }
	}
	ip = lbl;
} // void exec_goto()
/******************************************************************************/
void exec_for() {
	struct s_for_stack_entry *fe;

	if (for_count == FOR_STACK_SIZE - 1)
		error(E_STACK_OVERFLOW);
	fe = &(for_stack[for_count]);

	get_next_token();
	if (token != T_NUMVAR)
		error(E_SYNTAX);

	(*fe).var = find_numvar(token_str);
	get_next_token();
	if (token_str[0] != '=')
    	error(E_SYNTAX);
	parse_num_expr((*fe).var);
	get_next_token();
	if (token != T_TO)
		error(E_SYNTAX);
	parse_num_expr(&(*fe).end_value);
	get_next_token();
	if (token == T_STEP) {
		parse_num_expr(&(*fe).step);
		get_next_token();
	} else {
		(*fe).step.isint = 1;
		(*fe).step.ival = 1;
	}

	if (token != T_LINEEND && token != T_COLON)
		error(E_SYNTAX);
	(*fe).loop_start = ip;

	unify((*fe).var, &(*fe).step);
	unify((*fe).var, &(*fe).end_value);
	for_count++;
} // void exec_for()

/******************************************************************************/
void exec_next() {
	struct s_for_stack_entry *fe = &(for_stack[for_count - 1]);

	if (for_count == 0)
		error(E_NEXT_WITHOUT_FOR);
	if ((*(*fe).var).isint) {
		(*(*fe).var).ival += (*fe).step.ival;
		if (((*(*fe).var).ival <= (*fe).end_value.ival && (*fe).step.ival > 0) ||
			((*(*fe).var).ival >= (*fe).end_value.ival && (*fe).step.ival < 0))
		{
			ip = (*fe).loop_start;
			return;
		}
	} else {
		(*(*fe).var).fval += (*fe).step.fval;
		if (((*(*fe).var).fval <= (*fe).end_value.fval + 0.0000001 && (*fe).step.fval > 0) ||
			((*(*fe).var).fval >= (*fe).end_value.fval - 0.0000001 && (*fe).step.fval < 0))
		{
			ip = (*fe).loop_start;
			return;
		}
	}
	for_count--;
	get_next_token();
	if (token != T_NUMVAR)
		put_back();
} // void exec_next()
/******************************************************************************/
void exec_while() {
	if (while_count == WHILE_STACK_SIZE - 1)
    	error(E_STACK_OVERFLOW);

    while_stack[while_count] = ip;
	if (eval_bool_expr())
		while_count++;
	else
		goto_tokens(T_WEND, 0);
} // void exec_while()
/******************************************************************************/
void exec_wend() {
	char *ip_temp;

	if (while_count == 0)
		error(E_WEND_WITHOUT_WHILE);
	ip_temp = ip;
	ip = while_stack[while_count - 1];
	if (!eval_bool_expr()) {
		while_count--;
		ip = ip_temp;
	}
} // void exec_wend()
/******************************************************************************/
void exec_gosub() {
	if (gosub_count == GOSUB_STACK_SIZE - 1)
		error(E_STACK_OVERFLOW);
	parse_expression();
	if (expr_res.type != VT_INT)
		error(E_SYNTAX);
	gosub_stack[gosub_count++] = ip;
	ip = get_label(expr_res.ival);
} // void exec_gosub()
/******************************************************************************/
void exec_return() {
	if (gosub_count == 0)
		error(E_RETURN_WITHOUT_GOSUB);
	ip = gosub_stack[--gosub_count];
} // void exec_return()
/******************************************************************************/
void exec_read() {
	char *temp_ip;
	byte vtoken, i;
	char varname[MAX_VAR_NAME_LEN + 1];
	struct s_num *value;

	get_next_token();
	if (token_type != TT_VARIABLE)
		error(E_SYNTAX);
	vtoken = token;
	i = strlen(token_str) - 1;
	if (token_str[i] == '$')
    	token_str[i] = 0;
	strcpy(varname, token_str);

	temp_ip = ip;
	if (!read_pointer) {
		goto_tokens(T_DATA, 0);
		if (token == T_EOP) {
        	ip = temp_ip;
			error(E_NO_DATA);
		}
	} else
		ip = read_pointer;

	get_next_token();
	if (token == T_LINEEND) {
		goto_tokens(T_DATA, 0);
		if (token == T_EOP) {
        	ip = temp_ip;
			error(E_NO_DATA);
		}
		get_next_token();
	}

	if (token_str[0] == ',')
		get_next_token();
	read_pointer = ip;
	ip = temp_ip;
	if (token_type != TT_VALUE)
		error(E_SYNTAX);

	if (vtoken == T_NUMVAR) {
    	value = find_numvar(varname);
		str2num(token_str, value);
	} else {
		if (token != T_STRVAL)
        	error(E_WRONG_VALUE);
    	token_str[strlen(token_str) - 1] = 0;
		set_strvar(varname, token_str + 1);
	}
} // void exec_read()
/******************************************************************************/
void exec_on() {
	byte i, j;
	int lbl;

	parse_expression();
	if (expr_res.type != VT_INT || expr_res.ival < 1)
		error(E_SYNTAX);
	j = expr_res.ival;
	get_next_token();
	if (token != T_GOTO)
		error(E_SYNTAX);
	for (i = 1; i <= j; i++) {
		if (i > 1) {
			get_next_token();
			if (token_str[0] != ',')
				error(E_SYNTAX);
		}
		get_next_token();
		if (token != T_INTVAL)
        	error(E_SYNTAX);
	}
	ip = get_label(atoi(token_str));
} // void exec_on()
/******************************************************************************/
void start_basic() {

	build_label_list();

	get_next_token();
	while (token != T_EOP && token != T_END && token != T_STOP) {

		while ((token == T_LINEEND || token == T_COLON) && (token != T_EOP)) {
			get_next_token();
        }

		switch (token) {
			case T_STRVAR:
				assign_strvar();
				break;

			case T_LET:
				get_next_token();
				if (token_type != TT_VARIABLE)
                	error(E_SYNTAX);
				put_back();
				break;

			case T_NUMVAR:
				assign_numvar();
				break;

			case T_DATA:
            	// falls through
			case T_REM:
            	next_line();
				break;
				
			case T_PRINT:
				exec_print();
				break;

			case T_INPUT:
            	exec_input();
				break;

			case T_GOTO:
            	exec_goto();
				break;

			case T_IF:
            	exec_if();
				break;

			case T_ELSE:
				if (!if_count)
                	error(E_ELSE_WITHOUT_IF);
				if_count--;
				goto_tokens(T_ENDIF, 0);
				if (token != T_ENDIF)
					error(E_ENDIF_MISSING);
				break;

			case T_ENDIF:
				if (!if_count)
                	error(E_ENDIF_WITHOUT_IF);
            	if_count--;
				break;

			case T_FOR:
				exec_for();
            	break;

			case T_NEXT:
				exec_next();
				break;

			case T_WHILE:
				exec_while();
				break;

			case T_WEND:
				exec_wend();
				break;

			case T_CLS:
				v_cls();
				break;

			case T_GOSUB:
				exec_gosub();
				break;

			case T_RETURN:
				exec_return();
				break;

			case T_READ:
				exec_read();
				break;

			case T_ON:
				exec_on();
				break;

			case T_END:
			case T_STOP:
			case T_INTVAL:
				// do nothing
			case T_EOP:
				// do nothing
				break;

			default:
				error(E_SYNTAX);

		}

		get_next_token();
	}
	getchar();
 }
/******************************************************************************/

