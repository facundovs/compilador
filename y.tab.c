
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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
#define YYBISON_VERSION "2.4.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 2 "Sintactico.y"

//////////////////////INCLUDES//////////////////////////////////////
	#include <stdio.h>
	#include <stdlib.h>
	#include <conio.h>
	#include "y.tab.h"
	#include <string.h>
	#include <float.h>
	#include <math.h>
	//#include <graphics.h>
///////////////////// ENUMS ////////////////////////////////////////
	enum tiposDeError{
		ErrorSintactico,
		ErrorLexico
	};

	enum errores{
		ErrorIntFueraDeRango,
		ErrorStringFueraDeRango,
		ErrorEnDeclaracionCantidad,
		ErrorIdRepetida,
		ErrorIdNoDeclarado,
		ErrorIdDistintoTipo,
		ErrorAllEqual,
		ErrorRead,
		ErrorConstanteDistintoTipo,
		ErrorOperacionNoValida,
		ErrorFloatFueraDeRango
	};

	enum tiposDeDatos{
		TipoEntero,
		TipoReal,
		TipoCadena
	};

	enum valoresMaximos{
		ENTERO_MAXIMO = 32768,
		CADENA_MAXIMA = 30,
		TAM = 100
	};
///////////////////// ESTRUCUTURAS  ////////////////////////////////
	typedef struct{
		char nombre[33];
		char valor[33];
		char tipo[33];
		int longitud;
	} registro; 

	typedef struct{
		int nombre;
		int valor;
		int tipo;
		int longitud;
	} indices;

	typedef struct
	{
		char valor[31];
	}t_info;

	typedef struct s_nodo
	{
	    t_info info;
	    struct s_nodo *izq;
	    struct s_nodo *der;
	}t_nodo;

	typedef struct s_nodoPila{
    	t_nodo info;
    	struct s_nodoPila* psig;
	}t_nodoPila;

	typedef t_nodoPila *t_pila;
///////////////////// DECLARACION DE FUNCIONES /////////////////////
	int yyerrormsj(const char *,int,int); 
	void imprimirVariables();
	int existeId(char *);
	int yyerror();
	int obtenerTipo(int);
	int longLEsValidas();
	void limpiarVector(int *,int);
	char * obtenerTipoLiteral(int);
	void grabarTablaDeSimbolos(int);
	int existeCte();
	void insertarHijo(t_nodo ** , t_nodo * );
	t_nodo * crearHoja(const t_info *);
	t_nodo * crearNodo(const t_info *, t_nodo *, t_nodo *);
	void recorrer_en_orden(const t_nodo*);
	void recorrer_guardando(const t_nodo*, FILE*);
	void grabarArbol(t_nodo*);
	//void dibujar(t_nodo*,int,int,int,int);
	void crearPila(t_pila* );
	int ponerEnPila(t_pila*,t_nodo*);
	int sacar_de_pila(t_pila*,t_nodo*);
	void vaciarPila(t_pila*);
	t_nodo * sacar_de_pila2(t_pila *);
	int elementosEnPilaWhile =0;
	int elementosEnPilaIf =0;
///////////////////// DECLARACION DE PUNTEROS GCI //////////////////
	t_nodo * programa;
	t_nodo * bloque_declaraciones;
	t_nodo * declaraciones;
	t_nodo * declaracion;
	t_nodo * bloque_sentencias;
	t_nodo * sentencia;
	t_nodo * lista_variables;
	t_nodo * lista_var_filter;
	t_nodo * lista_tipo;
	t_nodo * tipo;
	t_nodo * bloque_if;
	t_nodo * sentencia_if;
	t_nodo * sentencia_while;
	t_nodo * read;
	t_nodo * write;
	t_nodo * condicion;
	t_nodo * filter;
	t_nodo * condicion_filter;
	t_nodo * all_equal;
	t_nodo * lista_exp;
	t_nodo * expresiones;
	t_nodo * and_or;
	t_nodo * comparacion;
	t_nodo * asignacion;
	t_nodo * expresion;
	t_nodo * termino;
	t_nodo * factor;
///////////////////// DECLARACION DE VARIABLES GLOBALES //////////// 
	int tipoAsignacion;
	int esAsignacion=0;
	char ultimoId [30];
	registro tablaVariables[TAM];
	registro tablaConstantes[TAM];
	extern int yylineno;
	indices indicesVariable= {0,0,0};
	int indiceConstante=0;
	int yystopparser=0;
	int  contadorDeIds=0;
	int contadorDeTipos=0;
	int cantExpLE[TAM];
	int contadorListaExp=0;
	FILE  *yyin;
	char *yyltext;
	char *yytext;
	t_pila pilaWhile;
	t_pila pilaIf;
	t_pila pilabloques;
	t_pila pilabloqueif;
	t_pila pilaFilter;
	t_nodo comparacion1;



/* Line 189 of yacc.c  */
#line 227 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     CADENA = 259,
     ENTERO = 260,
     REAL = 261,
     COMILLA = 262,
     COMA = 263,
     C_A = 264,
     C_C = 265,
     P_C = 266,
     P_A = 267,
     GB = 268,
     OP_CONCAT = 269,
     ASIG = 270,
     OP_DIV = 271,
     OP_MUL = 272,
     OP_RESTA = 273,
     OP_SUMA = 274,
     COMPARADOR = 275,
     AND = 276,
     OR = 277,
     OP_NOT = 278,
     CONST_REAL = 279,
     CONST_CADENA = 280,
     CONST_ENTERO = 281,
     PROGRAMA = 282,
     FIN_PROGRAMA = 283,
     DECLARACIONES = 284,
     FIN_DECLARACIONES = 285,
     DIM = 286,
     AS = 287,
     IF = 288,
     ELSE = 289,
     THEN = 290,
     ENDIF = 291,
     WHILE = 292,
     ENDWHILE = 293,
     ALLEQUAL = 294,
     WRITE = 295,
     READ = 296,
     FILTER = 297
   };
#endif
/* Tokens.  */
#define ID 258
#define CADENA 259
#define ENTERO 260
#define REAL 261
#define COMILLA 262
#define COMA 263
#define C_A 264
#define C_C 265
#define P_C 266
#define P_A 267
#define GB 268
#define OP_CONCAT 269
#define ASIG 270
#define OP_DIV 271
#define OP_MUL 272
#define OP_RESTA 273
#define OP_SUMA 274
#define COMPARADOR 275
#define AND 276
#define OR 277
#define OP_NOT 278
#define CONST_REAL 279
#define CONST_CADENA 280
#define CONST_ENTERO 281
#define PROGRAMA 282
#define FIN_PROGRAMA 283
#define DECLARACIONES 284
#define FIN_DECLARACIONES 285
#define DIM 286
#define AS 287
#define IF 288
#define ELSE 289
#define THEN 290
#define ENDIF 291
#define WHILE 292
#define ENDWHILE 293
#define ALLEQUAL 294
#define WRITE 295
#define READ 296
#define FILTER 297




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 214 of yacc.c  */
#line 155 "Sintactico.y"

	int entero;
	double real;
	char cadena[50];



/* Line 214 of yacc.c  */
#line 355 "y.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 367 "y.tab.c"

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
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
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
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
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
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
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
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
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

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   142

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  43
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  47
/* YYNRULES -- Number of rules.  */
#define YYNRULES  82
/* YYNRULES -- Number of states.  */
#define YYNSTATES  146

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   297

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
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
      35,    36,    37,    38,    39,    40,    41,    42
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     4,    10,    11,    16,    18,    21,    30,
      32,    33,    38,    40,    42,    44,    46,    47,    52,    54,
      57,    59,    61,    63,    65,    67,    68,    76,    77,    85,
      87,    88,    93,    94,    99,   101,   103,   106,   109,   113,
     114,   119,   120,   125,   127,   131,   135,   137,   141,   142,
     148,   149,   159,   160,   164,   167,   168,   172,   176,   177,
     184,   186,   187,   192,   194,   196,   197,   202,   204,   205,
     210,   214,   218,   220,   224,   228,   230,   232,   235,   237,
     240,   242,   246
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      44,     0,    -1,    -1,    27,    45,    46,    55,    28,    -1,
      -1,    29,    47,    48,    30,    -1,    49,    -1,    48,    49,
      -1,    31,     9,    50,    10,    32,     9,    53,    10,    -1,
       3,    -1,    -1,     3,    51,     8,    50,    -1,     5,    -1,
       6,    -1,     4,    -1,    52,    -1,    -1,    52,    54,     8,
      53,    -1,    56,    -1,    55,    56,    -1,    75,    -1,    77,
      -1,    84,    -1,    57,    -1,    59,    -1,    -1,    33,    12,
      65,    11,    58,    61,    36,    -1,    -1,    37,    12,    65,
      11,    60,    55,    38,    -1,    55,    -1,    -1,    55,    62,
      34,    55,    -1,    -1,    86,    20,    64,    86,    -1,    71,
      -1,    63,    -1,    23,    71,    -1,    23,    63,    -1,    71,
      83,    71,    -1,    -1,    63,    66,    83,    63,    -1,    -1,
      13,    20,    68,    86,    -1,    67,    -1,    23,    13,    67,
      -1,    67,    83,    67,    -1,     3,    -1,    70,     8,     3,
      -1,    -1,    72,    39,    12,    79,    11,    -1,    -1,    42,
      12,    69,     8,    74,     9,    70,    10,    11,    -1,    -1,
      40,    76,    25,    -1,    40,     3,    -1,    -1,    41,    78,
       3,    -1,     9,    81,    10,    -1,    -1,     9,    81,    10,
      80,     8,    79,    -1,    86,    -1,    -1,    86,    82,     8,
      81,    -1,    21,    -1,    22,    -1,    -1,     3,    85,    15,
      86,    -1,    88,    -1,    -1,    86,    18,    87,    88,    -1,
      86,    19,    88,    -1,    86,    14,    88,    -1,    89,    -1,
      88,    17,    89,    -1,    88,    16,    89,    -1,     3,    -1,
      26,    -1,    18,    26,    -1,    24,    -1,    18,    24,    -1,
      25,    -1,    12,    86,    11,    -1,    73,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   186,   186,   186,   201,   201,   207,   208,   212,   221,
     229,   229,   238,   239,   240,   244,   245,   245,   249,   250,
     258,   259,   260,   261,   262,   267,   266,   291,   290,   315,
     320,   320,   334,   334,   342,   343,   344,   345,   361,   363,
     362,   384,   384,   393,   394,   408,   412,   446,   487,   487,
     497,   496,   510,   510,   511,   520,   519,   529,   530,   530,
     534,   535,   535,   539,   544,   552,   552,   573,   575,   574,
     593,   604,   618,   619,   625,   634,   647,   669,   693,   714,
     737,   758,   759
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "CADENA", "ENTERO", "REAL",
  "COMILLA", "COMA", "C_A", "C_C", "P_C", "P_A", "GB", "OP_CONCAT", "ASIG",
  "OP_DIV", "OP_MUL", "OP_RESTA", "OP_SUMA", "COMPARADOR", "AND", "OR",
  "OP_NOT", "CONST_REAL", "CONST_CADENA", "CONST_ENTERO", "PROGRAMA",
  "FIN_PROGRAMA", "DECLARACIONES", "FIN_DECLARACIONES", "DIM", "AS", "IF",
  "ELSE", "THEN", "ENDIF", "WHILE", "ENDWHILE", "ALLEQUAL", "WRITE",
  "READ", "FILTER", "$accept", "programa", "$@1", "bloque_declaraciones",
  "$@2", "declaraciones", "declaracion", "lista_var", "$@3", "tipo",
  "lista_tipo", "$@4", "bloque_sentencias", "sentencia", "sentencia_if",
  "$@5", "sentencia_while", "$@6", "bloque_if", "$@7", "comparacion",
  "$@8", "condicion", "$@9", "comparacion_filter", "$@10",
  "condicion_filter", "lista_var_filter", "allequal", "$@11", "filter",
  "$@12", "write", "$@13", "read", "@14", "lista_exp", "$@15",
  "expresiones", "$@16", "and_or", "asignacion", "$@17", "expresion",
  "$@18", "termino", "factor", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    43,    45,    44,    47,    46,    48,    48,    49,    50,
      51,    50,    52,    52,    52,    53,    54,    53,    55,    55,
      56,    56,    56,    56,    56,    58,    57,    60,    59,    61,
      62,    61,    64,    63,    65,    65,    65,    65,    65,    66,
      65,    68,    67,    69,    69,    69,    70,    70,    72,    71,
      74,    73,    76,    75,    75,    78,    77,    79,    80,    79,
      81,    82,    81,    83,    83,    85,    84,    86,    87,    86,
      86,    86,    88,    88,    88,    89,    89,    89,    89,    89,
      89,    89,    89
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     5,     0,     4,     1,     2,     8,     1,
       0,     4,     1,     1,     1,     1,     0,     4,     1,     2,
       1,     1,     1,     1,     1,     0,     7,     0,     7,     1,
       0,     4,     0,     4,     1,     1,     2,     2,     3,     0,
       4,     0,     4,     1,     3,     3,     1,     3,     0,     5,
       0,     9,     0,     3,     2,     0,     3,     3,     0,     6,
       1,     0,     4,     1,     1,     0,     4,     1,     0,     4,
       3,     3,     1,     3,     3,     1,     1,     2,     1,     2,
       1,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     2,     0,     0,     1,     4,     0,     0,    65,     0,
       0,    52,    55,     0,    18,    23,    24,    20,    21,    22,
       0,     0,     6,     0,    48,    48,    54,     0,     0,     3,
      19,     0,     5,     7,     0,    75,     0,     0,    48,    78,
      80,    76,     0,    39,     0,    34,     0,    82,     0,    67,
      72,     0,    53,    56,     9,     0,    66,     0,    79,    77,
      37,    36,     0,     0,    25,    63,    64,    48,     0,     0,
      68,     0,    32,     0,     0,    27,     0,     0,    81,     0,
       0,    43,     0,     0,     0,    38,     0,    71,     0,    70,
       0,    74,    73,     0,     0,     0,    41,     0,     0,    50,
      40,    29,     0,     0,     0,    69,    33,     0,    11,     0,
       0,    44,    45,     0,     0,    26,     0,    60,    49,    28,
      14,    12,    13,    15,     0,    42,     0,     0,    57,     0,
       0,     8,    46,     0,    31,     0,     0,     0,     0,     0,
       0,    62,    17,    47,    51,    59
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,     6,     7,    21,    22,    55,    76,   123,
     124,   130,    13,    14,    15,    84,    16,    93,   102,   114,
      43,    90,    44,    63,    81,   110,    82,   133,    45,    46,
      47,   113,    17,    27,    18,    28,   104,   135,   116,   129,
      67,    19,    23,    48,    88,    49,    50
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -80
static const yytype_int16 yypact[] =
{
     -19,   -80,    17,   -17,   -80,   -80,    34,    -8,   -80,    32,
      38,    57,   -80,    12,   -80,   -80,   -80,   -80,   -80,   -80,
      45,     2,   -80,    48,     1,     1,   -80,    56,    87,   -80,
     -80,    95,   -80,   -80,     4,   -80,     4,   -15,     4,   -80,
     -80,   -80,    90,    96,    97,    51,    67,   -80,    81,    25,
     -80,    98,   -80,   -80,   102,   101,    20,    78,   -80,   -80,
     -80,   -80,    -3,    51,   -80,   -80,   -80,   -80,   100,     4,
     -80,     4,   -80,     4,     4,   -80,   105,    82,   -80,    99,
     103,    51,   107,     4,    34,   -80,   108,    25,     4,    25,
       4,   -80,   -80,    34,    95,   109,   -80,   110,   110,   -80,
     -80,    28,    84,     4,   111,    25,    20,    18,   -80,    74,
       4,   -80,   -80,   115,    91,   -80,   116,    68,   -80,   -80,
     -80,   -80,   -80,   119,   118,    20,   126,    34,   122,   123,
     124,   -80,   -80,    83,    34,   125,     4,    74,   131,   127,
     108,   -80,   -80,   -80,   -80,   -80
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -80,   -80,   -80,   -80,   -80,   -80,   114,    42,   -80,   -80,
       0,   -80,   -79,   -13,   -80,   -80,   -80,   -80,   -80,   -80,
     -36,   -80,   117,   -80,     7,   -80,   -80,   -80,   -32,   -80,
     -80,   -80,   -80,   -80,   -80,   -80,    -1,   -80,     5,   -80,
     -45,   -80,   -80,   -33,   -80,    -5,    11
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -62
static const yytype_int16 yytable[] =
{
      30,    56,    60,    57,    35,   101,    61,    35,     1,    58,
      79,    59,     5,    36,   107,     8,    36,     4,    83,    37,
      80,     8,    37,    20,    38,    39,    40,    41,    39,    40,
      41,     8,    32,    20,    69,    85,    98,     8,    70,    71,
      29,    73,    74,    42,    24,     9,    42,   100,   134,    10,
      25,     9,    11,    12,    31,    10,   119,   106,    11,    12,
      26,     9,   -30,    34,    87,    10,    89,     9,    11,    12,
     117,    10,    65,    66,    11,    12,   -61,   125,   120,   121,
     122,    52,    69,   105,    91,    92,    70,    71,    30,    78,
      53,   138,    69,   139,    30,    69,    70,    71,    54,    70,
      71,    72,    62,   117,   111,   112,    68,   -35,    64,    75,
     -10,    77,    86,    94,    95,    99,    97,   103,   109,    96,
     115,    30,   118,    79,   126,   127,   128,   -16,   131,   132,
     -58,   136,   137,   140,   143,    33,   108,   142,   144,   145,
       0,   141,    51
};

static const yytype_int16 yycheck[] =
{
      13,    34,    38,    36,     3,    84,    38,     3,    27,    24,
      13,    26,    29,    12,    93,     3,    12,     0,    63,    18,
      23,     3,    18,    31,    23,    24,    25,    26,    24,    25,
      26,     3,    30,    31,    14,    67,    81,     3,    18,    19,
      28,    16,    17,    42,    12,    33,    42,    83,   127,    37,
      12,    33,    40,    41,     9,    37,    38,    90,    40,    41,
       3,    33,    34,    15,    69,    37,    71,    33,    40,    41,
     103,    37,    21,    22,    40,    41,     8,   110,     4,     5,
       6,    25,    14,    88,    73,    74,    18,    19,   101,    11,
       3,     8,    14,    10,   107,    14,    18,    19,     3,    18,
      19,    20,    12,   136,    97,    98,    39,    11,    11,    11,
       8,    10,    12,     8,    32,     8,    13,     9,     9,    20,
      36,   134,    11,    13,     9,    34,    10,     8,    10,     3,
       8,     8,     8,     8,     3,    21,    94,   137,    11,   140,
      -1,   136,    25
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    27,    44,    45,     0,    29,    46,    47,     3,    33,
      37,    40,    41,    55,    56,    57,    59,    75,    77,    84,
      31,    48,    49,    85,    12,    12,     3,    76,    78,    28,
      56,     9,    30,    49,    15,     3,    12,    18,    23,    24,
      25,    26,    42,    63,    65,    71,    72,    73,    86,    88,
      89,    65,    25,     3,     3,    50,    86,    86,    24,    26,
      63,    71,    12,    66,    11,    21,    22,    83,    39,    14,
      18,    19,    20,    16,    17,    11,    51,    10,    11,    13,
      23,    67,    69,    83,    58,    71,    12,    88,    87,    88,
      64,    89,    89,    60,     8,    32,    20,    13,    83,     8,
      63,    55,    61,     9,    79,    88,    86,    55,    50,     9,
      68,    67,    67,    74,    62,    36,    81,    86,    11,    38,
       4,     5,     6,    52,    53,    86,     9,    34,    10,    82,
      54,    10,     3,    70,    55,    80,     8,     8,     8,    10,
       8,    81,    53,     3,    11,    79
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

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
#ifndef	YYINITDEPTH
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
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
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
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
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

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
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
  int yytoken;
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

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

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
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
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
      if (yyn == 0 || yyn == YYTABLE_NINF)
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
  *++yyvsp = yylval;

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
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1455 of yacc.c  */
#line 186 "Sintactico.y"
    {printf("INICIA PROGRAMA\n");}
    break;

  case 3:

/* Line 1455 of yacc.c  */
#line 189 "Sintactico.y"
    {
		programa=bloque_sentencias;
		printf("FIN DEL PROGRAMA, COMPILACION OK\n");
		printf("\n\nARBOL\n");
		recorrer_en_orden(programa);
		grabarArbol(programa);
		//dibujar(programa,15,3,7,0);
		grabarTablaDeSimbolos(0);
	}
    break;

  case 4:

/* Line 1455 of yacc.c  */
#line 201 "Sintactico.y"
    {printf("DECLARACIONES\n");}
    break;

  case 5:

/* Line 1455 of yacc.c  */
#line 203 "Sintactico.y"
    {printf("FIN DE LAS DECLARACIONES\n");}
    break;

  case 8:

/* Line 1455 of yacc.c  */
#line 213 "Sintactico.y"
    { if(contadorDeIds != contadorDeTipos){ 
			yyerrormsj("",ErrorSintactico,ErrorEnDeclaracionCantidad);
		}
		imprimirVariables();
		}
    break;

  case 9:

/* Line 1455 of yacc.c  */
#line 222 "Sintactico.y"
    { 
				if(existeId(yylval.cadena)>=0){
					yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdRepetida);
				}
				contadorDeIds++;  
				strcpy(tablaVariables[indicesVariable.nombre++].nombre,yylval.cadena);
			}
    break;

  case 10:

/* Line 1455 of yacc.c  */
#line 229 "Sintactico.y"
    {
					if(existeId(yylval.cadena)>=0){
						  yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdRepetida);
					 }
					 contadorDeIds++;  strcpy(tablaVariables[indicesVariable.nombre++].nombre,yylval.cadena); 
					 }
    break;

  case 15:

/* Line 1455 of yacc.c  */
#line 244 "Sintactico.y"
    {contadorDeTipos++; strcpy(tablaVariables[indicesVariable.tipo++].tipo,yylval.cadena);  }
    break;

  case 16:

/* Line 1455 of yacc.c  */
#line 245 "Sintactico.y"
    {contadorDeTipos++;  strcpy(tablaVariables[indicesVariable.tipo++].tipo,yylval.cadena);   }
    break;

  case 18:

/* Line 1455 of yacc.c  */
#line 249 "Sintactico.y"
    {bloque_sentencias=sentencia;}
    break;

  case 19:

/* Line 1455 of yacc.c  */
#line 251 "Sintactico.y"
    {
							t_info info;strcpy(info.valor,"sentencia"); 
							bloque_sentencias=crearNodo(&info,bloque_sentencias,sentencia);
						}
    break;

  case 20:

/* Line 1455 of yacc.c  */
#line 258 "Sintactico.y"
    {sentencia=write;}
    break;

  case 21:

/* Line 1455 of yacc.c  */
#line 259 "Sintactico.y"
    {sentencia=read;}
    break;

  case 22:

/* Line 1455 of yacc.c  */
#line 260 "Sintactico.y"
    {sentencia=asignacion;}
    break;

  case 23:

/* Line 1455 of yacc.c  */
#line 261 "Sintactico.y"
    {sentencia=sentencia_if; }
    break;

  case 24:

/* Line 1455 of yacc.c  */
#line 262 "Sintactico.y"
    {sentencia=sentencia_while;}
    break;

  case 25:

/* Line 1455 of yacc.c  */
#line 267 "Sintactico.y"
    {
		t_info info;
		strcpy(info.valor,"if"); 
		printf("PONIENDO EN PILA if------------------------------------------\n");
		ponerEnPila(&pilaIf,crearNodo(&info,condicion,NULL));
		if(bloque_sentencias)
			ponerEnPila(&pilabloques,bloque_sentencias);
		printf("PUESTO EN PILA------------------------------------------\n");
	}
    break;

  case 26:

/* Line 1455 of yacc.c  */
#line 277 "Sintactico.y"
    {
		printf("SACANDO DE PILA------------------------------------------\n");
		sentencia_if =(t_nodo *) malloc (sizeof(t_nodo));
		sacar_de_pila(&pilaIf,sentencia_if);
		printf("FUERA DE PILA WHILE----%p-----------------------\n",sentencia_if);
		printf("Nodo sacado de pila: %s %s %s %s\n",sentencia_if->izq->izq->info.valor,sentencia_if->izq->info.valor,sentencia_if->izq->der->info.valor,sentencia_if->info.valor );
		insertarHijo(&(sentencia_if->der),bloque_sentencias);
		bloque_sentencias = sacar_de_pila2(&pilabloques);
		printf("Agregado esto: %s %s %s\n",sentencia_if->der->izq->info.valor,sentencia_if->der->info.valor,sentencia_if->der->der->info.valor);
	}
    break;

  case 27:

/* Line 1455 of yacc.c  */
#line 291 "Sintactico.y"
    {
		t_info info;
		strcpy(info.valor,"while"); 
		printf("PONIENDO EN PILA WHILE------------------------------------------\n");
		ponerEnPila(&pilaWhile,crearNodo(&info,condicion,NULL));
		if(bloque_sentencias)
			ponerEnPila(&pilabloques,bloque_sentencias);
		printf("PUESTO EN PILA------------------------------------------\n");
	}
    break;

  case 28:

/* Line 1455 of yacc.c  */
#line 301 "Sintactico.y"
    {
		printf("SACANDO DE PILA------------------------------------------\n");
		sentencia_while =(t_nodo *) malloc (sizeof(t_nodo));
		sacar_de_pila(&pilaWhile,sentencia_while);
		printf("FUERA DE PILA WHILE----%p-----------------------\n",sentencia_while);
		printf("Nodo sacado de pila: %s %s %s %s\n",sentencia_while->izq->izq->info.valor,sentencia_while->izq->info.valor,sentencia_while->izq->der->info.valor,sentencia_while->info.valor );
		insertarHijo(&(sentencia_while->der),bloque_sentencias);
		bloque_sentencias = sacar_de_pila2(&pilabloques);
		printf("Agregado esto: %s %s %s\n",sentencia_while->der->izq->info.valor,sentencia_while->der->info.valor,sentencia_while->der->der->info.valor);
		printf("while OK\n");
	}
    break;

  case 29:

/* Line 1455 of yacc.c  */
#line 316 "Sintactico.y"
    {
 		 bloque_if=bloque_sentencias;	
 		printf("if sin else OK\n");
 	}
    break;

  case 30:

/* Line 1455 of yacc.c  */
#line 320 "Sintactico.y"
    {
 	ponerEnPila(&pilabloqueif,bloque_sentencias);
 }
    break;

  case 31:

/* Line 1455 of yacc.c  */
#line 324 "Sintactico.y"
    {
 		t_info info;
		strcpy(info.valor,"bloque if");
 		bloque_if = crearNodo(&info,sacar_de_pila2 (&pilabloqueif),bloque_sentencias);
		printf("BLOQUE ELSE: %s, %s, %s\n",bloque_sentencias->info.valor,bloque_sentencias->izq->info.valor,bloque_sentencias->der->info.valor);
 		bloque_sentencias=bloque_if;
 		printf("if con else OK\n");
 	}
    break;

  case 32:

/* Line 1455 of yacc.c  */
#line 334 "Sintactico.y"
    {
					t_info info;
					strcpy(info.valor,yylval.cadena);
					comparacion= crearNodo(&info,expresion,NULL);
				}
    break;

  case 33:

/* Line 1455 of yacc.c  */
#line 338 "Sintactico.y"
    {
					insertarHijo(&(comparacion->der),expresion);
				}
    break;

  case 35:

/* Line 1455 of yacc.c  */
#line 343 "Sintactico.y"
    {condicion=comparacion;}
    break;

  case 37:

/* Line 1455 of yacc.c  */
#line 345 "Sintactico.y"
    {
								condicion=comparacion;
									if(strcmp(condicion->info.valor,"<")==0)
										strcpy(condicion->info.valor,">=");
										else if(strcmp(condicion->info.valor,">")==0)
												strcpy(condicion->info.valor,"<=");
											else if(strcmp(condicion->info.valor,"<=")==0)
												strcpy(condicion->info.valor,">");
												else if(strcmp(condicion->info.valor,">=")==0)
													strcpy(condicion->info.valor,"<");
													else if(strcmp(condicion->info.valor,"==")==0)
														strcpy(condicion->info.valor,"!=");
														else if(strcmp(condicion->info.valor,"!=")==0)
															strcpy(condicion->info.valor,"!=");
            					}
    break;

  case 39:

/* Line 1455 of yacc.c  */
#line 363 "Sintactico.y"
    {
			comparacion1 = * comparacion;
		}
    break;

  case 40:

/* Line 1455 of yacc.c  */
#line 367 "Sintactico.y"
    {
			t_nodo * aux;
			aux = (t_nodo *) malloc(sizeof(t_nodo));
			t_nodo * aux1;
			aux1 = (t_nodo *) malloc(sizeof(t_nodo));
			*aux1 = comparacion1;
			*aux = * comparacion;
			t_nodo * aux2;
			aux2 = (t_nodo *) malloc(sizeof(t_nodo));
			*aux2=*and_or;
			insertarHijo(&(aux2->izq),aux1);
			insertarHijo(&(aux2->der),aux);
			condicion = aux2;
		}
    break;

  case 41:

/* Line 1455 of yacc.c  */
#line 384 "Sintactico.y"
    { 	
									t_info info;
									strcpy(info.valor,yylval.cadena);
									condicion_filter  = crearNodo(&info,NULL,NULL);}
    break;

  case 42:

/* Line 1455 of yacc.c  */
#line 388 "Sintactico.y"
    { 	
					insertarHijo(&(condicion_filter->der),expresion);
		}
    break;

  case 44:

/* Line 1455 of yacc.c  */
#line 394 "Sintactico.y"
    {
									if(strcmp(condicion_filter->info.valor,"<")==0)
										strcpy(condicion_filter->info.valor,">=");
										else if(strcmp(condicion_filter->info.valor,">")==0)
												strcpy(condicion_filter->info.valor,"<=");
											else if(strcmp(condicion_filter->info.valor,"<=")==0)
												strcpy(condicion_filter->info.valor,">");
												else if(strcmp(condicion_filter->info.valor,">=")==0)
													strcpy(condicion_filter->info.valor,"<");
													else if(strcmp(condicion_filter->info.valor,"==")==0)
														strcpy(condicion_filter->info.valor,"!=");
														else if(strcmp(condicion_filter->info.valor,"!=")==0)
															strcpy(condicion_filter->info.valor,"!=");
            					}
    break;

  case 46:

/* Line 1455 of yacc.c  */
#line 412 "Sintactico.y"
    { if(existeId(yylval.cadena)== -1 ){  yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} 

						t_info info2;
						strcpy(info2.valor,"if"); 
						t_info info;
						t_nodo *copiaCondicion=(t_nodo *) malloc (sizeof(t_nodo));
						*copiaCondicion=*condicion_filter;
						strcpy(info.valor,yylval.cadena);
						//NodoAsignacion
						t_info filter_info;
						strcpy(filter_info.valor,"=");
						//HojaIzq
						t_info filter_izq;
						strcpy(filter_izq.valor,"@filter");
						//HojaDer
						t_info filter_der;
						strcpy(filter_der.valor,yylval.cadena);
						//Bloque if
						t_info filter_bloque;
						strcpy(filter_bloque.valor,"bloque if");
						//No encontrado
						t_info filter_no_encontrado;
						strcpy(filter_no_encontrado.valor,"null");

						t_nodo *asignacionFilter=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_der));
						t_nodo *asignacionNull=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_no_encontrado));
						t_nodo *nodo_bloque_if=crearNodo(&filter_bloque,asignacionFilter,asignacionNull);
						insertarHijo(&(copiaCondicion->izq),crearHoja(&info));
						
						//ponerEnPila(&pilaFilter,crearNodo(&info2,copiaCondicion,asignacionFilter));
						lista_var_filter = crearNodo(&info2,copiaCondicion,nodo_bloque_if);
						ponerEnPila(&pilaFilter,lista_var_filter);
			}
    break;

  case 47:

/* Line 1455 of yacc.c  */
#line 447 "Sintactico.y"
    {if(existeId(yylval.cadena)== -1 ){yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} 
						t_nodo *aux=(t_nodo *) malloc (sizeof(t_nodo));
						*aux=*(lista_var_filter->der->izq);
						t_info info; 
						t_nodo *copiaCondicion=(t_nodo *) malloc (sizeof(t_nodo));
						*copiaCondicion=*condicion_filter;
						strcpy(info.valor,yylval.cadena);
						insertarHijo(&(copiaCondicion->izq),crearHoja(&info));
						t_info info2;
						strcpy(info2.valor,"if"); 
						t_info info3;
						strcpy(info3.valor,"bloque if");
						//NodoAsignacion
						t_info filter_info;
						strcpy(filter_info.valor,"=");
						//HojaIzq
						t_info filter_izq;
						strcpy(filter_izq.valor,"@filter");
						//HojaDer
						t_info filter_der;
						strcpy(filter_der.valor,yylval.cadena);
						printf("INSERTANDO NUEVA VARIABLE EN FILTER: %s\n",yylval.cadena);
						t_nodo* asignacionFilter=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_der));
						//No encontrado
						t_info filter_no_encontrado;
						strcpy(filter_no_encontrado.valor,"null");
						t_nodo *asignacionNull=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_no_encontrado));
						t_nodo *nodo_bloque_trueFalse=crearNodo(&info3,asignacionFilter,asignacionNull);
						//
						t_nodo *nodo_if=crearNodo(&info2,copiaCondicion,nodo_bloque_trueFalse);
						t_nodo *nodo_bloque_if=crearNodo(&info3,aux,nodo_if);
						*(lista_var_filter->der)=*nodo_bloque_if;
						lista_var_filter=nodo_bloque_if->der;
						//insertarHijo(&(lista_var_filter->der),nodo_bloque_if);
						//lista_var_filter=(lista_var_filter->der);
						//insertarHijo(&(lista_var_filter->izq),aux);
					}
    break;

  case 48:

/* Line 1455 of yacc.c  */
#line 487 "Sintactico.y"
    { limpiarVector(cantExpLE,TAM); }
    break;

  case 49:

/* Line 1455 of yacc.c  */
#line 487 "Sintactico.y"
    {   if(! longLEsValidas())
											yyerrormsj("Las listas de expresiones tienen distintas longitudes",ErrorSintactico,ErrorAllEqual);
										if(contadorListaExp==1)
											yyerrormsj("Se deben ingresar como minimo dos listas de expresiones",ErrorSintactico,ErrorAllEqual);
									contadorListaExp=0; printf("AllEqual OK \n");
									}
    break;

  case 50:

/* Line 1455 of yacc.c  */
#line 497 "Sintactico.y"
    {

										}
    break;

  case 51:

/* Line 1455 of yacc.c  */
#line 500 "Sintactico.y"
    { 
										t_info info;  
										strcpy(info.valor,"FILTER");
										t_info filter_info;
										strcpy(filter_info.valor,"@filter");
										filter= crearNodo(&info,sacar_de_pila2(&pilaFilter),crearHoja(&filter_info)); 
										printf("Filter OK\n"); }
    break;

  case 52:

/* Line 1455 of yacc.c  */
#line 510 "Sintactico.y"
    {printf("Funcion Write\n");}
    break;

  case 54:

/* Line 1455 of yacc.c  */
#line 511 "Sintactico.y"
    { 
				if(existeId((yyvsp[(2) - (2)].cadena))==-1){
					yyerrormsj((yyvsp[(2) - (2)].cadena),ErrorSintactico,ErrorIdNoDeclarado);
				}
			}
    break;

  case 55:

/* Line 1455 of yacc.c  */
#line 520 "Sintactico.y"
    {
			printf("Funcion Read\n");}
    break;

  case 56:

/* Line 1455 of yacc.c  */
#line 521 "Sintactico.y"
    { 
			if(existeId((yyvsp[(2) - (3)].cadena))==-1){
				yyerrormsj((yyvsp[(2) - (3)].cadena),ErrorSintactico,ErrorIdNoDeclarado);
			}
		}
    break;

  case 57:

/* Line 1455 of yacc.c  */
#line 529 "Sintactico.y"
    { contadorListaExp++; }
    break;

  case 58:

/* Line 1455 of yacc.c  */
#line 530 "Sintactico.y"
    { contadorListaExp++; }
    break;

  case 60:

/* Line 1455 of yacc.c  */
#line 534 "Sintactico.y"
    { cantExpLE[contadorListaExp] ++;}
    break;

  case 61:

/* Line 1455 of yacc.c  */
#line 535 "Sintactico.y"
    { cantExpLE[contadorListaExp] ++;}
    break;

  case 63:

/* Line 1455 of yacc.c  */
#line 539 "Sintactico.y"
    {
			t_info info;
			strcpy(info.valor,"and");
			and_or= crearHoja(&info);
		}
    break;

  case 64:

/* Line 1455 of yacc.c  */
#line 544 "Sintactico.y"
    {
			t_info info;
			strcpy(info.valor,"or");
			and_or= crearHoja(&info);
		 }
    break;

  case 65:

/* Line 1455 of yacc.c  */
#line 552 "Sintactico.y"
    {	
					int indice;
					if((indice=existeId(yylval.cadena))<0){
						yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);
					}
					strcpy(ultimoId,yylval.cadena);
					tipoAsignacion=obtenerTipo(indice);
					esAsignacion=1;
				}
    break;

  case 66:

/* Line 1455 of yacc.c  */
#line 562 "Sintactico.y"
    {
					t_info info;
					strcpy(info.valor,"=");
					t_info info_id;
					strcpy(info_id.valor,ultimoId);
       				asignacion= crearNodo(&info,crearHoja(&info_id),expresion);	
       				printf("Asignacion OK\n"); esAsignacion=0; 
		}
    break;

  case 67:

/* Line 1455 of yacc.c  */
#line 573 "Sintactico.y"
    {expresion=termino;}
    break;

  case 68:

/* Line 1455 of yacc.c  */
#line 575 "Sintactico.y"
    {
	 	/*t_info info;
	 	strcpy(info.valor,"-");
	 	expresion=crearNodo(&info,expresion,NULL);
	 	printf("Expresion: %s\n", yylval.cadena);*/
	 }
    break;

  case 69:

/* Line 1455 of yacc.c  */
#line 582 "Sintactico.y"
    {
	 								if(tipoAsignacion == TipoCadena) 
	 									yyerrormsj("resta",ErrorSintactico,ErrorOperacionNoValida); 
									else{
										t_info info;
       									strcpy(info.valor,"-");
       									//insertarHijo(&expresion->der,termino);
       									expresion= crearNodo(&info,expresion,termino);
										printf("Resta OK\n");
									} 
								}
    break;

  case 70:

/* Line 1455 of yacc.c  */
#line 594 "Sintactico.y"
    {
     								if(tipoAsignacion == TipoCadena)
     									yyerrormsj("suma",ErrorSintactico,ErrorOperacionNoValida); 
									else {
										t_info info;
       									strcpy(info.valor,"+");
       									expresion= crearNodo(&info,expresion,termino);
										printf("Suma OK\n");
									} 
								}
    break;

  case 71:

/* Line 1455 of yacc.c  */
#line 605 "Sintactico.y"
    { 
	 								if(tipoAsignacion != TipoCadena)
	 									yyerrormsj("concatenacion",ErrorSintactico,ErrorOperacionNoValida); 
									else {
										t_info info;
       									strcpy(info.valor,"++");
       									expresion= crearNodo(&info,expresion,termino);	
										printf("Concatenacion OK\n");
									}
								}
    break;

  case 72:

/* Line 1455 of yacc.c  */
#line 618 "Sintactico.y"
    {termino=factor;}
    break;

  case 73:

/* Line 1455 of yacc.c  */
#line 619 "Sintactico.y"
    {
       								t_info info;
       								strcpy(info.valor,"*");
       								termino = crearNodo(&info,termino,factor);
       								printf("Multiplicación OK\n"); 
       							}
    break;

  case 74:

/* Line 1455 of yacc.c  */
#line 625 "Sintactico.y"
    {
       								printf("División OK\n");
       								t_info info;
       								strcpy(info.valor,"/");
       								termino = crearNodo(&info,termino,factor);		
       							}
    break;

  case 75:

/* Line 1455 of yacc.c  */
#line 635 "Sintactico.y"
    {
			if(esAsignacion==1){			  
				if(obtenerTipo(existeId(yylval.cadena))!= tipoAsignacion){
					yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdDistintoTipo);  
				}
			}
			if(existeId(yylval.cadena)== -1 )
				yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);
			t_info info;
		  	strcpy(info.valor, yylval.cadena);
		  	factor = crearHoja(&info);
		 }
    break;

  case 76:

/* Line 1455 of yacc.c  */
#line 647 "Sintactico.y"
    {
		  if(esAsignacion==1&&tipoAsignacion!=TipoEntero){
			yyerrormsj(yylval.cadena,ErrorSintactico,ErrorConstanteDistintoTipo);    
		  }
          if(atoi(yylval.cadena) >= ENTERO_MAXIMO ){
            char entero[10];
            yyerrormsj(yylval.cadena,ErrorLexico,ErrorIntFueraDeRango);
          }
          printf("Constante entera, Valor: %s\n", yylval.cadena);
		  if(existeCte()==0){
			  strcpy(tablaConstantes[indiceConstante].nombre,"_");
			  strcat(tablaConstantes[indiceConstante].nombre,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_entero");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
		  t_info info;
		  strcpy(info.valor, "_");
		  strcat(info.valor,yylval.cadena);
		  factor = crearHoja(&info);
      }
    break;

  case 77:

/* Line 1455 of yacc.c  */
#line 669 "Sintactico.y"
    {
		  char aux[5]="-";
          if(atoi(yylval.cadena) > ENTERO_MAXIMO){
            char entero[10];
            yyerrormsj(strcat(aux,yylval.cadena),ErrorLexico,ErrorIntFueraDeRango);
           }
		   if(esAsignacion==1&&tipoAsignacion!=TipoEntero){
			yyerrormsj(yylval.cadena,ErrorSintactico,ErrorConstanteDistintoTipo);    
		  }
          printf("Constante entera, valor: -%s\n", yylval.cadena);
		  if(existeCte()==0){
			  strcpy(tablaConstantes[indiceConstante].nombre,"_-");
			  strcat(tablaConstantes[indiceConstante].nombre,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].valor,"-");
			  strcat(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_entero");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
		  t_info info;
		  strcpy(info.valor, "_-");
		  strcat(info.valor,yylval.cadena);
		  factor = crearHoja(&info);
      }
    break;

  case 78:

/* Line 1455 of yacc.c  */
#line 693 "Sintactico.y"
    {
          if(atof(yylval.cadena) >= FLT_MAX ){
			yyerrormsj(yylval.cadena,ErrorLexico,ErrorFloatFueraDeRango);
		  }
		 if(esAsignacion==1&&tipoAsignacion!=TipoReal){
			yyerrormsj(yylval.cadena,ErrorSintactico,ErrorConstanteDistintoTipo);    
		  }
          printf("Constante real, valor: %s\n", yylval.cadena);
		  if(existeCte()==0){
			  strcpy(tablaConstantes[indiceConstante].nombre,"_");
			  strcat(tablaConstantes[indiceConstante].nombre,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_real");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
  		  t_info info;
		  strcpy(info.valor, "_");
		  strcat(info.valor,yylval.cadena);
		  factor = crearHoja(&info);
      }
    break;

  case 79:

/* Line 1455 of yacc.c  */
#line 714 "Sintactico.y"
    {
		  char aux[5]="-";
          if(atof(yylval.cadena) >= FLT_MAX ){
			yyerrormsj(strcat(aux,yylval.cadena),ErrorLexico,ErrorFloatFueraDeRango);
		  }
		 if(esAsignacion==1&&tipoAsignacion!=TipoReal){
			yyerrormsj(yylval.cadena,ErrorSintactico,ErrorConstanteDistintoTipo);    
		  }
          printf("Constante real, valor: -%s\n", yylval.cadena);
		  if(existeCte()==0){
			  strcpy(tablaConstantes[indiceConstante].nombre,"_-");
			  strcat(tablaConstantes[indiceConstante].nombre,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].valor,"-");
			  strcat(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_real");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
		  t_info info;
		  strcpy(info.valor, "_-");
		  strcat(info.valor,yylval.cadena);
		  factor = crearHoja(&info);
      }
    break;

  case 80:

/* Line 1455 of yacc.c  */
#line 737 "Sintactico.y"
    {
		  if(esAsignacion==1&&tipoAsignacion!=TipoCadena){
				yyerrormsj(yylval.cadena,ErrorSintactico,ErrorConstanteDistintoTipo);    
		  }
          if(strlen(yylval.cadena)>CADENA_MAXIMA)
				yyerrormsj(yylval.cadena,ErrorLexico,ErrorStringFueraDeRango);
         printf("CADENA es: %s\n",yylval.cadena);
		int ret=existeCte();
		 if(ret==0){
			  strcpy(tablaConstantes[indiceConstante].nombre,"_");
			  strcat(tablaConstantes[indiceConstante].nombre,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_cadena");
			  tablaConstantes[indiceConstante].longitud=strlen(yylval.cadena);
			  indiceConstante++;
		}
		t_info info;
		strcpy(info.valor, "_");
		strcat(info.valor,yylval.cadena);
		factor = crearHoja(&info);
      }
    break;

  case 81:

/* Line 1455 of yacc.c  */
#line 758 "Sintactico.y"
    {expresion=factor;}
    break;

  case 82:

/* Line 1455 of yacc.c  */
#line 759 "Sintactico.y"
    { factor = filter; }
    break;



/* Line 1455 of yacc.c  */
#line 2560 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
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

  /* Do not reclaim the symbols of the rule which action triggered
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
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
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

  *++yyvsp = yylval;


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

#if !defined(yyoverflow) || YYERROR_VERBOSE
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
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
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
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1675 of yacc.c  */
#line 762 "Sintactico.y"


int main(int argc,char *argv[])
{
	if ((yyin = fopen(argv[1], "rt")) == NULL)
	{
		printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
	}
	else
	{
		yyparse();
	}
	fclose(yyin);
	return 0;
}

//DEFINICION  DE FUNCIONES

int yyerrormsj(const char * info, int tipoDeError ,int error)
     {
		 grabarTablaDeSimbolos(1);
		printf("Linea: %d. ",yylineno);
       switch(tipoDeError){
          case ErrorSintactico: 
            printf("Error sintactico. ");
            break;
          case ErrorLexico: 
            printf("Error lexico. ");
            break;
        }
      switch(error){ 
        case ErrorIntFueraDeRango: 
            printf("Entero %s fuera de rango\n",info);
            break ;
		case ErrorFloatFueraDeRango: 
            printf("Real %s fuera de rango\n",info);
            break ;
        case ErrorStringFueraDeRango:
            printf("Cadena: \"%s\" fuera de rango\n", info);
            break ; 
		case ErrorEnDeclaracionCantidad:
			printf("Descripcion: no coinciden la cantidad de ids declaradas con la cantidad de tipos declarados\n");
			break ; 
		case ErrorIdRepetida:
			printf("Descripcion: el id '%s' ha sido declarado mas de una vez\n",info);
			break;
		case ErrorIdNoDeclarado: 
			printf("Descripcion: el id '%s' no ha sido declarado\n",info);
			break;
		case ErrorIdDistintoTipo: 
			printf("Descripcion: La variable '%s' no es de tipo %s\n",info,obtenerTipoLiteral(tipoAsignacion));
			break;
		case ErrorConstanteDistintoTipo: 
			printf("Descripcion: La constante %s no es de tipo %s\n", info, obtenerTipoLiteral(tipoAsignacion));
			break;
		case ErrorAllEqual: 
			printf("Descripcion: Error AllEqual: %s\n",info);
			break;
		case ErrorOperacionNoValida: 
			printf("Descripcion: La operacion %s no es valida para variables de tipo %s\n",info, obtenerTipoLiteral(tipoAsignacion));
			break;
      }

       system ("Pause");
	     exit (1);
      }

int yyerror(void)
     {
		grabarTablaDeSimbolos(1);
		printf("Error sintatico \n");
		system ("Pause");
		exit (1);
     }

void imprimirVariables(){
	int  i;
	for(i = 0; i<indicesVariable.nombre; i++){
		printf("Id: %s, tipo: %s\n",tablaVariables[i].nombre,tablaVariables[i].tipo);
	}
}


//retorna la posicion del vector en el que se encuentra la id en caso de que exista.
//retorna -1 si no existe
int existeId(char * id){
	int  i;
	for(i = 0; i<indicesVariable.nombre; i++){
		if(strcmp(tablaVariables[i].nombre,id) == 0)
			return i;
	}
	return -1;
}

int existeCte(){
	int  j;
	char aux[50]="_";
	strcat(aux,yylval.cadena);
	for(j = 0; j<indiceConstante; j++){
		if(strcmp(tablaConstantes[j].nombre,aux) == 0){
			return 1;
			}
	}
	return 0;
}

int obtenerTipo(int indice){ 
	if(strcmp(tablaVariables[indice].tipo,"entero")==0){
		return TipoEntero;
	}else if(strcmp(tablaVariables[indice].tipo,"real")==0)
					return TipoReal;
			 else 
					return TipoCadena;
}

//se fija que las longitudes de todas las listas de expresiones del allequal sean iguales
int longLEsValidas(){
	int i;
	for(i=0; i<contadorListaExp; i++)
		if(cantExpLE[0] != cantExpLE[i])
			return 0;
	return 1;
}

void limpiarVector(int * vec,int max){
	int i;
	for(i=0; i<max; i++)
		vec[i]= 0;
}

char * obtenerTipoLiteral(int indice){
	switch (indice){ 
		case TipoEntero:
			return "entero";
		case TipoCadena:
			return "cadena";
		case TipoReal:
			return "real";
	}
}

void grabarTablaDeSimbolos(int error){
	FILE*pf=fopen("ts.txt","w+");
	int i;
	if(!pf){
		printf("Error al crear la tabla de simbolos\n");
		return;
	}
	fprintf(pf,"%-32s|\t%-32s|\t%-32s|\t%-32s\n","NOMBRE","TIPO","VALOR","LONGITUD");
	for(i = 0; i<indicesVariable.nombre; i++){
		fprintf(pf,"%-32s|\t%-32s|\t%-32s|\t%-32s\n",tablaVariables[i].nombre,tablaVariables[i].tipo,"----------","----------");
	}

	for(i = 0; i<indiceConstante; i++){
		if(tablaConstantes[i].longitud==0)
			fprintf(pf,"%-32s|\t%-32s|\t%-32s|\t%-32s\n",tablaConstantes[i].nombre,tablaConstantes[i].tipo,tablaConstantes[i].valor,"----------");
		else
			fprintf(pf,"%-32s|\t%-32s|\t%-32s|\t%-32d\n",tablaConstantes[i].nombre,tablaConstantes[i].tipo,tablaConstantes[i].valor,tablaConstantes[i].longitud);
	}
	if(error==1)
		fprintf(pf,"TABLA INCOMPLETA (ERROR DE COMPILACION)\n");
	fclose(pf);
}

/////////////////////////////////////////// FUNCIONES ARBOL /////////////////////////////////////////////////////////

t_nodo * crearHoja(const t_info *d)
{
    t_nodo *p = (t_nodo*) malloc(sizeof(t_nodo));
    if(!p){ 
    	printf("No hay memoria disponible. El programa se cerrará\n");
    	exit(1);
    }
    p->info=*d;
    p->der=p->izq=NULL;
    return p;
}
t_nodo * crearNodo(const t_info *d, t_nodo * hijo_izq, t_nodo * hijo_der)
{
    t_nodo *p = (t_nodo*) malloc(sizeof(t_nodo));
    if(!p){ 
    	printf("No hay memoria disponible. El programa se cerrará\n");
    	exit(1);
    }
    p->info=*d;
    p->izq= hijo_izq;
    p->der= hijo_der;
    return p;
}

void insertarHijo (t_nodo ** puntero, t_nodo * hijo){
	*puntero=hijo;
}

void recorrer_en_orden(const t_nodo* nodo)
{
    if(nodo)
    {
   		if(nodo->izq!=NULL&&nodo->der!=NULL)
   			printf("%s\t%s\t%s\n", nodo->info.valor,nodo->izq->info.valor,nodo->der->info.valor);
    	recorrer_en_orden(nodo->izq);
    	recorrer_en_orden(nodo->der);
    }
}

void recorrer_guardando(const t_nodo* nodo, FILE* pf)
{
    if(nodo)
    {
   		if(nodo->izq!=NULL&&nodo->der!=NULL)
   			fprintf(pf,"%-32s\t%-32s\t%-32s\n", nodo->info.valor,nodo->izq->info.valor,nodo->der->info.valor);
    	recorrer_guardando(nodo->izq,pf);
    	recorrer_guardando(nodo->der,pf);
    }
}

void grabarArbol(t_nodo* arbol)
{
	FILE*pf=fopen("arbol.txt","w+");
	int i;
	if(!pf){
		printf("Error al guardar el arbol\n");
		return;
	}
	fprintf(pf,"%-32s|\t%-32s|\t%-32s\n","PADRE","HIJO IZQ","HIJO DER");
	recorrer_guardando(arbol,pf);
	fclose(pf);
}

//MENTIRAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
/*
void dibujar(t_nodo* arbol,int a,int b,int c,int d)
{
 	if(arbol!=NULL)
		{
		circle(300+a,75+b,14);
		setcolor(YELLOW);
   		outtextxy(295+a,75+b,arbol->info.valor);setcolor(WHITE);
   		if(d==1) 
   			line(300+a+pow(2,c+1),b+14,300+a,61+b);
   		else 
   			if(d==2) 
   				line(300+a-pow(2,c+1),b+14,300+a,61+b);
		dibujar(arbol->izq,a-pow(2,c)-pow(2,d-4),b+75,c-1,1);
		dibujar(arbol->der,a+pow(2,c)+pow(2,d-4),b+75,c-1,2);
  	}
}*/

/////////////////////////PILA//////////////////////////////////////////////////////////

void crearPila(t_pila* pp)
{/*
	t_nodoPila* pn=(t_nodoPila*)malloc(sizeof(t_nodoPila));
    if(!pn)
        return 0;
    pp=&pn;
    return pp;
    */

    *pp=NULL;  //ORIGINAL
}

int ponerEnPila(t_pila* pp,t_nodo* nodo)
{
    t_nodoPila* pn=(t_nodoPila*)malloc(sizeof(t_nodoPila));
    if(!pn)
        return 0;
    pn->info=*nodo;
    printf("----------------------------------INSERTADO: %s %s\n",pn->info.info.valor,(pn->info).izq->info.valor );
    pn->psig=*pp;
    *pp=pn;
    return 1;
}
///////////////////////////////////////////////////////
int sacar_de_pila(t_pila* pp,t_nodo* info)
{
    if(!*pp){
    	printf("PILA NULA**************************************************\n");
    	return 0;
    }
    *info=(*pp)->info;
    //printf("----------------------------------SACANDO: %s %s\n",info->info.valor,info->izq->info.valor );
    *pp=(*pp)->psig;
    return 1;

}

t_nodo * sacar_de_pila2(t_pila* pp)
{
	t_nodo* info = (t_nodo *) malloc(sizeof(t_nodo));
    if(!*pp){
    	return NULL;
    }
    *info=(*pp)->info;
    //printf("----------------------------------SACANDO: %s %s\n",info->info.valor,info->izq->info.valor );
    *pp=(*pp)->psig;
    return info;

}
///////////////////////////////////////////////////////

void vaciarPila(t_pila* pp)
{
    t_nodoPila* pn;
    while(*pp)
    {
        pn=*pp;
        *pp=(*pp)->psig;
        free(pn);
    }
}
