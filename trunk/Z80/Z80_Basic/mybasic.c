#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

#include "mybasic.h"
#include "defs.h"
#include "utils.h"
#include "utils_b0.h"
#include "bdefs.h"
#include "video.h"
#include "malloc.h"
#include "basic_helpers.h"
#include "io.h"
#include "bios_cmd.h"

//#define DEBUG

/******************************************************************************/
void load_program(char *file_name) {
#ifdef _DEBUG
	char *p = prog;
	FILE *fp;
	int i = 0;

	fp = fopen(file_name, "rb");
	if (!fp)
    	exit(1);
	i = 0;
	do {
		*p = getc(fp);
		p++;
		i++;
	} while (!feof(fp) && i < 32768);

	*(p - 2) = 0; // null terminate the program

    ip = prog;
	
	fclose(fp);
#else // _DEBUG
	strcpy(sparam, file_name);

	IO_WRITE(160, #20); // open file for reading
	while (busy);

	if (!out_paramb) {
		strcat(sparam, ".bas");
		IO_WRITE(160, #20); // open file for reading
		while (busy);
	}

	if (out_paramb) {

		if (param1l < 32768) {
			puts("Loading...");

			SELECT_BANK1;
			ip = prog;
			while (param1l > 0) {
				*(ip++) = io_read(163);
				param1l--;
			}
			*ip = 0;
			SELECT_BANK0;
		} else {
			puts("File too large! Press key to continue.");
			getchar();
			quit_app();
		}
	} else {
		puts("File not found! Press key to continue.");
		getchar();
		quit_app();
	}
#endif // _DEBUG
}
/******************************************************************************/
void error(byte errno) {
	SELECT_BANK0;
	print_error_text(errno);
	SELECT_BANK1;
	ip--;
	while (ip > prog && *ip != '\n' && *ip != '\r')
		ip--;
	if (ip > prog)
		ip++;
	while (*ip && *ip != '\n' && *ip != '\r')
		putchar(*(ip++));
	SELECT_BANK0;
	putchar('\n');
	getchar();
	quit_app();
} // void error(byte errno)
/******************************************************************************/
void next_line() {
#ifdef DEBUG
	puts("next_line()");
#endif
	SELECT_BANK1;
	while (*ip != '\r' && *ip != '\n' && *ip)
		ip++;
	while ((*ip == '\r' || *ip == '\n') && *ip)
		ip++;
	SELECT_BANK0;
} // void next_line()
/******************************************************************************/
void build_label_list() {
	char *pos;
	char val[MAX_NUMSTR_LEN + 1];
	byte l;
	int lbl, last_lbl = 0;

#ifdef DEBUG
	puts("build_label_list()");
#endif

	SELECT_BANK1;
	while (*ip) {
		while (iswhite(*ip))
			ip++;
		l = 0;
		while (isnum(*ip))
			val[l++] = *(ip++);
		SELECT_BANK0;
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
		SELECT_BANK1;
	}
	ip = prog;
	SELECT_BANK0;
} // void build_label_list()
/******************************************************************************/
void set_strvar(char *varname, char *value) {
	int i;
	byte l, l1;
	struct s_strvar *svar = NULL;
	struct s_strdvar *sdvar;
	char **s;

#ifdef DEBUG
	puts("set_strvar()");
#endif

	l = strlen(value);
	for (i = 0; i < str_dvar_count; i++) {
		if (!strcmp(varname, str_dvars[i].name))
			break;
	}
	if (i < str_dvar_count) {
		if (!dim1)
			error(E_VAR_DIM_ERROR);
		dim1--;
		dim2--;
		dim3--;

		SELECT_BANK2;
		sdvar = &str_dvars[i];
		if (dim3)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1 + dim3 * sdvar->len_dim1 * sdvar->len_dim2;
		else if (dim2)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1;
		else
			s = sdvar->data + dim1;

		if (*s != NULL)
			free(*s);
		if (l > 0) {
			*s = malloc(l);
			strcpy(*s, value);
		}

		SELECT_BANK0;
	} else {

	#ifdef _DEBUG
    	l1 = ((l + 1 ) & 0xf8) + 8;
	#else
		l1 = ((l + 1) & 0b11111000) + 8;
	#endif // _DEBUG

		SELECT_BANK2;
		for (i = 0; i < str_var_count; i++) {
			if (!strcmp(varname, str_vars[i].name)) {
				svar = &(str_vars[i]);
				if (svar->maxlen < l) {
					free(svar->value);
					if ((svar->value = malloc(l1)) == NULL)
						error(E_OUT_OF_MEMORY);
					svar->maxlen = l1;
				}
				break;
			}
		}
		if (i == str_var_count) {
			if (str_var_count == MAX_STRING_VARS)
				error(E_TOO_MANY_VARS);
			str_var_count++;
			svar = &(str_vars[i]);
			strcpy(svar->name, varname);
			if ((svar->value = malloc(l1)) == NULL)
				error(E_OUT_OF_MEMORY);
			svar->maxlen = l1;
		}
		strcpy(svar->value, value);
		SELECT_BANK0;
	}
} // void set_strvar(char *varname, char *value)
/******************************************************************************/
struct s_num *find_numvar(char *varname) {
	int i;

#ifdef DEBUG
	puts("find_numvar()");
#endif

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
	struct s_numdvar *dvar;
	int i;

#ifdef DEBUG
	puts("set_numvar()");
#endif

	for (i = 0; i < num_dvar_count; i++) {
		if (!strcmp(varname, num_dvars[i].name))
			break;
	}
	if (i < num_dvar_count) {
		if (!dim1)
			error(E_VAR_DIM_ERROR);
		dim1--;
		dim2--;
		dim3--;

		dvar = &num_dvars[i];
		SELECT_BANK2;
		if (dim3)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1 + dim3 * dvar->len_dim1 * dvar->len_dim2;
		else if (dim2)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1;
		else
			var = dvar->data + dim1;
		(*var).ival = (*value).ival;
		(*var).fval = (*value).fval;
		(*var).isint = (*value).isint;
		SELECT_BANK0;

	} else {
		var = find_numvar(varname);
		(*var).ival = (*value).ival;
		(*var).fval = (*value).fval;
		(*var).isint = (*value).isint;
	}
} // void set_numvar(char *varname, struct s_num *value)
/******************************************************************************/
void get_next_token() {
	int i;
//	char nums[MAX_NUMSTR_LEN];
//	char *s;
//	char *src;

#ifdef DEBUG
	puts("get_next_token()");
#endif

	if (token_back) {
		token_back = 0;
		return;
	}

	SELECT_BANK1;
	while (iswhite(*ip))
		ip++;

	if (!(*ip)) {
	#ifdef DEBUG
		puts("	T_EOP");
	#endif
		SELECT_BANK0;
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
		SELECT_BANK0;
		token_str[i] = 0;
		token = isint ? T_INTVAL : T_FLOATVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
	#ifdef DEBUG
		puts_nlb("T_INTVAL, T_FLOATVAL: ");
		puts(token_str);
	#endif
		return;

	} else if (*ip == '"') {
		// string value
		i = 0;
		do {
			token_str[i++] = *(ip++);
		} while (*ip != '"' && i < MAX_TOKEN_LEN);
		token_str[i++] = *(ip++);
		token_str[i] = 0;
		SELECT_BANK0;
		token = T_STRVAL;
		token_type = TT_VALUE;
		if (i == MAX_TOKEN_LEN )
			error(E_TOKEN_TOO_LONG);
	#ifdef DEBUG
		puts_nlb("T_STRVAL: ");
		puts(token_str);
	#endif
		return;

	} else if (isletter(*ip)) {

		i = 0;
		do { // todo SP: [] weg
			token_str[i++] = tolower1(*(ip++));
		} while ((isletter(*ip) || isnum(*ip) || *ip == '$') && i < MAX_TOKEN_LEN);
		token_str[i] = 0;
	#ifdef DEBUG
		puts_nlb("token_str: ");
		puts(token_str);
	#endif
		SELECT_BANK0;
		if (i == MAX_TOKEN_LEN ) {
			error(E_TOKEN_TOO_LONG);
		}

		token = find_command(token_str);
		if (token) {
			// command
			token_type = TT_COMMAND;
		#ifdef DEBUG
			puts("TT_COMMAND");
		#endif
			return;
		}

		token = find_str_func(token_str);
		if (token) {
			// string function
		#ifdef DEBUG
			puts("TT_STRFUNC");
		#endif
			token_type = TT_STRFUNC;
			return;
		}

		token = find_num_func(token_str);
		if (token) {
			// numeric function
		#ifdef DEBUG
			puts("TT_NUMFUNC");
		#endif
			token_type = TT_NUMFUNC;
			return;
		}

		if (!strcmp(token_str, "and")) {
			// logic and
		#ifdef DEBUG
			puts("T_AND");
		#endif
			token_type = TT_LOGIC_OP;
			token = T_AND;
			return;
		}

		if (!strcmp(token_str, "or")) {
			// logic or
		#ifdef DEBUG
			puts("T_OR");
		#endif
			token_type = TT_LOGIC_OP;
			token = T_OR;
			return;
		}

		// variable
		token_type = TT_VARIABLE;
		if (token_str[i - 1] == '$') {
		#ifdef DEBUG
			puts("T_STRVAR");
		#endif
			token = T_STRVAR;
			if (i > MAX_VAR_NAME_LEN + 1)
				error(E_VARNAME_TOO_LONG);
		} else {
		#ifdef DEBUG
			puts("T_NUMVAR");
		#endif
			token = T_NUMVAR;
			if (i > MAX_VAR_NAME_LEN)
				error(E_VARNAME_TOO_LONG);
		}

		// read variable dimensions
//		SELECT_BANK1;
//		while (iswhite(*ip))
//			ip++;
//		dim1 = 0;
//		if (*ip == '(') {
//			ip++;
//			while (iswhite(*ip))
//				ip++;
//
//			dim2 = 1;
//			dim3 = 1;
//
//			// read 1st dimension
//			s = nums;
//			while (*ip >= '0' && *ip <= '9')
//				*(s++) = *(ip++);
//			*s = 0;
//			dim1 = atoi(nums);
//
//			while (iswhite(*ip))
//				ip++;
//			if (*ip == ',') {
//				ip++;
//				while (iswhite(*ip))
//					ip++;
//
//				// read 2nd dimension
//				s = nums;
//				while (*ip >= '0' && *ip <= '9')
//					*(s++) = *(ip++);
//				*s = 0;
//				dim2 = atoi(nums);
//
//				while (iswhite(*ip))
//					ip++;
//				if (*ip == ',') {
//					ip++;
//					while (iswhite(*ip))
//						ip++;
//
//					// read 3rd dimension
//					s = nums;
//					while (*ip >= '0' && *ip <= '9')
//						*(s++) = *(ip++);
//					*s = 0;
//					dim3 = atoi(nums);
//				}
//			}
//			while (iswhite(*ip))
//				ip++;
//			if (*ip != ')')
//				error(E_SYNTAX);
//			ip++;
//		}
//		SELECT_BANK0;
		return;
		
	} else if (*ip == '\r' || *ip == '\n') {
		ip++;
		if (*ip == '\n' || *ip == '\r')
			ip++;
		SELECT_BANK0;
		// end of line
		token_str[0] = '\n';
		token_str[1] = 0;
	#ifdef DEBUG
		puts("T_LINEEND");
	#endif
		token_type = TT_SPECIAL;
		token = T_LINEEND;

	} else if (*ip == ':') {
		SELECT_BANK0;
		// colon
		token_str[0] = ':';
		token_str[1] = 0;
	#ifdef DEBUG
		puts("T_COLON");
	#endif
		token_type = TT_SPECIAL;
		token = T_COLON;
		ip++;

	} else if (strchr("+-*^/%=;(),><", *ip)) {
		// special character
		token_str[0] = *ip;
		token_str[1] = 0;
		SELECT_BANK0;
	#ifdef DEBUG
		puts("T_SPECIAL");
	#endif
		token_type = TT_SPECIAL;
		token = T_SPECIAL;
		ip++;
	} else {
		SELECT_BANK0;
		error(E_SYNTAX);
	}
} // void get_next_token()
/******************************************************************************/
void get_numvar(char *varname, struct s_num *result) {
	struct s_num *var;
	struct s_numdvar *dvar;
	byte i;

#ifdef DEBUG
	puts("get_numvar()");
#endif

	for (i = 0; i < num_dvar_count; i++) {
		if (!strcmp(varname, num_dvars[i].name))
			break;
	}
	if (i < num_dvar_count) {
		read_dimensions();
		if (!dim1)
			error(E_VAR_DIM_ERROR);
		dim1--;
		dim2--;
		dim3--;

		dvar = &num_dvars[i];
		SELECT_BANK2;
		if (dim3)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1 + dim3 * dvar->len_dim1 * dvar->len_dim2;
		else if (dim2)
			var = dvar->data + dim1 + dim2 * dvar->len_dim1;
		else
			var = dvar->data + dim1;
		(*result).isint = (*var).isint;
		(*result).fval = (*var).fval;
		(*result).ival = (*var).ival;
		SELECT_BANK0;

	} else {
		for (i = 0; i < num_var_count; i++) {
			if (!strcmp(varname, num_vars[i].name)) {
				var = &(num_vars[i].value);
				(*result).isint = (*var).isint;
				(*result).fval = (*var).fval;
				(*result).ival = (*var).ival;
				return;
			}
		}

		if (varname[0] == 'p' && varname[1] == 'i' && varname[2] == 0) {
			(*result).isint = 0;
			(*result).fval = 3.14159265;
		} else {
			(*result).isint = 1;
			(*result).ival = 0;
		}
	}
} // void get_numvar(char *name, struct s_num *result)
/******************************************************************************/
void get_strvar(char *varname, char *result, int *l) {
	char *src, *dest;
	int i;
	struct s_strdvar *sdvar;
	char **s;

#ifdef DEBUG
	puts("get_strvar()");
#endif

	src = varname;
	while (*src != '$')
		src++;
	*src = 0;

	for (i = 0; i < str_dvar_count; i++) {
		if (!strcmp(varname, str_dvars[i].name))
			break;
	}
	if (i < str_dvar_count) {
		read_dimensions();
		if (!dim1)
			error(E_VAR_DIM_ERROR);
		dim1--;
		dim2--;
		dim3--;

		SELECT_BANK2;
		sdvar = &str_dvars[i];
		if (dim3)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1 + dim3 * sdvar->len_dim1 * sdvar->len_dim2;
		else if (dim2)
			s = sdvar->data + dim1 + dim2 * sdvar->len_dim1;
		else
			s = sdvar->data + dim1;

		if (*s != NULL) {
			src = *s;
			dest = result + *l;
			while (*src && *l < MAX_STRING_LEN) {
				*(dest++) = *(src++);
				(*l)++;
			}
		}
		SELECT_BANK0;
	} else {
		SELECT_BANK2;
		for (i = 0; i < str_var_count; i++) {
			if (!strcmp(varname, str_vars[i].name)) {
				src = str_vars[i].value;
				dest = result + *l;
				while (*src && *l < MAX_STRING_LEN) {
					*(dest++) = *(src++);
					(*l)++;
				}
				break;
			}
		}
		SELECT_BANK0;
	}
} // void get_strvar(char *name, char *result, int *l)
/******************************************************************************/
void put_back() {
#ifdef DEBUG
	puts("put_back()");
#endif
	token_back = 1;
}
/******************************************************************************/
void put_back_undo() {
#ifdef DEBUG
	puts("put_back_undo()");
#endif
	token_back = 0;
	ip -= strlen(token_str);
}
/******************************************************************************/
void assign_numvar() {
	char varname[MAX_VAR_NAME_LEN + 1];
	struct s_num value;

#ifdef DEBUG
	puts("assign_numvar()");
#endif

	strcpy(varname, token_str);

	read_dimensions();
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

#ifdef DEBUG
	puts("assign_strvar()");
#endif

	src = token_str;
	dest = varname;
	while (*src != '$')
		*(dest++) = *(src++);
	*dest = 0;

	read_dimensions();
	get_next_token();

	if (token_str[0] != '=')
		error(E_SYNTAX);
	parse_expression();
	if (expr_res.type != VT_STRING)
		error(E_SYNTAX);

	set_strvar(varname, expr_res.sval);
} // void assign_strvar()
/******************************************************************************/
void start_basic() {

	ip = prog;
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
			#ifdef _DEBUG
            	system("cls");
			#else
				v_cls();
			#endif
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

			case T_DIM:
				exec_dim();
				break;

			case T_BEEP:
                beep();
				break;

			case T_GOTOXY:
            	exec_gotoxy();
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
 }
/******************************************************************************/
void *malloc_checked(unsigned int size) {
	void *result;
//	char s[10];

//	puts_nlb("malloc_checked(");
//	itoa(size, s);
//	puts_nlb(s);
//	puts(")");

	SELECT_BANK2;
	result = malloc(size);
	memset(result, 0, size);
	SELECT_BANK0;
	if (result == NULL)
		error(E_OUT_OF_MEMORY);
	return result;
}
/******************************************************************************/
