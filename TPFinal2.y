
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
#define ErrorEnDeclaracionCantidad 5
#define ErrorIdRepetida 6
#define ErrorIdNoDeclarado 7
#define ErrorIdDistintoTipo 8
//TIPOS DE DATOS
#define TipoEntero 9
#define TipoReal 10
#define TipoCadena 11
//VALORES_MAXIMOS
#define ENTERO_MAXIMO 32768
#define CADENA_MAXIMA 30



//DECLARACION DE FUNCIONES
int yyerrormsj(const char *,int,int); 
void imprimirVariables();
int existeId(char *);
int yyerror();
int obtenerTipo(int);

typedef struct{
	char id[30];
	char valor[50];
	char tipo[10];
} variable ; 

typedef struct{
	int id;
	int valor;
	int tipo;
} indicesVariable;




//DECLARACION DE VARIABLES

variable variables[100];
extern int yylineno;
indicesVariable indices= { 0, 0, 0};
int yystopparser=0;
int  contadorDeIds=0;
int contadorDeTipos=0;
FILE  *yyin;
char *yyltext;
char *yytext;

%}

%union {
	int entero;
	double real;
	char cadena[50];
}

//TOKEN TIPOS DE DATO
%token <cadena>ID
%token <cadena> CADENA
%token <entero> ENTERO
%token <real> REAL


//TOKEN SIMBOLOS
%token COMILLA COMA C_A C_C P_A P_C LL_A LL_C

//TOKEN OPERANDOS
%token OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG  


//TOKEN CONSTANTES

%token CONST_REAL CONST_CADENA CONST_ENTERO

//TOKEN PALABRAS RESERVADAS
%token PROGRAMA FIN_PROGRAMA DECLARACIONES FIN_DECLARACIONES  DIM AS 
%%
programa:  	   
	PROGRAMA {printf(" Inicia COMPILADOR\n");} bloque_declaraciones     
	bloque_sentencias
	FIN_PROGRAMA
	{printf(" Fin COMPILADOR ok\n");} 
	;

bloque_declaraciones:
	DECLARACIONES {printf("		DECLARACIONES\n");} declaraciones 
	FIN_DECLARACIONES
	{printf(" Fin de las Declaraciones\n");}
	;
declaraciones:         	        	
             declaracion
             | declaraciones declaracion
    	     ;

declaracion:  
			DIM C_A lista_var C_C AS C_A lista_tipo C_C 
					{ if(contadorDeIds != contadorDeTipos){ 
							yyerrormsj("",ErrorSintactico,ErrorEnDeclaracionCantidad);
					   }
					   imprimirVariables();
					}
           ;

		 
lista_var:
			ID	   { 
					  if(existeId(yylval.cadena)>=0){
						  yyerrormsj(yylval.cadena,ErrorSemantico,ErrorIdRepetida);
					  }
					  contadorDeIds++;  
					  strcpy(variables[indices.id++].id,yylval.cadena);
					}
			| ID {
					  if(existeId(yylval.cadena)>=0){
						  yyerrormsj(yylval.cadena,ErrorSemantico,ErrorIdRepetida);
					  }
					 contadorDeIds++;  strcpy(variables[indices.id++].id,yylval.cadena); 
					 } COMA lista_var 
 	 ;

tipo: 
		ENTERO
		| REAL
		 | CADENA
		 ;

lista_tipo : 
		tipo	   {contadorDeTipos++; strcpy(variables[indices.tipo++].tipo,yylval.cadena);  }
		| tipo  {contadorDeTipos++;  strcpy(variables[indices.tipo++].tipo,yylval.cadena);   }COMA lista_tipo
		;
bloque_sentencias: 
		sentencia
		| sentencia bloque_sentencias
		;
sentencia: 
		asignacion
		;
	
asignacion: ID  ASIG  expresion  {  
													int indice1, indice2;
													if((indice1=existeId($<cadena>1))<0){
														yyerrormsj(yylval.cadena,ErrorSemantico,ErrorIdNoDeclarado);
													}
												
													if((indice2=existeId(yylval.cadena))<0){
														yyerrormsj(yylval.cadena,ErrorSemantico,ErrorIdNoDeclarado);
													}
													if(obtenerTipo(indice1) != obtenerTipo(indice2)){
														yyerrormsj("",ErrorSemantico,ErrorIdDistintoTipo);
													}
														
												}
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
          if(yylval.entero >= ENTERO_MAXIMO ){
            char entero[10];
            yyerrormsj(itoa(yylval.entero,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
          }
          printf(", Valor: %d\n", yylval);
      }
      | OP_RESTA CONST_ENTERO {
          if(yylval.entero > ENTERO_MAXIMO){
            char entero[10];
            yyerrormsj(itoa(yylval.entero,entero,10),ErrorSemantico,ErrorIntFueraDeRango);
           }
          printf("ENTERO es: -%d\n", yylval);
      }
      | CONST_REAL {
          printf("REAL es: %f\n", yylval.real);
      }
      | CONST_CADENA {
          if(strlen(yylval.cadena)>CADENA_MAXIMA)
              yyerrormsj(yylval.cadena,ErrorSemantico,ErrorStringFueraDeRango);
          printf("CADENA es: %s\n",yylval.cadena);
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

//DEFINICION  DE FUNCIONES

int yyerrormsj(const char * info, int tipoDeError ,int error)
     {
	    printf("Linea: %d. ",yylineno);
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
		case ErrorEnDeclaracionCantidad:
			printf("Descripcion: no coinciden la cantidad de ids declaradas con la cantidad de tipos declarados\n",yylineno);
			break ; 
		case ErrorIdRepetida:
			printf("Descripcion: el id '%s' ha sido declarado mas de una vez\n",info);
			break;
		case ErrorIdNoDeclarado: 
			printf("Descripcion: el id '%s' no ha sido declarado\n",info);
			break;
		case ErrorIdDistintoTipo: 
			printf("Descripcion: Las variables son de distinto tipo\n");
			break;
		
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

void imprimirVariables(){
	int  i;
	for(i = 0; i<indices.id; i++){
		printf("Id: %s, tipo: %s\n",variables[i].id,variables[i].tipo);
	}
}


//retorna la posicion del vector en el que se encuentra la id en caso de que exista.
//retorna -1 si no existe
int existeId(char * id){
	int  i;
	for(i = 0; i<indices.id; i++){
		if(strcmp(variables[i].id,id) == 0)
			return i;
	}
	return -1;
}

int obtenerTipo(int indice){ 
	if(strcmp(variables[indice].tipo,"entero")==0){
		return TipoEntero;
	}else if(strcmp(variables[indice].tipo,"real")==0)
					return TipoReal;
			 else 
					return TipoCadena;
}






