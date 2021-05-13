%{
	#include <math.h>
	int currLine = 1, currPos = 1;
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
		printf("FUNCTION\n");
		currPos += yyleng;
}

beginparams {
		printf("BEGIN_PARAMS\n");
		currPos += yyleng;
}

endparams {
		printf("END_PARAMS\n");
		currPos += yyleng;
}

beginlocals {
		printf("BEGIN_LOCALS\n");
		currPos += yyleng;
}

endlocals {
		printf("END_LOCALS\n");
		currPos += yyleng;
}

beginbody {
		printf("BEGIN_BODY\n");
		currPos += yyleng;
}

endbody {
		printf("END_BODY\n");
		currPos += yyleng;
}

integer {
		printf("INTEGER\n");
		currPos += yyleng;
}

array {
		printf("ARRAY\n");
		currPos += yyleng;
}

of {
		printf("OF\n");
		currPos += yyleng;
}

if {
		printf("IF\n");
		currPos += yyleng;
}

then {
		printf("THEN\n");
		currPos += yyleng;
}

endif {
		printf("ENDIF\n");
		currPos += yyleng;
}

else {
		printf("ELSE\n");
		currPos += yyleng;
}

while {
		printf("WHILE\n");
		currPos += yyleng;
}

do {
		printf("DO\n");
		currPos += yyleng;
}

beginloop {
		printf("BEGINLOOP\n");
		currPos += yyleng;
}

endloop {
		printf("ENDLOOP\n");
		currPos += yyleng;
}

break {
		printf("BREAK\n");
		currPos += yyleng;

}

read {
		printf("READ\n");
		currPos += yyleng;
}

write {
		printf("WRITE\n");
		currPos += yyleng;
}

"(" {	/* Precedence 0 */
		printf("L_PAREN\n");
		currPos += yyleng;
}

")" {
		printf("R_PAREN\n");
		currPos += yyleng;
}

"[" {	/* Precedence 1 */
		printf("L_SQUARE_BRACKET\n");
		currPos += yyleng;
}

"]" {
		printf("R_SQUARE_BRACKET\n");
		currPos += yyleng;
}

"*" {	/* Precedence 3 */
		printf("MULT\n");
		currPos += yyleng;
}

"/" {
		printf("DIV\n");
		currPos += yyleng;
}

"%" {
		printf("MOD\n");
		currPos += yyleng;
}

"-" {	/* Precedence 4 */
		printf("SUB\n");
		currPos += yyleng;
}

"+" {
		printf("ADD\n");
		currPos += yyleng;
}

"==" {	/* Precedence 5 */
		printf("EQ\n");
		currPos += yyleng;
}

"<>" {
		printf("NEQ\n");
		currPos += yyleng;
}

"<" {
		printf("LT\n");
		currPos += yyleng;
}

">" {
		printf("GT\n");
		currPos += yyleng;
}

"<=" {
		printf("LTE\n");
		currPos += yyleng;
}

">=" {
		printf("GTE\n");
		currPos += yyleng;
}

not {	/* Precedence 6 */
		printf("NOT\n");
		currPos += yyleng;
}

and {	/* Precedence 7 */
		printf("AND\n");
		currPos += yyleng;
}

or {	/* Precedence 8 */
		printf("OR\n");
		currPos += yyleng;
}

true {
		printf("TRUE\n");
		currPos += yyleng;
}

false {
		printf("FALSE\n");
		currPos += yyleng;
}

return {
		printf("RETURN\n");
		currPos += yyleng;
}

";" {
		printf("SEMICOLON\n");
		currPos += yyleng;
}

":" {
		printf("COLON\n");
		currPos += yyleng;
}

"," {
		printf("COMMA\n");
		currPos += yyleng;
}

":=" {	/* Precedence 9 */
		printf("ASSIGN\n");
		currPos += yyleng;
}

[ \t]+ {
		currPos += yyleng;
}

"\n" {
		currLine++;
		currPos = 1;
}

{ID} {
		printf("IDENT %s\n", yytext);
		currPos += yyleng;
}

{DIGIT}+ {
		printf("NUMBER %s\n", yytext);
		currPos += yyleng;
}

{UNDERSCORE} {		/* ERRORS */
			printf("Error at line %d, column %d: identifier \"%s\" cannot end with underscore\n", currLine, currPos, yytext);
}

{LETTER_START} {	/* ERRORS */
			printf("Error at line %d, column %d: identifier \"%s\" must begin wtih a letter\n", currLine, currPos, yytext);
}

. {			/* ERRORS */
			printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext);
}

%%

int main(int argc, char ** argv) {
	if (argc >= 2) {
		yyin = fopen(argv[1], "r");
		if(yyin == NULL) {
			yyin = stdin;
		}
	}
	else {
		yyin = stdin;
	}
	yylex();
}

