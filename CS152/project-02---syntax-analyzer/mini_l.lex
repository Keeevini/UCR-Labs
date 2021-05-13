%{
	#include <stdio.h>
	#include <math.h>
	int currLine = 1, currPos = 1;
	#include "y.tab.h"
%}

DIGIT		[0-9]
LETTER		[a-zA-Z]

ID		[a-zA-Z]([a-zA-Z|0-9|_]*[a-zA-Z|0-9])?
UNDERSCORE	[a-zA-Z][a-zA-Z0-9_]*[_]
LETTER_START	[0-9_][a-zA-Z|0-9_]*

COMMENT		##.*

%%

{COMMENT} {
		currPos += yyleng;
}

function {
		currPos += yyleng;
		return(FUNCTION);
}

beginparams {
		currPos += yyleng;
		return(BEGIN_PARAMS);
}

endparams {
		currPos += yyleng;
		return(END_PARAMS);
}

beginlocals {
		currPos += yyleng;
		return(BEGIN_LOCALS);
}

endlocals {
		currPos += yyleng;
		return(END_LOCALS);
}

beginbody {
		currPos += yyleng;
		return(BEGIN_BODY);
}

endbody {
		currPos += yyleng;
		return(END_BODY);
}

integer {
		currPos += yyleng;
		return(INTEGER);
}

array {
		currPos += yyleng;
		return(ARRAY);
}

of {
		currPos += yyleng;
		return(OF);
}

if {
		currPos += yyleng;
		return(IF);
}

then {
		currPos += yyleng;
		return(THEN);
}

endif {
		currPos += yyleng;
		return(ENDIF);
}

else {
		currPos += yyleng;
		return(ELSE);
}

while {
		currPos += yyleng;
		return(WHILE);
}

do {
		currPos += yyleng;
		return(DO);
}

beginloop {
		currPos += yyleng;
		return(BEGINLOOP);
}

endloop {
		currPos += yyleng;
		return(ENDLOOP);
}

break {
		currPos += yyleng;
		return(BREAK);
}

continue {
		currPos += yyleng;
		return(CONTINUE);
}

read {
		currPos += yyleng;
		return(READ);
}

write {
		currPos += yyleng;
		return(WRITE);
}

"(" {	/* Precedence 0 */
		currPos += yyleng;
		return(L_PAREN);
}

")" {
		currPos += yyleng;
		return(R_PAREN);
}

"[" {	/* Precedence 1 */
		currPos += yyleng;\
		return(L_SQUARE_BRACKET);
}

"]" {
		currPos += yyleng;
		return(R_SQUARE_BRACKET);
}

"*" {	/* Precedence 3 */
		currPos += yyleng;
		return(MULT);
}

"/" {
		currPos += yyleng;
		return(DIV);
}

"%" {
		currPos += yyleng;
		return(MOD);
}

"-" {	/* Precedence 4 */
		currPos += yyleng;
		return(SUB);
}

"+" {
		currPos += yyleng;
		return(ADD);
}

"==" {	/* Precedence 5 */
		currPos += yyleng;
		return(EQ);
}

"<>" {
		currPos += yyleng;
		return(NEQ);
}

"<" {
		currPos += yyleng;
		return(LT);
}

">" {
		currPos += yyleng;
		return(GT);
}

"<=" {
		currPos += yyleng;
		return(LTE);
}

">=" {
		currPos += yyleng;
		return(GTE);
}

not {	/* Precedence 6 */
		currPos += yyleng;
		return(NOT);
}

and {	/* Precedence 7 */
		currPos += yyleng;
		return(AND);
}

or {	/* Precedence 8 */
		currPos += yyleng;
		return(OR);
}

true {
		currPos += yyleng;
		return(TRUE);
}

false {
		currPos += yyleng;
		return(FALSE);
}

return {
		currPos += yyleng;
		return(RETURN);
}

";" {
		currPos += yyleng;
		return(SEMICOLON);
}

":" {
		currPos += yyleng;
		return(COLON);
}

"," {
		currPos += yyleng;
		return(COMMA);
}

":=" {	/* Precedence 9 */
		currPos += yyleng;
		return(ASSIGN);
}

[ \t]+ {
		currPos += yyleng;
}

"\n" {
		currLine++;
		currPos = 1;
}

{ID} {
		currPos += yyleng;
		yylval.id_val = yytext;
		return IDENT;
}

{DIGIT}+ {
		currPos += yyleng;
		yylval.num_val = atoi(yytext);
		return NUMBER;
}

{UNDERSCORE} {		/* ERRORS */
		printf("Error at line %d, column %d: identifier \"%s\" cannot end with underscore\n", currLine, currPos, yytext);
		exit(0);		
}

{LETTER_START} {	/* ERRORS */
		printf("Error at line %d, column %d: identifier \"%s\" must begin wtih a letter\n", currLine, currPos, yytext);
		exit(0);
}

. {			/* ERRORS */
		printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext);
		exit(0);
}

%%

int _main(int argc, char ** argv) {
	yylex();
	exit(0);
}
