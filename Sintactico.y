
%{
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
	} registro ; 
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

%}

%union {
	int entero;
	double real;
	char cadena[50];
}

////////////////////////////////////TOKENS//////////////////////////
	//TOKEN TIPOS DE DATO
	%token <cadena>ID
	%token <cadena>CADENA
	%token <entero>ENTERO
	%token <real>REAL
	
	//TOKEN SIMBOLOS
	%token COMILLA COMA C_A C_C  P_C P_A GB
	
	//TOKEN OPERANDOS
	%token OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG  OP_CONCAT
	
	//TOKEN COMPARADORES
	%token COMPARADOR AND OR OP_NOT
	
	//TOKEN CONSTANTES
	%token CONST_REAL CONST_CADENA CONST_ENTERO
	
	//TOKEN PALABRAS RESERVADAS
	%token PROGRAMA FIN_PROGRAMA DECLARACIONES FIN_DECLARACIONES DIM AS IF ELSE THEN ENDIF WHILE ENDWHILE ALLEQUAL WRITE READ FILTER
	
%%

programa:  	   
	PROGRAMA {printf("INICIA PROGRAMA\n");} bloque_declaraciones     
	bloque_sentencias
	FIN_PROGRAMA
	{
		programa=bloque_sentencias;
		printf("FIN DEL PROGRAMA, COMPILACION OK\n");
		printf("\n\nARBOL\n");
		recorrer_en_orden(programa);
		grabarArbol(programa);
		//dibujar(programa,15,3,7,0);
		grabarTablaDeSimbolos(0);
	} 
	;

bloque_declaraciones:
	DECLARACIONES {printf("DECLARACIONES\n");} declaraciones 
	FIN_DECLARACIONES
	{printf("FIN DE LAS DECLARACIONES\n");}
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
		ID	  
			{ 
				if(existeId(yylval.cadena)>=0){
					yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdRepetida);
				}
				contadorDeIds++;  
				strcpy(tablaVariables[indicesVariable.nombre++].nombre,yylval.cadena);
			}
			| ID {
					if(existeId(yylval.cadena)>=0){
						  yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdRepetida);
					 }
					 contadorDeIds++;  strcpy(tablaVariables[indicesVariable.nombre++].nombre,yylval.cadena); 
					 } COMA lista_var 
 	 ;
	 
lista_var_filter:
			ID	  {if(existeId(yylval.cadena)== -1 ){  yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} }
			| ID   {if(existeId(yylval.cadena)== -1 ){yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} } COMA  lista_var_filter 
			;

tipo: 
		ENTERO
		| REAL
		| CADENA
		 ;

lista_tipo : 
		tipo	   {contadorDeTipos++; strcpy(tablaVariables[indicesVariable.tipo++].tipo,yylval.cadena);  }
		| tipo  {contadorDeTipos++;  strcpy(tablaVariables[indicesVariable.tipo++].tipo,yylval.cadena);   }COMA lista_tipo
		;

bloque_sentencias: 
		sentencia {bloque_sentencias=sentencia;}
		| sentencia bloque_sentencias 
						{
							t_info info;
							strcpy(info.valor,"sentencia"); 
							bloque_sentencias=crearNodo(&info,sentencia,bloque_sentencias);
						}
		;

sentencia: 
		write 				{sentencia=write;}
		| filter 			{sentencia=filter;}
		| read 				{sentencia=read;}
		| asignacion 		{sentencia=asignacion;}
		| sentencia_if		{sentencia=sentencia_if; }
		| sentencia_while 	{sentencia=sentencia_while;}
		;

sentencia_if: 
	IF P_A condicion P_C  bloque_if ENDIF
	{
		t_info info;
		strcpy(info.valor,"if"); 
		sentencia_if = crearNodo(&info,condicion,bloque_if);

	}
	;

sentencia_while: 
	WHILE P_A condicion P_C  bloque_sentencias ENDWHILE 
	{
		t_info info;
		strcpy(info.valor,"while"); 
		sentencia_while = crearNodo(&info,condicion,bloque_sentencias);
		printf("while OK\n");
	}
	;

bloque_if:
 bloque_sentencias 
 	{

 		bloque_if = bloque_sentencias;	
 		printf("if sin else OK\n");
 	}
 |bloque_sentencias {
	t_info info;
	strcpy(info.valor,"bloque if");
 	bloque_if = crearNodo(&info,bloque_sentencias,NULL);
 }
 	ELSE bloque_sentencias 
 	{
 		insertarHijo(&(bloque_if->izq),bloque_sentencias);
 		printf("if con else OK\n");
 	}


comparacion : expresion COMPARADOR {
					t_info info;
					strcpy(info.valor,yylval.cadena);
					comparacion= crearNodo(&info,expresion,NULL);
				} expresion {
					insertarHijo(&(comparacion->der),expresion);
				} ;
condicion:
		allequal
		| comparacion {condicion=comparacion;}
		| OP_NOT allequal
		| OP_NOT comparacion
		| allequal and_or allequal
		| comparacion and_or comparacion
		;
		
condicion_filter:
		GB COMPARADOR expresion
		| OP_NOT GB COMPARADOR expresion
		| GB COMPARADOR expresion and_or GB COMPARADOR expresion
		;
		
allequal: 
		{ limpiarVector(cantExpLE,TAM); } ALLEQUAL P_A lista_exp P_C {   if(! longLEsValidas())
											yyerrormsj("Las listas de expresiones tienen distintas longitudes",ErrorSintactico,ErrorAllEqual);
										if(contadorListaExp==1)
											yyerrormsj("Se deben ingresar como minimo dos listas de expresiones",ErrorSintactico,ErrorAllEqual);
									contadorListaExp=0; printf("AllEqual OK \n");
									}
		;
		
filter:
	FILTER P_A  condicion_filter COMA C_A lista_var_filter C_C P_C  { printf("Filter OK\n"); }
	;

write:  
	WRITE {printf("Funcion Write\n");} CONST_CADENA |
	WRITE ID { 
				if(existeId($<cadena>2)==-1){
					yyerrormsj($<cadena>2,ErrorSintactico,ErrorIdNoDeclarado);
				}
			}
	;

read:
	READ 
		{
			printf("Funcion Read\n");} ID { 
			if(existeId($<cadena>2)==-1){
				yyerrormsj($<cadena>2,ErrorSintactico,ErrorIdNoDeclarado);
			}
		}		
	;

lista_exp:
		C_A expresiones C_C { contadorListaExp++; }
		|C_A expresiones C_C { contadorListaExp++; } COMA lista_exp
		;

expresiones:
		expresion { cantExpLE[contadorListaExp] ++;}
		|expresion { cantExpLE[contadorListaExp] ++;} COMA expresiones
		;

and_or:
	AND
	| OR
	;

asignacion: 
	ID  {	
					int indice;
					if((indice=existeId(yylval.cadena))<0){
						yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);
					}
					strcpy(ultimoId,yylval.cadena);
					tipoAsignacion=obtenerTipo(indice);
					esAsignacion=1;
				} 
					ASIG  expresion
				{
					t_info info;
					strcpy(info.valor,"=");
					t_info info_id;
					strcpy(info_id.valor,ultimoId);
       				asignacion= crearNodo(&info,crearHoja(&info_id),expresion);			  
					printf("Asignacion OK\n"); esAsignacion=0; 
				}
	;

expresion:
     termino {expresion=termino;}
	 |expresion OP_RESTA termino
	 							{
	 								if(tipoAsignacion == TipoCadena) 
	 									yyerrormsj("resta",ErrorSintactico,ErrorOperacionNoValida); 
									else{
										t_info info;
       									strcpy(info.valor,"-");
       									expresion= crearNodo(&info,expresion,termino);
										printf("Resta OK\n");
									} 
								}
     |expresion OP_SUMA termino  
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
	 |expresion OP_CONCAT termino	
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
 	 ;

termino: 
       factor {termino=factor;}
       |termino OP_MUL factor  {
       								t_info info;
       								strcpy(info.valor,"*");
       								termino = crearNodo(&info,termino,factor);
       								printf("Multiplicación OK\n"); 
       							}
       |termino OP_DIV factor  {
       								printf("División OK\n");
       								t_info info;
       								strcpy(info.valor,"/");
       								termino = crearNodo(&info,termino,factor);		
       							}
	   ;

factor:
      ID 
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
      | CONST_ENTERO {
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
      | OP_RESTA CONST_ENTERO {
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
      | CONST_REAL {
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
	  | OP_RESTA CONST_REAL {
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
	    | CONST_CADENA {
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
      |P_A expresion P_C  
	  |filter
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