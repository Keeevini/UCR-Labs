%{
	#define YY_NO_UNPUT

	#include <iostream>
	#include <stdio.h>
	#include <fstream>
	#include <stdlib.h>
	#include <vector>
	#include <stack>
	#include <string>
	#include <iterator>
	#include <sstream>
	#include <list>
	#include <queue>
	
	using namespace std;

	int yyerror(const char *s);

	extern FILE * yyin;

	int yylex(void);


	void symbolPrint();
	bool symbValidator(string);
	bool funcValidator(string);
	bool arrValidator(string);


	string outFile;
	ofstream myFile;
	bool param = false;
	int paramVal;
	int numLabel;
	int varNum;

	extern int currLine;
	extern int currPos;

	vector<string> globalFunc;
	vector<string> globalParams;
	vector<string> globalOpss;
	vector<string> globalIfs;
	vector<string> globalLoops;
	stack<string> stackParams;
	vector<string> statementGen;
	vector<string> globalTsymb;
	vector<string> symbType;


	template <typename T>
	string numTostring ( T Convert ) 
	{
		ostringstream ss;
		ss << Convert;
		return ss.str();
	}
%}


%union{
	int num_val;
	char* id_val;
}


%error-verbose
%start prog_start

%token <num_val> NUMBER
%token <id_val> IDENT

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP BREAK CONTINUE
%token READ WRITE TRUE FALSE RETURN 

%left AND OR
%right NOT ASSIGN

%left SUB ADD MULT DIV MOD
%left EQ NEQ LT GT LTE GTE 

%token L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET
%token SEMICOLON COLON COMMA

%%

prog_start : program;

program : function ;
		| program function ;

function : functions SEMICOLON begin_params declarations end_params BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY Statements END_BODY
{

	myFile.open("mini.mil");
	myFile << "func " << globalFunc.back() << endl;
	for (unsigned int i = 0; i < globalTsymb.size();i++)
	{
		if(symbType.at(i) == "INTEGER")
			myFile << ". " << globalTsymb.at(i) << endl;
		else
			myFile << ".[] " << globalTsymb.at(i) << ", " << symbType.at(i) << endl;
	}
	while (!globalParams.empty())
	{
		myFile << "= " << globalParams.front() << ",  $" << paramVal << endl;
		paramVal++;
		globalParams.erase(globalParams.begin());
	}

	for (unsigned i = 0; i < statementGen.size(); i++)
	{
		myFile << statementGen.at(i) << endl;
	}

 
	globalParams.clear();
	statementGen.clear();
	globalTsymb.clear();
	symbType.clear();
	paramVal = 0;
	myFile << "endfunc" << endl;
};

functions : FUNCTION IDENT
{
	string functions = numTostring($2);
	globalFunc.push_back(functions);
	myFile << "function " << functions << endl;
};

Ident : IDENT
{
	string identStr = numTostring($1);
	globalTsymb.push_back(identStr);

	if(param)
		globalParams.push_back(identStr);
}
	| IDENT COMMA Ident 
{
	string identStr = numTostring($1);
	globalTsymb.push_back(identStr);
	symbType.push_back("INTEGER");
};


begin_params: BEGIN_PARAMS
{
	param = true;  
};

end_params: END_PARAMS
{
	param = false;
};

declarations : 
	| declaration SEMICOLON declarations ;

declaration : Ident COLON declarationInt
{

};


declarationInt : INTEGER
{
	symbType.push_back("INTEGER");
}
	| ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
{
	string ins = numTostring($3);
	symbType.push_back(ins); 
};

IFfunction: IF BoolExp THEN
{
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalIfs.push_back(actual_label);

	statementGen.push_back("?:= " + actual_label +", " + globalOpss.back());
	globalOpss.pop_back();
	statementGen.push_back(":= " + actual_label);
	statementGen.push_back(": " + actual_label);  

};

IFELSEFunc: IFfunction Statements ELSE
{
	statementGen.push_back(":= " + globalIfs.back());
	statementGen.push_back(": " + globalIfs.back());

};

WHILEFunc: WHILE
{
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalLoops.push_back(actual_label);

	statementGen.push_back(": " + actual_label);
};

WHILEStatement: WHILEFunc BoolExp BEGINLOOP
{
	statementGen.push_back("?:= " + globalLoops.back() + ", " + globalOpss.back());
	globalOpss.pop_back();
	statementGen.push_back(":= " + globalLoops.back());
	statementGen.push_back(": " + globalLoops.back());
};

DOWHILEfunc: DO BEGINLOOP
{
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalLoops.push_back(actual_label);

	statementGen.push_back(": " + actual_label);   
};

DOWHILEStatemnt: DOWHILEfunc Statements ENDLOOP
{
	statementGen.push_back("?:= " + globalLoops.back());
};

statement : IDENT ASSIGN Expression
{

	string id = numTostring($1);
	if(!symbValidator(id))
	{
		exit(0);
	}
	statementGen.push_back("= " + id + ", " + globalOpss.back());
	globalOpss.pop_back();
}
	| IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET ASSIGN Expression
{
	string identStr = "" + *$1;
	string id = identStr;
	if(!arrValidator(id))
	{
		exit(0);
	}
	string array_op_1 = globalOpss.back();
	globalOpss.pop_back();
	string array_op_2 = globalOpss.back();
	globalOpss.pop_back();
	statementGen.push_back("[] = _" + identStr +", " + array_op_2 + ", " + array_op_1);

}
	| IFfunction Statements ENDIF
{
	statementGen.push_back(": " + globalIfs.back());
	globalIfs.pop_back();
}
	| IFELSEFunc Statements ENDIF
{
	statementGen.push_back(": " + globalIfs.back());
	globalIfs.pop_back();
}
	| WHILEStatement Statements ENDLOOP
{
	statementGen.push_back(":= " + globalLoops.back());
	statementGen.push_back(": " + globalLoops.back());
	globalLoops.pop_back();
}
	| DOWHILEStatemnt WHILE BoolExp
{
	statementGen.push_back("::= " + globalLoops.back() + ", " + globalOpss.back());
	globalOpss.pop_back();
	globalLoops.pop_back();
}
	| READ varss 
{
	string NewVar = globalTsymb.front();
	globalTsymb.erase(globalTsymb.begin());
	globalTsymb.push_back(NewVar);
	statementGen.push_back(".< " + NewVar);
	globalOpss.push_back(NewVar);
}
	| WRITE varss
{
	string NewVar = globalTsymb.front();
	globalTsymb.erase(globalTsymb.begin());
	globalTsymb.push_back(NewVar);
	statementGen.push_back(".> " + NewVar);
	globalOpss.push_back(NewVar);
}
	| CONTINUE
{
	if(!globalLoops.empty())
	{
		statementGen.push_back(":= " + globalLoops.back());
    }
}
	| RETURN Expression
{
	statementGen.push_back("ret " + globalOpss.back());
	globalOpss.pop_back();
};

varss : var 
	| varss COMMA var ;

Statements :
{
   
}
	| statement SEMICOLON Statements
{

};


var : IDENT 
{
	string t = numTostring($1);
	if(!symbValidator(t))
		exit(0);
	globalOpss.push_back(t);
}
	| IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
{
	string tmp = globalOpss.back();
   
	string tmp_2 = numTostring($1);
	globalOpss.pop_back();
	if(!arrValidator(tmp_2))
		exit(0);
	globalOpss.push_back("[] " + tmp_2 + ", " + tmp);
   
};



BoolExp : Relation_and_Exp 
	| BoolExp OR Relation_and_Exp
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("|| " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back();
};

Relation_and_Exp : RelationExp
	| Relation_and_Exp AND RelationExp 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("&& " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back();   
};

RelationExp : NOT RelationExp
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string t = globalOpss.back();
	globalOpss.pop_back();
	statementGen.push_back("! " + NewVar + ", " + t);
	globalOpss.push_back(NewVar); 
}
	| Expression EQ Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("== " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);
}
	| Expression NEQ Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("!= " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);   
}
	| Expression LT Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("< " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);   
}
	| Expression GT Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("> " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);   
}
	| Expression LTE Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("<= " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);   
}
	| Expression GTE Expression 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back(">= " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);   
}
	| TRUE
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", 1");
	globalOpss.push_back(NewVar);    
}
	| FALSE 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", 0");
	globalOpss.push_back(NewVar);       
}
	| L_PAREN BoolExp R_PAREN ;


Expression : MultExp
	| Expression ADD MultExp 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("+ " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);    
}
	| Expression SUB MultExp 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("- " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);     
};

MultExp : term
	| MultExp MULT term 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("* " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);  
}
	| MultExp DIV term 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
	statementGen.push_back("/ " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);  
}
	| MultExp MOD term 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");
	string tmp_2 = globalOpss.back();
	globalOpss.pop_back();
	string tmp = globalOpss.back();
 

	statementGen.push_back("% " + NewVar + ", " + tmp + ", " + tmp_2);
	globalOpss.pop_back(); 
	globalOpss.push_back(NewVar);     
};


termParen: L_PAREN TermExp R_PAREN
{
	while(!stackParams.empty())
	{
		statementGen.push_back("param " + stackParams.top());
		stackParams.pop();
	}
}
	| L_PAREN R_PAREN
{
   
}

TermExp: Expression
{
	stackParams.push(globalOpss.back());
	globalOpss.pop_back();
}
	| Expression COMMA TermExp
{
	stackParams.push(globalOpss.back());
	globalOpss.pop_back();
};

term : SUB term 
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");
	
	statementGen.push_back("- " + NewVar + ", 0 " + globalOpss.back());
	globalOpss.pop_back();
	globalOpss.push_back(NewVar);  
}
	| var
	| NUMBER
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", " + numTostring($1));
	globalOpss.push_back(NewVar);  
}
	| L_PAREN Expression R_PAREN
	| IDENT termParen
{
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");
	if(!funcValidator(numTostring($1)))
		exit(0);
	statementGen.push_back("call " + numTostring($1) + ", " + NewVar);
	globalOpss.push_back(NewVar); 
};

%%



int main(int argc, char **argv){
	if (argc > 1){
        yyin = fopen(argv[1], "r");
		if(yyin == NULL){
            printf("syntax: %s filename\n", argv[0]);
        }
    }
    yyparse();
    return 0;
}

int yyerror(const char *s){
    extern char* yytext;

    printf("Error symbol: \"%s\" on line %d\n", s, yytext, currLine);

    exit(0);
    return 0;
}

void symbolPrint()
{  
	cout << "Start: " << endl;
	for (unsigned i = 0; i < globalTsymb.size(); i++)
	{
		cout << globalTsymb.at(i) << endl;
	}
	cout << "End" << endl;
}

bool funcValidator(string id)
{
	unsigned i = 0;
	bool tempBool = false;
	while(i < globalFunc.size() && tempBool != true)
	{
	if(globalFunc.at(i) == id)
		tempBool = true;
		i++;
   }
	if(!tempBool){
		cout << "Semantic(funcval) error at line " << currLine << ", column " << currPos << endl;}
	return tempBool;
}

bool arrValidator(string id)
{
	unsigned i = 0;
	bool tempBool = false;
	while(i < globalTsymb.size() && tempBool != true)
	{

		if(globalTsymb.at(i) == id)
		{

			if(symbType.at(i) != "INTEGER")
			{
				tempBool = true;

			}
			else
			{
				cout << "Semantic(array) error at line " << currLine << ", column " << currPos << endl;
				tempBool = false;
			}
		}
		i++;
	}
	if(!tempBool){
		cout << "Semantic(array) error at line " << currLine << ", column " << currPos << endl;}
	return tempBool;

}

bool symbValidator(string id)
{
	unsigned i = 0;
	bool tempBool = false;
	while (i < globalTsymb.size() && tempBool != true)
	{
		if(globalTsymb.at(i) == id)
		{
         
			if(symbType.at(i) != "INTEGER")
			{
				cout << "Semantic(symbol not int) error at line " << currLine << ", column " << currPos << endl;
            
			}
			else
			{

				tempBool = true;
			}
		}
		i++;
	}
	if(!tempBool){
		cout << "Semantic(symbol) error at line " << currLine << ", column " << currPos << endl;}
	return tempBool;
}
