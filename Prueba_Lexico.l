%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
#include <string.h>

char * replace(
    char const * const original, 
    char const * const pattern, 
    char const * const replacement
) {
  size_t const replen = strlen(replacement);
  size_t const patlen = strlen(pattern);
  size_t const orilen = strlen(original);

  size_t patcnt = 0;
  const char * oriptr;
  const char * patloc;

  // find how many times the pattern occurs in the original string
  for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen)
  {
    patcnt++;
  }

  {
    // allocate memory for the new string
    size_t const retlen = orilen + patcnt * (replen - patlen);
    char * const returned = (char *) malloc( sizeof(char) * (retlen + 1) );

    if (returned != NULL)
    {
      // copy the original string, 
      // replacing all the instances of the pattern
      char * retptr = returned;
      for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen)
      {
        size_t const skplen = patloc - oriptr;
        // copy the section until the occurence of the pattern
        strncpy(retptr, oriptr, skplen);
        retptr += skplen;
        // copy the replacement 
        strncpy(retptr, replacement, replen);
        retptr += replen;
      }
      // copy the rest of the string.
      strcpy(retptr, oriptr);
    }
    return returned;
  }
}


FILE  *yyin;
int yylval;
float real;
char string[300];
unsigned long entero64bits;
char *puntero;

%}
%option noyywrap  
%option yylineno 

DIGITO			[0-9]
LETRA			[a-zA-Z]
ID			{LETRA}({LETRA}|{DIGITO}|_)*
STRING   \"([^\"\\\\]|\\\\.)*\"
ENTERO		{DIGITO}+
REAL		([0-9]*\.[0-9]+|[0-9]+)

%%
"="			{ return ASIG;}
"+"			{ return OP_SUMA;}
"-"			{ return OP_RESTA;}
"*"			{ return OP_MUL;}
"/"			{ return OP_DIV;}
"("			{ return P_A;}
")"			{ return P_C;}
"{"			{ return LL_A; }
"}"			{ return LL_C; }
"\""		{ return COMILLA;}

{ID}			{ return ID;}

{ENTERO}	   { 
						 	yylval = atoi( yytext ); 
						 	return ENTERO;
					}
{REAL}			{ 
					real = atof( yytext );
					return REAL;
				}

{STRING}	{	
					strcpy(string,replace(yytext,"\"",""));
					return STRING;
				}
"\n"      		
"\t"		

%%



