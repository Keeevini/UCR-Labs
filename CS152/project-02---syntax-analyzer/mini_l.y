/* 	Author: Kevin Ni
*	SID: 862246587
*	Lab Section: 022
*
*
*/

%{
	#include <stdio.h>
	#include <stdlib.h>
	void yyerror(const char *msg);
	extern int currLine
	extern int currPos;
	FILE * yyin;
%}

%union {
	int num_val;
	char* id_val;
}

%error-verbose
%start prog_start
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS
END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN
ENDIF ELSE WHILE FOR DO BEGINLOOP ENDLOOP CONTINUE READ
WRITE TRUE FALSE SEMICOLON COLON COMMA L_PAREN R_PAREN
L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN RETURN
%token <id_val> IDENT
%token <num_val> NUMBER
%left AND OR
%left SUB ADD MULT DIV MOD
%left EQ NEQ LT GT LTE GTE
%right NOT ASSIGN

%%

prog_start:	functions { printf("prog_start -> functions\n"); }
	;

functions:	/*empty*/{printf("functions -> epsilon\n");}
	| function functions {printf("functions -> function functions\n");}
	;

function:	FUNCTION ident SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY {printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");}
	;

declarations:	/*empty*/{printf("declarations -> epsilon\n");}
	| declaration SEMICOLON declarations {printf("declarations -> declaration SEMICOLON declarations\n");}
	;

declaration:	identifiers COLON INTEGER {printf("declaration -> identifiers COLON INTEGER\n");}
	| identifiers COLON ARRAY L_SQUARE_BRACKET NUM R_SQUARE_BRACKET OF INTEGER {printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUM R_SQUARE_BRACKET OF INTEGER\n");}
	;

statements:	/*empty*/{printf("statements -> epsilon\n");}
	| statement SEMICOLON statements {printf("statements -> statement SEMICOLON statements\n");}
	;

statement:	var ASSIGN expression {printf("statement -> var ASSIGN expression\n");}
	| IF bool_exp THEN statements ENDIF {printf("statement -> IF bool_exp THEN statements ENDIF\n");}
	| IF bool_exp THEN statements ELSE statements ENDIF {printf("statement -> IF bool_exp THEN statements ELSE statements ENDIF\n");}
	| WHILE bool_exp BEGINLOOP statements ENDLOOP {printf("statement -> WHILE bool_exp BEGINLOOP statements ENDLOOP\n");}
	| DO BEGINLOOP statements ENDLOOP WHILE bool_exp {printf("statement -> DO BEGINLOOP statement_loop ENDLOOP WHILE bool_exp\n");}
	| FOR vars ASSIGN NUMBER SEMICOLON bool_exp SEMICOLON vars ASSIGN expression BEGINLOOP statements ENDLOOP {printf("statement -> FOR vars ASSIGN NUMBER SEMICOLON bool_exp SEMICOLON vars ASSIGN expression BEGINLOOP statements ENDLOOP\n");}
	| READ vars {printf("statement -> READ vars\n");}
	| WRITE vars {printf("statement -> WRITE vars\n");}
	| CONTINUE {printf("statement -> CONTINUE \n");}
	| RETURN expression {printf("statement -> RETURN expression\n");}
	;











