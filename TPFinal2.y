
%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include "y.tab.h"
#include <string.h>
//DEFINES
//TIPOS DE ERROR
#define ErrorSintactico 1
#define ErrorSemantico 2
//ERRORES
#define ErrorIntFueraDeRango 3
#define ErrorStringFueraDeRango 4

//DECLARACION DE FUNCIONES
int yyerrormsj(const char *,int,int); 
int yyerror();

//DECLARACION DE VARIABLES
int yylval;
float real;
char cadena[300];
int yystopparser=0;
FILE  *yyin;
char *yyltext;
char *yytext;

%}

%token ID

//TOKEN SIMBOLOS
%token COMILLA COMA


//TOKEN OPERANDOS
%token OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG P_A P_C LL_A LL_C 

//TOKEN TIPOS DE DATO
%token REAL CADENA ENTERO

//TOKEN CONSTANTES

%token CONST_REAL CONST_CADENA CONST_ENTERO
//TOKEN PALABRAS RESERVADAS
%token PROGRAMA FIN_PROGRAMA DEFINICIONES FIN_DEFINICIONES  
%%
programa:  	   
	PROGRAMA {printf(" Inicia COMPILADOR\n");} bloque_declaraciones     
	FIN_PROGRAMA
	{printf(" Fin COMPILADOR ok\n");}
	

bloque_declaraciones:
	DEFINICIONES {printf("     DECLARACIONES\n");} declaraciones 
	FIN_DEFINICIONES
	{printf(" Fin de las Declaraciones\n");}
	;
declaraciones:         	        	
             declaracion
             | declaraciones declaracion
    	     ;

declaracion:  
            REAL  {	printf("Declaracion de reales: "); } lista_var 	   
	       |CADENA { 	printf("Declaracion de cadenas: "); 	} lista_var   
           |ENTERO {	printf("Declaracion de enteros: "); } lista_var   
           ;

lista_var:
      asignacion | ID { printf("Id: %s. ", cadena); }
	 | asignacion COMA  lista_var | ID { printf("Id: %s, ", cadena); } COMA  lista_var 
 	 ;

asignaciones: 
	asignacion 
	| asignaciones asignacion 
	;
	
asignacion: ID { printf("Id: %s", cadena); } ASIG expresion
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
      | CONST_ENTERO {
          if(yylval >=32768){
            char entero[10];
            yyerrormsj(itoa(yylval,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
          }
          $1 = yylval;
          printf(", Valor: %d\n", yylval);
      }
      | OP_RESTA CONST_ENTERO {
          if(yylval > 32768){
            char entero[10];
            yyerrormsj(itoa(yylval,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
           }
          $1 = yylval;
          printf("ENTERO es: -%d\n", yylval);
      }
      | CONST_REAL {
          $1 = yylval;
          printf("REAL es: %f\n", real);
      }
      | CONST_CADENA {
          if(strlen(cadena)>30)
              yyerrormsj(cadena,ErrorSemantico,ErrorStringFueraDeRango);
          printf("CADENA es: %s\n",cadena);
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
            printf("Cadena: \"%s\" fuera de rango\n", info);
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







