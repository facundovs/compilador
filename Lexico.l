%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
#include <string.h>

char * replace(char const * const original,  char const * const pattern,  char const * const replacement) 
{
	size_t const replen = strlen(replacement);
	size_t const patlen = strlen(pattern);
	size_t const orilen = strlen(original);
	size_t patcnt = 0;
	const char * oriptr;
	const char * patloc;
	for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen){
		patcnt++;
	}
  {
	size_t const retlen = orilen + patcnt * (replen - patlen);
    char * const returned = (char *) malloc( sizeof(char) * (retlen + 1) );
    if (returned != NULL)
    {
	char * retptr = returned;
	for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen){
	size_t const skplen = patloc - oriptr;
	strncpy(retptr, oriptr, skplen);
	retptr += skplen;
	strncpy(retptr, replacement, replen);
	retptr += replen;
	}
	strcpy(retptr, oriptr);
	}
	return returned;
	}
}

char * cortarCadena1(char* cad,int tam){
	if(strlen(cad)>tam)
		cad[tam]='\0';
	return cad;
}


FILE  *yyin;
unsigned long entero64bits;
char *puntero;

%}
%option noyywrap  
%option yylineno 
DIGITO						[0-9]
LETRA						[a-zA-Z]
ID							{LETRA}({LETRA}|{DIGITO}|_)*
COMENTARIO     		(-\/).*(\/-)
CONST_CADENA 		\"([^\"\\\\]|\\\\.)*\"
CONST_ENTERO		{DIGITO}+
CONST_REAL				([0-9]*\.[0-9]+|[0-9]+)
%%
"="							{ return ASIG;}
"+"							{ return OP_SUMA;}
"++"						{ return OP_CONCAT; }
"-"							{ return OP_RESTA;}
"*"							{ return OP_MUL;}
"/"							{ return OP_DIV;}
"("							{ return P_A;}
")"							{ return P_C;}
"["							{ return C_A; }
"]"							{ return C_C; }
"\""						{ return COMILLA;}
"=="						{ strcpy(yylval.cadena,"=="); return COMPARADOR; }
"!="						{ strcpy(yylval.cadena,"!="); return COMPARADOR; }
">"							{ strcpy(yylval.cadena,">"); return COMPARADOR; }
"<"							{ strcpy(yylval.cadena,"<"); return COMPARADOR; }
"<="						{ strcpy(yylval.cadena,"<="); return COMPARADOR; }
">="						{ strcpy(yylval.cadena,">="); return COMPARADOR; }
"and"						{ return AND; }
"or"						{ return OR; }
"not"              			{ return OP_NOT; }
"programa"					{ return PROGRAMA;}
"fin_programa"				{ return FIN_PROGRAMA; }
"declaraciones"				{ return DECLARACIONES; }
"fin_declaraciones"			{ return FIN_DECLARACIONES; }
","							{ return COMA; }
"real"						{ strcpy(yylval.cadena,"real");   return REAL;}
"entero"					{ strcpy(yylval.cadena,"entero");  return ENTERO;}
"cadena"					{ strcpy(yylval.cadena,"cadena"); return CADENA;}
"DIM"						{ return DIM; }
"AS"						{ return AS; }
"if"						{ return IF; }
"else"						{ return ELSE; }
"endif"						{ return ENDIF;}
"while"						{ return WHILE; }
"endwhile"					{ return ENDWHILE; }
"AllEqual"					{ return ALLEQUAL; }
"WRITE"						{ return WRITE; }
"READ"						{ return READ; } 
"FILTER"					{ return FILTER; }
"_"							{ return GB;}
{ID}							{ strcpy(yylval.cadena,yytext); return ID;}				
{CONST_ENTERO}	  	{ 
								//yylval.entero = atoi( yytext ); 
								strcpy(yylval.cadena,cortarCadena1(yytext,46));
								return CONST_ENTERO;
					}
					
{CONST_REAL}		{ 
								//yylval.real = atof( yytext );
								strcpy(yylval.cadena,cortarCadena1(yytext,46));
								return CONST_REAL;
					}

{CONST_CADENA}		{	
								strcpy(yylval.cadena,replace(yytext,"\"",""));
								return CONST_CADENA;
					}
				
{COMENTARIO}		{

					}
   		
"\n"
"\r\n"
"\t"
" "
. 								{ printf("Linea: %d. Error lexico. Descripcion: El caracter %s es invalido\n",yylineno,yytext); exit(1);}

%%	



