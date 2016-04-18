
%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
#include <string.h>

//TIPOS DE ERROR
#define ErrorSintactico 1
#define ErrorSemantico 2
//ERRORES
#define ErrorIntFueraDeRango 3
#define ErrorStringFueraDeRango 4
int yyerrormsj(const char *,int,int); // error sintactico  1, error semantico 2
int yyerror();
int yylval;
float real;
char string[300];
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;

%}

%token ID
%token ENTERO OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG P_A P_C LL_A LL_C REAL COMILLA STRING
%%
programa : asignacion {printf("Compilación OK\n");}

asignacion: ID ASIG expresion
;
		
expresion:
         termino
	 |expresion OP_RESTA termino {printf("Resta OK\n");}
       |expresion OP_SUMA termino  {printf("Suma OK\n");}

 	 ;

termino: 
       factor
       |termino OP_MUL factor  {printf("Multiplicación OK\n");}
       |termino OP_DIV factor  {printf("División OK\n");}
       ;

factor: 
      ID 
      | ENTERO {
          if(yylval >=32768){
            char entero[10];
            yyerrormsj(itoa(yylval,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
          }
          $1 = yylval;
          printf("ENTERO es: %d\n", yylval);
      }
      | OP_RESTA ENTERO {
          if(yylval > 32768){
            char entero[10];
            yyerrormsj(itoa(yylval,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
           }
          $1 = yylval;
          printf("ENTERO es: -%d\n", yylval);
      }
      | REAL {
          $1 = yylval;
          printf("REAL es: %f\n", real);
      }
      | STRING {
          if(strlen(string)>30)
              yyerrormsj(string,ErrorSemantico,ErrorStringFueraDeRango);
          printf("STRING es: %s\n",string);
      }

      |P_A expresion P_C  
    ;

%%


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
int yyerrormsj(const char * info, int tipoDeError ,int error)
     {
       switch(tipoDeError){
          case ErrorSintactico: 
            printf("Error sintactico. ");
            break;
          case ErrorSemantico: 
            printf("Error semantico. ");
            break;
        }
      switch(error){ 
        case ErrorIntFueraDeRango: 
            printf("Entero %s fuera de rango\n",info);
            break ;
        case ErrorStringFueraDeRango:
            printf("String : \"%s\" fuera de rango\n", info);
            break ; 
      }

       system ("Pause");
	     exit (1);
      }

int yyerror(void)
     {
       printf("Error sintatico\n");
       system ("Pause");
       exit (1);
     }







