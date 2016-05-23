
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
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

/* Line 1676 of yacc.c  */
#line 155 "Sintactico.y"

	int entero;
	double real;
	char cadena[50];



/* Line 1676 of yacc.c  */
#line 144 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


