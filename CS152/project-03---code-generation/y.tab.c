/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "mini_l.y" /* yacc.c:339  */

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

#line 126 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    IDENT = 259,
    FUNCTION = 260,
    BEGIN_PARAMS = 261,
    END_PARAMS = 262,
    BEGIN_LOCALS = 263,
    END_LOCALS = 264,
    BEGIN_BODY = 265,
    END_BODY = 266,
    INTEGER = 267,
    ARRAY = 268,
    OF = 269,
    IF = 270,
    THEN = 271,
    ENDIF = 272,
    ELSE = 273,
    WHILE = 274,
    DO = 275,
    BEGINLOOP = 276,
    ENDLOOP = 277,
    BREAK = 278,
    CONTINUE = 279,
    READ = 280,
    WRITE = 281,
    TRUE = 282,
    FALSE = 283,
    RETURN = 284,
    AND = 285,
    OR = 286,
    NOT = 287,
    ASSIGN = 288,
    SUB = 289,
    ADD = 290,
    MULT = 291,
    DIV = 292,
    MOD = 293,
    EQ = 294,
    NEQ = 295,
    LT = 296,
    GT = 297,
    LTE = 298,
    GTE = 299,
    L_PAREN = 300,
    R_PAREN = 301,
    L_SQUARE_BRACKET = 302,
    R_SQUARE_BRACKET = 303,
    SEMICOLON = 304,
    COLON = 305,
    COMMA = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 62 "mini_l.y" /* yacc.c:355  */

	int num_val;
	char* id_val;

#line 223 "y.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 240 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  7
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   144

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  29
/* YYNRULES -- Number of rules.  */
#define YYNRULES  67
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  142

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    89,    89,    91,    92,    94,   127,   134,   142,   150,
     155,   160,   161,   163,   169,   173,   179,   194,   201,   212,
     220,   231,   236,   247,   262,   267,   272,   278,   284,   292,
     300,   307,   313,   314,   317,   320,   326,   333,   347,   348,
     363,   364,   379,   392,   407,   422,   437,   452,   467,   482,
     493,   504,   507,   508,   523,   539,   540,   555,   570,   588,
     596,   601,   606,   612,   624,   625,   636,   637
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "NUMBER", "IDENT", "FUNCTION",
  "BEGIN_PARAMS", "END_PARAMS", "BEGIN_LOCALS", "END_LOCALS", "BEGIN_BODY",
  "END_BODY", "INTEGER", "ARRAY", "OF", "IF", "THEN", "ENDIF", "ELSE",
  "WHILE", "DO", "BEGINLOOP", "ENDLOOP", "BREAK", "CONTINUE", "READ",
  "WRITE", "TRUE", "FALSE", "RETURN", "AND", "OR", "NOT", "ASSIGN", "SUB",
  "ADD", "MULT", "DIV", "MOD", "EQ", "NEQ", "LT", "GT", "LTE", "GTE",
  "L_PAREN", "R_PAREN", "L_SQUARE_BRACKET", "R_SQUARE_BRACKET",
  "SEMICOLON", "COLON", "COMMA", "$accept", "prog_start", "program",
  "function", "functions", "Ident", "begin_params", "end_params",
  "declarations", "declaration", "declarationInt", "IFfunction",
  "IFELSEFunc", "WHILEFunc", "WHILEStatement", "DOWHILEfunc",
  "DOWHILEStatemnt", "statement", "varss", "Statements", "var", "BoolExp",
  "Relation_and_Exp", "RelationExp", "Expression", "MultExp", "termParen",
  "TermExp", "term", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

#define YYPACT_NINF -56

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-56)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
       2,    11,    34,     2,   -56,    -9,   -56,   -56,   -56,    39,
     -56,    73,    32,    41,    90,    69,    73,    98,   -56,   100,
      73,   -56,   -56,    72,   -56,    73,   -56,   117,   112,    74,
     113,   110,    49,   114,    29,     1,   -56,   104,   -56,   123,
     123,    18,    49,    49,     1,    49,    49,   109,    80,   119,
     -56,    18,    18,   -56,    62,   -56,   -56,     1,    18,     1,
     -56,    -4,   101,   -56,    59,    68,   -56,   -56,    85,    82,
     -56,    82,    18,    78,    97,   118,    51,   115,   116,     1,
      49,   -56,    78,    31,     5,    18,   -56,   -56,   -56,    -8,
      46,   -56,     1,     1,    18,    18,    18,    18,    18,    18,
      18,    18,    18,    18,    18,   123,   -10,   -56,   -56,   -56,
     -56,   -56,   -56,   103,   -56,   106,   -56,   -21,    94,    36,
     -56,   -56,   101,   -56,    68,    68,    78,    78,    78,    78,
      78,    78,   -56,   -56,   -56,   -56,    18,    18,   -56,   -56,
      78,   -56
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     2,     3,     0,     6,     1,     4,     0,
       9,    11,     7,     0,     0,     0,     0,     0,    10,     0,
      11,     8,    14,     0,    13,    11,    12,     0,     0,     0,
       0,     0,    34,     0,     0,     0,    18,     0,    30,     0,
       0,     0,    34,    34,     0,    34,    34,     0,     0,     0,
      15,     0,     0,    65,    36,    49,    50,     0,     0,     0,
      64,     0,    38,    40,     0,    52,    55,    20,    36,    28,
      32,    29,     0,    31,     0,     0,     0,     0,     0,     0,
      34,     5,    22,     0,     0,     0,    67,    42,    63,     0,
       0,    16,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    24,    17,    25,
      19,    26,    21,    27,    35,     0,    60,    61,     0,     0,
      51,    66,    39,    41,    54,    53,    43,    44,    45,    46,
      47,    48,    56,    57,    58,    33,     0,     0,    59,    37,
      23,    62
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -56,   -56,   -56,   133,   -56,   125,   -56,   -56,    12,   -56,
     -56,   -56,   -56,   -56,   -56,   -56,   -56,   -56,   102,   -26,
     -38,   -18,    52,   -51,   -41,    22,   -56,     6,   -55
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     3,     4,     5,    13,    11,    19,    14,    15,
      24,    42,    43,    44,    45,    46,    47,    48,    69,    49,
      60,    61,    62,    63,    64,    65,    86,   118,    66
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      73,    70,    70,    88,    53,    54,    87,     1,    53,    54,
      82,    83,    91,    94,    95,     6,    74,    75,    90,    77,
      78,    53,    54,    92,    94,    95,    76,    92,    55,    56,
     137,   106,    26,    57,     7,    58,   121,    28,   120,    58,
       9,    89,   123,   117,   119,    10,    59,   132,   133,   134,
      72,   116,    58,    34,   114,   126,   127,   128,   129,   130,
     131,   113,    51,    72,    35,    94,    95,   135,    36,    37,
      94,    95,   110,    38,    39,    40,    52,    12,    41,   115,
      94,    95,    92,    16,   139,    96,    97,    98,    99,   100,
     101,    17,   121,    94,    95,   140,   117,    18,    96,    97,
      98,    99,   100,   101,   102,   103,   104,    84,    25,    85,
      22,    23,    94,    95,   107,   108,   124,   125,    20,    27,
      29,    30,    31,    32,    33,    67,    50,    68,    79,    80,
      81,    93,    85,   105,    92,   109,     8,   111,   112,   136,
     138,    21,    71,   141,   122
};

static const yytype_uint8 yycheck[] =
{
      41,    39,    40,    58,     3,     4,    57,     5,     3,     4,
      51,    52,    16,    34,    35,     4,    42,    43,    59,    45,
      46,     3,     4,    31,    34,    35,    44,    31,    27,    28,
      51,    72,    20,    32,     0,    34,    46,    25,    46,    34,
      49,    59,    93,    84,    85,     6,    45,   102,   103,   104,
      45,    46,    34,     4,    80,    96,    97,    98,    99,   100,
     101,    79,    33,    45,    15,    34,    35,   105,    19,    20,
      34,    35,    21,    24,    25,    26,    47,     4,    29,    48,
      34,    35,    31,    51,    48,    39,    40,    41,    42,    43,
      44,    50,    46,    34,    35,   136,   137,     7,    39,    40,
      41,    42,    43,    44,    36,    37,    38,    45,     8,    47,
      12,    13,    34,    35,    17,    18,    94,    95,    49,    47,
       3,     9,    48,    10,    14,    21,    12,     4,    19,    49,
      11,    30,    47,    51,    31,    17,     3,    22,    22,    33,
      46,    16,    40,   137,    92
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     5,    53,    54,    55,    56,     4,     0,    55,    49,
       6,    58,     4,    57,    60,    61,    51,    50,     7,    59,
      49,    57,    12,    13,    62,     8,    60,    47,    60,     3,
       9,    48,    10,    14,     4,    15,    19,    20,    24,    25,
      26,    29,    63,    64,    65,    66,    67,    68,    69,    71,
      12,    33,    47,     3,     4,    27,    28,    32,    34,    45,
      72,    73,    74,    75,    76,    77,    80,    21,     4,    70,
      72,    70,    45,    76,    71,    71,    73,    71,    71,    19,
      49,    11,    76,    76,    45,    47,    78,    75,    80,    73,
      76,    16,    31,    30,    34,    35,    39,    40,    41,    42,
      43,    44,    36,    37,    38,    51,    76,    17,    18,    17,
      21,    22,    22,    73,    71,    48,    46,    76,    79,    76,
      46,    46,    74,    75,    77,    77,    76,    76,    76,    76,
      76,    76,    80,    80,    80,    72,    33,    51,    46,    48,
      76,    79
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    54,    54,    55,    56,    57,    57,    58,
      59,    60,    60,    61,    62,    62,    63,    64,    65,    66,
      67,    68,    69,    69,    69,    69,    69,    69,    69,    69,
      69,    69,    70,    70,    71,    71,    72,    72,    73,    73,
      74,    74,    75,    75,    75,    75,    75,    75,    75,    75,
      75,    75,    76,    76,    76,    77,    77,    77,    77,    78,
      78,    79,    79,    80,    80,    80,    80,    80
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,    11,     2,     1,     3,     1,
       1,     0,     3,     3,     1,     6,     3,     3,     1,     3,
       2,     3,     3,     6,     3,     3,     3,     3,     2,     2,
       1,     2,     1,     3,     0,     3,     1,     4,     1,     3,
       1,     3,     2,     3,     3,     3,     3,     3,     3,     1,
       1,     3,     1,     3,     3,     1,     3,     3,     3,     3,
       2,     1,     3,     2,     1,     1,     3,     2
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 5:
#line 95 "mini_l.y" /* yacc.c:1646  */
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
}
#line 1449 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 128 "mini_l.y" /* yacc.c:1646  */
    {
	string functions = numTostring((yyvsp[0].id_val));
	globalFunc.push_back(functions);
	myFile << "function " << functions << endl;
}
#line 1459 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 135 "mini_l.y" /* yacc.c:1646  */
    {
	string identStr = numTostring((yyvsp[0].id_val));
	globalTsymb.push_back(identStr);

	if(param)
		globalParams.push_back(identStr);
}
#line 1471 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 143 "mini_l.y" /* yacc.c:1646  */
    {
	string identStr = numTostring((yyvsp[-2].id_val));
	globalTsymb.push_back(identStr);
	symbType.push_back("INTEGER");
}
#line 1481 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 151 "mini_l.y" /* yacc.c:1646  */
    {
	param = true;  
}
#line 1489 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 156 "mini_l.y" /* yacc.c:1646  */
    {
	param = false;
}
#line 1497 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 164 "mini_l.y" /* yacc.c:1646  */
    {

}
#line 1505 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 170 "mini_l.y" /* yacc.c:1646  */
    {
	symbType.push_back("INTEGER");
}
#line 1513 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 174 "mini_l.y" /* yacc.c:1646  */
    {
	string ins = numTostring((yyvsp[-3].num_val));
	symbType.push_back(ins); 
}
#line 1522 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 180 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalIfs.push_back(actual_label);

	statementGen.push_back("?:= " + actual_label +", " + globalOpss.back());
	globalOpss.pop_back();
	statementGen.push_back(":= " + actual_label);
	statementGen.push_back(": " + actual_label);  

}
#line 1540 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 195 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back(":= " + globalIfs.back());
	statementGen.push_back(": " + globalIfs.back());

}
#line 1550 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 202 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalLoops.push_back(actual_label);

	statementGen.push_back(": " + actual_label);
}
#line 1564 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 213 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back("?:= " + globalLoops.back() + ", " + globalOpss.back());
	globalOpss.pop_back();
	statementGen.push_back(":= " + globalLoops.back());
	statementGen.push_back(": " + globalLoops.back());
}
#line 1575 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 221 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(numLabel);
	numLabel++;

	string actual_label = "__label__" + num;
	globalLoops.push_back(actual_label);

	statementGen.push_back(": " + actual_label);   
}
#line 1589 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 232 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back("?:= " + globalLoops.back());
}
#line 1597 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 237 "mini_l.y" /* yacc.c:1646  */
    {

	string id = numTostring((yyvsp[-2].id_val));
	if(!symbValidator(id))
	{
		exit(0);
	}
	statementGen.push_back("= " + id + ", " + globalOpss.back());
	globalOpss.pop_back();
}
#line 1612 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 248 "mini_l.y" /* yacc.c:1646  */
    {
	string identStr = "" + *(yyvsp[-5].id_val);
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
#line 1631 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 263 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back(": " + globalIfs.back());
	globalIfs.pop_back();
}
#line 1640 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 268 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back(": " + globalIfs.back());
	globalIfs.pop_back();
}
#line 1649 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 273 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back(":= " + globalLoops.back());
	statementGen.push_back(": " + globalLoops.back());
	globalLoops.pop_back();
}
#line 1659 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 279 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back("::= " + globalLoops.back() + ", " + globalOpss.back());
	globalOpss.pop_back();
	globalLoops.pop_back();
}
#line 1669 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 285 "mini_l.y" /* yacc.c:1646  */
    {
	string NewVar = globalTsymb.front();
	globalTsymb.erase(globalTsymb.begin());
	globalTsymb.push_back(NewVar);
	statementGen.push_back(".< " + NewVar);
	globalOpss.push_back(NewVar);
}
#line 1681 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 293 "mini_l.y" /* yacc.c:1646  */
    {
	string NewVar = globalTsymb.front();
	globalTsymb.erase(globalTsymb.begin());
	globalTsymb.push_back(NewVar);
	statementGen.push_back(".> " + NewVar);
	globalOpss.push_back(NewVar);
}
#line 1693 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 301 "mini_l.y" /* yacc.c:1646  */
    {
	if(!globalLoops.empty())
	{
		statementGen.push_back(":= " + globalLoops.back());
    }
}
#line 1704 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 308 "mini_l.y" /* yacc.c:1646  */
    {
	statementGen.push_back("ret " + globalOpss.back());
	globalOpss.pop_back();
}
#line 1713 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 317 "mini_l.y" /* yacc.c:1646  */
    {
   
}
#line 1721 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 321 "mini_l.y" /* yacc.c:1646  */
    {

}
#line 1729 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 327 "mini_l.y" /* yacc.c:1646  */
    {
	string t = numTostring((yyvsp[0].id_val));
	if(!symbValidator(t))
		exit(0);
	globalOpss.push_back(t);
}
#line 1740 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 334 "mini_l.y" /* yacc.c:1646  */
    {
	string tmp = globalOpss.back();
   
	string tmp_2 = numTostring((yyvsp[-3].id_val));
	globalOpss.pop_back();
	if(!arrValidator(tmp_2))
		exit(0);
	globalOpss.push_back("[] " + tmp_2 + ", " + tmp);
   
}
#line 1755 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 349 "mini_l.y" /* yacc.c:1646  */
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
}
#line 1773 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 365 "mini_l.y" /* yacc.c:1646  */
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
}
#line 1791 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 380 "mini_l.y" /* yacc.c:1646  */
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
#line 1808 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 393 "mini_l.y" /* yacc.c:1646  */
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
#line 1827 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 408 "mini_l.y" /* yacc.c:1646  */
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
#line 1846 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 423 "mini_l.y" /* yacc.c:1646  */
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
#line 1865 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 438 "mini_l.y" /* yacc.c:1646  */
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
#line 1884 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 453 "mini_l.y" /* yacc.c:1646  */
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
#line 1903 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 468 "mini_l.y" /* yacc.c:1646  */
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
#line 1922 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 483 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", 1");
	globalOpss.push_back(NewVar);    
}
#line 1937 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 494 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", 0");
	globalOpss.push_back(NewVar);       
}
#line 1952 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 509 "mini_l.y" /* yacc.c:1646  */
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
#line 1971 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 524 "mini_l.y" /* yacc.c:1646  */
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
}
#line 1990 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 541 "mini_l.y" /* yacc.c:1646  */
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
#line 2009 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 556 "mini_l.y" /* yacc.c:1646  */
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
#line 2028 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 571 "mini_l.y" /* yacc.c:1646  */
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
}
#line 2048 "y.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 589 "mini_l.y" /* yacc.c:1646  */
    {
	while(!stackParams.empty())
	{
		statementGen.push_back("param " + stackParams.top());
		stackParams.pop();
	}
}
#line 2060 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 597 "mini_l.y" /* yacc.c:1646  */
    {
   
}
#line 2068 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 602 "mini_l.y" /* yacc.c:1646  */
    {
	stackParams.push(globalOpss.back());
	globalOpss.pop_back();
}
#line 2077 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 607 "mini_l.y" /* yacc.c:1646  */
    {
	stackParams.push(globalOpss.back());
	globalOpss.pop_back();
}
#line 2086 "y.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 613 "mini_l.y" /* yacc.c:1646  */
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
#line 2102 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 626 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");

	statementGen.push_back("= " + NewVar + ", " + numTostring((yyvsp[0].num_val)));
	globalOpss.push_back(NewVar);  
}
#line 2117 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 638 "mini_l.y" /* yacc.c:1646  */
    {
	string num = numTostring(varNum);
	varNum++;
	string NewVar = "__temp__" + num;
	globalTsymb.push_back(NewVar);
	symbType.push_back("INTEGER");
	if(!funcValidator(numTostring((yyvsp[-1].id_val))))
		exit(0);
	statementGen.push_back("call " + numTostring((yyvsp[-1].id_val)) + ", " + NewVar);
	globalOpss.push_back(NewVar); 
}
#line 2133 "y.tab.c" /* yacc.c:1646  */
    break;


#line 2137 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 650 "mini_l.y" /* yacc.c:1906  */




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
