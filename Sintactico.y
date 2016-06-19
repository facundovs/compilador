
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
	enum tipoDeError{
		ErrorSintactico,
		ErrorLexico
	};

	enum error{
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

	enum tipoDeDato{
		TipoEntero,
		TipoReal,
		TipoCadena,
		SinTipo
	};

	enum valorMaximo{
		ENTERO_MAXIMO = 32768,
		CADENA_MAXIMA = 31,
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
		int nro;
		int nroNodo;
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
	int yyerrormsj(const char *,enum tipoDeError,enum error); 
	void imprimirVariables();
	int existeId(char *);
	int yyerror();
	enum tipoDeDato obtenerTipo(int);
	enum tipoDeDato obtenerTipoConstante(int);
	enum tipoDeDato obtenerTipoASM(char*);
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
	t_nodo * copiarNodo(t_nodo*);
	int elementosEnPilaWhile =0;
	int elementosEnPilaIf =0;
	void generarAssembler(t_nodo*);
	void recorrerGenerandoCodigo(t_nodo*, FILE*);
	void generarArchivoGraphViz(t_nodo*);
	void enumerarNodos(t_nodo*);
	void recorrerGenerandoViz(const t_nodo*, FILE*);
	t_nodo * crearHojaT(const char*);
	char * cortarCadena(char*,int);
	char * obtenerNombre(char* );
	int esHoja(t_nodo*);
	void grabarOperacionAssembler(t_nodo*, t_nodo*, t_nodo*, FILE*);
	int contarAux(t_nodo*);
	char * reemplazarCaracter(char const *,  char const *,  char const *);
	void grabarManejoDeCadenas(FILE*);

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
	t_pila pilaNroIf;
	t_pila pilaNroWhile;
	t_nodo comparacion1;
	t_nodo all_equal1;
	//
	int cantListasAllEqual=0;
	t_pila pilasAllEqual[TAM];
	int nroNodo=0;
	int nroAux;
	int nroElse=0;
	int contIf=0;
	int nroWhile=0;
	int contWhile=0;
	int esCondWhile; //1=while   0=if
	int esOr=0;
	int esAnd=0;
	int contCondiciones=1;
	unsigned long entero64bits;
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
	%token OP_CONCAT
	%left OP_SUMA OP_RESTA OP_MUL OP_DIV ASIG
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
		grabarArbol(programa);
		grabarTablaDeSimbolos(0);
		generarArchivoGraphViz(programa);
		generarAssembler(programa);
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
		|  bloque_sentencias sentencia
						{
							t_info info;strcpy(info.valor,"sentencia"); 
							bloque_sentencias=crearNodo(&info,bloque_sentencias,sentencia);
						}
		;

sentencia: 
		write 				{sentencia=write;}
		| read 				{sentencia=read;}
		| asignacion 		{sentencia=asignacion;}
		| sentencia_if		{sentencia=sentencia_if; }
		| sentencia_while 	{sentencia=sentencia_while;}
		;

sentencia_if: 
	IF P_A condicion P_C  
	{
		t_info info;
		strcpy(info.valor,"if"); 
		ponerEnPila(&pilaIf,crearNodo(&info,condicion,NULL));
		if(bloque_sentencias)
			ponerEnPila(&pilabloques,bloque_sentencias);
	}
	bloque_if ENDIF
	{
		sentencia_if =(t_nodo *) malloc (sizeof(t_nodo));
		sacar_de_pila(&pilaIf,sentencia_if);
		insertarHijo(&(sentencia_if->der),bloque_sentencias);
		bloque_sentencias = sacar_de_pila2(&pilabloques);
	}
	;

sentencia_while: 
	WHILE P_A condicion P_C  
	{
		t_info info;
		strcpy(info.valor,"while"); 
		ponerEnPila(&pilaWhile,crearNodo(&info,condicion,NULL));
		if(bloque_sentencias)
			ponerEnPila(&pilabloques,bloque_sentencias);
	}
	bloque_sentencias ENDWHILE
	{
		sentencia_while =(t_nodo *) malloc (sizeof(t_nodo));
		sacar_de_pila(&pilaWhile,sentencia_while);
		insertarHijo(&(sentencia_while->der),bloque_sentencias);
		bloque_sentencias = sacar_de_pila2(&pilabloques);
		printf("while OK\n");
	}
	;

bloque_if:
 bloque_sentencias 
 	{
 		 bloque_if=bloque_sentencias;	
 		printf("if sin else OK\n");
 	}
 |bloque_sentencias  {
 	ponerEnPila(&pilabloqueif,bloque_sentencias);
 }
 	ELSE bloque_sentencias 
 	{
 		t_info info;
		strcpy(info.valor,"bloque if");
 		bloque_if = crearNodo(&info,sacar_de_pila2 (&pilabloqueif),bloque_sentencias);
		//printf("BLOQUE ELSE: %s, %s, %s\n",bloque_sentencias->info.valor,bloque_sentencias->izq->info.valor,bloque_sentencias->der->info.valor);
 		bloque_sentencias=bloque_if;
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
		allequal {condicion=all_equal;}
		| comparacion {condicion=comparacion;}
		| OP_NOT allequal
		| OP_NOT comparacion {
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
							 
		| allequal 
		{
			all_equal1 = * all_equal;
		}
		and_or
		allequal
		{
			t_nodo * aux;
			aux = (t_nodo *) malloc(sizeof(t_nodo));
			t_nodo * aux1;
			aux1 = (t_nodo *) malloc(sizeof(t_nodo));
			*aux1 = all_equal1;
			*aux = * all_equal;
			t_nodo * aux2;
			aux2 = (t_nodo *) malloc(sizeof(t_nodo));
			*aux2=*and_or;
			insertarHijo(&(aux2->izq),aux1);
			insertarHijo(&(aux2->der),aux);
			condicion = aux2;	
		}
		| comparacion
		{
			comparacion1 = * comparacion;
		} 
		and_or comparacion
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
		;

comparacion_filter:
	GB COMPARADOR { 	
									t_info info;
									strcpy(info.valor,yylval.cadena);
									condicion_filter  = crearHoja(&info);}
		expresion { 	
					insertarHijo(&(condicion_filter->der),expresion);
		}
	; 
condicion_filter:
		comparacion_filter	
		| OP_NOT GB comparacion_filter{
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
		| comparacion_filter and_or comparacion_filter
		;

lista_var_filter:
			ID	 { if(existeId(yylval.cadena)== -1 ){  yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} 

						t_info info2;
						strcpy(info2.valor,"if"); 
						t_info info;
						t_nodo *copiaCondicion=copiarNodo(condicion_filter);
						strcpy(info.valor,yylval.cadena);
						//Bloque if
						t_info filter_bloque;
						strcpy(filter_bloque.valor,"bloque if");
						//NodoAsignacion
						t_info filter_info;
						strcpy(filter_info.valor,"=");
						t_nodo *asignacionFilter=crearNodo(&filter_info,crearHojaT("@filter"),crearHojaT(yylval.cadena));
						t_nodo *asignacionNull=crearNodo(&filter_info,crearHojaT("@filter"),crearHojaT("null"));
						t_nodo *nodo_bloque_if=crearNodo(&filter_bloque,asignacionFilter,asignacionNull);
						insertarHijo(&(copiaCondicion->izq),crearHojaT(yylval.cadena));
						lista_var_filter = crearNodo(&info2,copiaCondicion,nodo_bloque_if);
						ponerEnPila(&pilaFilter,lista_var_filter);
			}
			| 
			 lista_var_filter COMA ID 
				{if(existeId(yylval.cadena)== -1 ){yyerrormsj(yylval.cadena,ErrorSintactico,ErrorIdNoDeclarado);} 
						t_nodo *aux=lista_var_filter->der->izq;
						t_info info; 
						t_nodo *copiaCondicion=copiarNodo(condicion_filter);
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
						t_nodo* asignacionFilter=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_der));
						t_info filter_no_encontrado;
						strcpy(filter_no_encontrado.valor,"null");
						t_nodo *asignacionNull=crearNodo(&filter_info,crearHoja(&filter_izq),crearHoja(&filter_no_encontrado));
						t_nodo *nodo_bloque_trueFalse=crearNodo(&info3,asignacionFilter,asignacionNull);
						t_nodo *nodo_if=crearNodo(&info2,copiaCondicion,nodo_bloque_trueFalse);
						t_nodo *nodo_bloque_if=crearNodo(&info3,aux,nodo_if);
						*(lista_var_filter->der)=*nodo_bloque_if;
						lista_var_filter=nodo_bloque_if->der;
					} 
			;
	
allequal: 
		ALLEQUAL { limpiarVector(cantExpLE,TAM); } P_A lista_exp P_C 
		{  
			if(! longLEsValidas())
				yyerrormsj("Las listas de expresiones tienen distintas longitudes",ErrorSintactico,ErrorAllEqual);
			if(contadorListaExp==1)
				yyerrormsj("Se deben ingresar como minimo dos listas de expresiones",ErrorSintactico,ErrorAllEqual);
			contadorListaExp=0; printf("AllEqual OK \n");
			printf("Cantidad de listas: %d\n",cantListasAllEqual);
			t_info nodo_allEqual;
			strcpy(nodo_allEqual.valor,"AllEqual");
			t_info info_igual;
			strcpy(info_igual.valor,"==");
			t_info info_if;
			strcpy(info_if.valor,"if");
			t_info asignacion;
			strcpy(asignacion.valor,"=");
			t_nodo *nodo_resultado_true=crearNodo(&asignacion,crearHojaT("@allequal"),crearHojaT("true"));
			t_nodo *nodo_resultado_false=crearNodo(&asignacion,crearHojaT("@allequal"),crearHojaT("false"));
			t_info info_bloque_if;
			strcpy(info_bloque_if.valor,"bloque if");
			t_nodo *bloque_if=crearNodo(&info_bloque_if,nodo_resultado_true,nodo_resultado_false);
			t_nodo *copia_bloque_if=copiarNodo(bloque_if);
			all_equal=crearNodo(&nodo_allEqual,NULL,crearHojaT("@allequal"));
			t_nodo *nodo_if=crearNodo(&info_if,NULL,copia_bloque_if);
			t_nodo *ultimoComparado=sacar_de_pila2(&pilasAllEqual[0]);
			insertarHijo(&(nodo_if->izq),crearNodo(&info_igual,copiarNodo(ultimoComparado),sacar_de_pila2(&pilasAllEqual[1])));
			int pilasVisitadas=2;
			insertarHijo(&(all_equal->izq),nodo_if);
			t_nodo *proximoModificado=copia_bloque_if;
			while(cantExpLE[0]>0){
				for(pilasVisitadas;pilasVisitadas<cantListasAllEqual;pilasVisitadas++){
					copia_bloque_if=copiarNodo(bloque_if);
					t_nodo * aux_comparacion=crearNodo(&info_igual,ultimoComparado,sacar_de_pila2(&pilasAllEqual[pilasVisitadas]));
					t_nodo * aux_if=crearNodo(&info_if,aux_comparacion,copia_bloque_if);
					insertarHijo(&(proximoModificado->izq),aux_if);
					proximoModificado=copia_bloque_if;
				}
				cantExpLE[0]--;
				if(cantExpLE[0]>0){
					copia_bloque_if=copiarNodo(bloque_if);
					ultimoComparado=sacar_de_pila2(&pilasAllEqual[0]);
					t_nodo * aux_comparacion=crearNodo(&info_igual,copiarNodo(ultimoComparado),sacar_de_pila2(&pilasAllEqual[1]));
					t_nodo * aux_if=crearNodo(&info_if,aux_comparacion,copia_bloque_if);
					insertarHijo(&(proximoModificado->izq),aux_if);
					proximoModificado=copia_bloque_if;
					pilasVisitadas=2;
				}
			}
			cantListasAllEqual=0;
		}
		;
		
filter:
	FILTER P_A  condicion_filter COMA 
										{

										}
	C_A lista_var_filter C_C P_C  { 
										t_info info;  
										strcpy(info.valor,"FILTER");
										t_info filter_info;
										strcpy(filter_info.valor,"@filter");
										filter= crearNodo(&info,sacar_de_pila2(&pilaFilter),crearHoja(&filter_info));
										printf("Filter OK\n"); }
	;

write:  
	WRITE CONST_CADENA {
							//Guardamos la cadena
					        if(strlen(yylval.cadena)>CADENA_MAXIMA)
								yyerrormsj(yylval.cadena,ErrorLexico,ErrorStringFueraDeRango);
					        printf("CADENA es: %s\n",yylval.cadena);
							int ret=existeCte();
							if(ret==0){
								  strcpy(tablaConstantes[indiceConstante].nombre,"_");
								  strcat(tablaConstantes[indiceConstante].nombre,reemplazarCaracter(yylval.cadena," ","_"));
								  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
								  strcpy(tablaConstantes[indiceConstante].tipo,"const_cadena");
								  tablaConstantes[indiceConstante].longitud=strlen(yylval.cadena);
								  indiceConstante++;
							}
							write=crearHojaT("WRITE");
							insertarHijo(&write->izq,crearHojaT("stdout"));
							t_info info;
							strcpy(info.valor,"_");
							strcat(info.valor,reemplazarCaracter(yylval.cadena," ","_"));
							insertarHijo(&write->der,crearHoja(&info));
							printf("Write OK\n");
						}  
	|	WRITE ID {
					if(existeId($<cadena>2)==-1){
						yyerrormsj($<cadena>2,ErrorSintactico,ErrorIdNoDeclarado);
					}
					write=crearHojaT("WRITE");
					insertarHijo(&write->izq,crearHojaT("stdout"));
					insertarHijo(&write->der,crearHojaT(yylval.cadena));
					printf("Write OK\n");
			}
	;

read:
	READ ID { 
			if(existeId($<cadena>2)==-1){
				yyerrormsj($<cadena>2,ErrorSintactico,ErrorIdNoDeclarado);
			}
			read=crearHojaT("READ");
			insertarHijo(&read->izq,crearHojaT("stdin"));
			insertarHijo(&read->der,crearHojaT(yylval.cadena));
			printf("Read OK\n");
		}		
	;

lista_exp:
		C_A {
			pilasAllEqual[cantListasAllEqual]=(t_nodoPila*)malloc(sizeof(t_nodoPila));
		}
		expresiones C_C { 
			contadorListaExp++;
			cantListasAllEqual++;
			 }
		|lista_exp COMA C_A  
		{
			pilasAllEqual[cantListasAllEqual]=(t_nodoPila*)malloc(sizeof(t_nodoPila));
		}
		expresiones C_C 
		{ 
			contadorListaExp++; 
			cantListasAllEqual++;
		}
		;

expresiones:
		expresion {
			ponerEnPila(&(pilasAllEqual[cantListasAllEqual]),expresion);
			printf("Expresion: %s\n",expresion->info.valor);
		cantExpLE[contadorListaExp] ++;
		}
		|expresiones COMA  expresion { 
			cantExpLE[contadorListaExp] ++;
			printf("Expresion en lista: %s\n",expresion->info.valor);
			ponerEnPila(&(pilasAllEqual[cantListasAllEqual]),expresion);
		}
		;

and_or:
	AND	{
			t_info info;
			strcpy(info.valor,"and");
			and_or= crearHoja(&info);
		}
	| OR {
			t_info info;
			strcpy(info.valor,"or");
			and_or= crearHoja(&info);
		 }
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
	 |expresion OP_RESTA 
	 {
	 	/*t_info info;
	 	strcpy(info.valor,"-");
	 	expresion=crearNodo(&info,expresion,NULL);
	 	printf("Expresion: %s\n", yylval.cadena);*/
	 }
	 termino
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
		  char aux[50];
		  strcpy(aux,yylval.cadena);
          if(atoi(cortarCadena(aux,6)) >= ENTERO_MAXIMO ){
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
		  char aux1[50];
		  strcpy(aux1,yylval.cadena);
          if(atoi(cortarCadena(aux1,6)) > ENTERO_MAXIMO){
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
			  strcat(tablaConstantes[indiceConstante].nombre,reemplazarCaracter(yylval.cadena,".","_"));
			  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_real");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
  		  t_info info;
		  strcpy(info.valor, "_");
		  strcat(info.valor,reemplazarCaracter(yylval.cadena,".","_"));
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
			  strcat(tablaConstantes[indiceConstante].nombre,reemplazarCaracter(yylval.cadena,".","_"));
			  strcpy(tablaConstantes[indiceConstante].valor,"-");
			  strcat(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_real");
			  tablaConstantes[indiceConstante].longitud=0;
			  indiceConstante++;
		  }
		  t_info info;
		  strcpy(info.valor, "_-");
		  strcat(info.valor,reemplazarCaracter(yylval.cadena,".","_"));
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
			  strcat(tablaConstantes[indiceConstante].nombre,reemplazarCaracter(yylval.cadena," ","_"));
			  strcpy(tablaConstantes[indiceConstante].valor,yylval.cadena);
			  strcpy(tablaConstantes[indiceConstante].tipo,"const_cadena");
			  tablaConstantes[indiceConstante].longitud=strlen(yylval.cadena);
			  indiceConstante++;
		}
		t_info info;
		strcpy(info.valor, "_");
		strcat(info.valor,reemplazarCaracter(yylval.cadena," ","_"));
		factor = crearHoja(&info);
      }
      |P_A expresion P_C  {expresion=factor;}
	  | filter { factor = filter; }
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

/////////////////////////////////////DEFINICION  DE FUNCIONES///////////////////////////////////////////////////

int yyerrormsj(const char * info,enum tipoDeError tipoDeError ,enum error error)
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
            printf("Entero %s fuera de rango [-%d ; %d]\n",info,ENTERO_MAXIMO,ENTERO_MAXIMO-1);
            break ;
		case ErrorFloatFueraDeRango: 
            printf("Real %s fuera de rango. Debe ser un real de 32bits\n",info);
            break ;
        case ErrorStringFueraDeRango:
            printf("Cadena: \"%s\" fuera de rango. La longitud maxima es 30 caracteres\n", info);
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
	strcat(aux,reemplazarCaracter(yylval.cadena," ","_"));
	for(j = 0; j<indiceConstante; j++){
		if(strcmp(tablaConstantes[j].nombre,aux) == 0){
			return 1;
			}
	}
	return 0;
}

char* obtenerNombre(char* id){
	/*char aux[50];
	strcpy(aux,"_");
	strcat(aux,id);
	strcpy(id, aux);*/
	return id;
}

enum tipoDeDato obtenerTipo(int indice){ 
	if(strcmp(tablaVariables[indice].tipo,"entero")==0){
		return TipoEntero;
	}else if(strcmp(tablaVariables[indice].tipo,"real")==0)
					return TipoReal;
			 else 
					return TipoCadena;
}

enum tipoDeDato obtenerTipoConstante(int indice){ 
	if(strcmp(tablaConstantes[indice].tipo,"const_entero")==0){
		return TipoEntero;
	}else if(strcmp(tablaConstantes[indice].tipo,"const_real")==0)
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

char * cortarCadena(char* cad,int tam){
	if(strlen(cad)>tam)
		cad[tam]='\0';
	return cad;
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

char * reemplazarCaracter(char const * const original,  char const * const pattern,  char const * const replacement) 
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

///////////////////////// FUNCIONES ARBOL //////////////////////////////////////////////

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

	t_nodo * crearHojaT(const char* info)
	{
	    t_nodo *p = (t_nodo*) malloc(sizeof(t_nodo));
	    if(!p){ 
	    	printf("No hay memoria disponible. El programa se cerrará\n");
	    	exit(1);
	    }
	    strcpy(p->info.valor,info);
	    p->der=p->izq=NULL;
	    return p;
	}

	void insertarHijo (t_nodo ** puntero, t_nodo * hijo){
		*puntero=hijo;
	}

	t_nodo * copiarNodo(t_nodo* nodo){
		if(!nodo)
			return NULL;
		t_nodo *nuevo=(t_nodo*)malloc(sizeof(t_nodo));
		nuevo->info=nodo->info;
		if(nodo->izq)
			nuevo->izq=copiarNodo(nodo->izq);
		else
			nuevo->izq=NULL;
		if(nodo->der)
			nuevo->der=copiarNodo(nodo->der);
		else
			nuevo->der=NULL;
		return nuevo;
	}

	int esHoja(t_nodo* nodo){
		if(nodo->izq==NULL&&nodo->der==NULL)
			return 1;
		return 0;
	}

	int contarAux(t_nodo* nodo){
		if(nodo){
			if(strcmp(nodo->info.valor,"*") ==0||strcmp(nodo->info.valor,"-")==0
				||strcmp(nodo->info.valor,"+") ==0||strcmp(nodo->info.valor,"/")==0
				||strcmp(nodo->info.valor,"++") ==0)
				return 1+contarAux(nodo->izq)+contarAux(nodo->der);
			else 
				return contarAux(nodo->izq)+contarAux(nodo->der);
		}
		return 0;
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
		FILE*pf=fopen("intermedia.txt","w+");
		if(!pf){
			printf("Error al guardar el arbol\n");
			return;
		}
		fprintf(pf,"%-32s|\t%-32s|\t%-32s\n","PADRE","HIJO IZQ","HIJO DER");
		recorrer_guardando(arbol,pf);
		fclose(pf);
	}

	void recorrerGenerandoCodigo(t_nodo* nodo, FILE* pf)
	{
	    if(nodo)
	    {
	    	if(strcmp(nodo->info.valor,"if")==0){
	    		contIf++;
	    		contCondiciones=1;
	    		t_info info;
	    		info.nro=contIf;
	    		ponerEnPila(&pilaNroIf,crearHoja(&info));
	    		if(strcmp(nodo->izq->info.valor,"AllEqual")!=0)
		    		fprintf(pf,"if_%d:\n",contIf);
	    		esCondWhile=0;
	    		if(strcmp(nodo->der->info.valor,"bloque if")==0){
	    			nroElse++;
	    		}
	    	}
	    	/*if(strcmp(nodo->info.valor,"AllEqual")==0){
	    		contIf++;
	    		t_info info;
	    		info.nro=contIf;
	    		ponerEnPila(&pilaNroIf,crearHoja(&info));
	    		fprintf(pf,"if_%d:\n",contIf);
	    		esCondWhile=0;
	    		if(strcmp(nodo->der->info.valor,"bloque if")==0){
	    			nroElse++;
	    		}
	    	}*/
	    	if(strcmp(nodo->info.valor,"while")==0){
	    		contCondiciones=1;
	    		contWhile++;
	    		t_info info;
	    		info.nro=contWhile;
	    		ponerEnPila(&pilaNroWhile,crearHoja(&info));
	    		fprintf(pf,"while_%d:\n",contWhile);
	    		esCondWhile=1;
	    	}
	    	if(strcmp(nodo->info.valor,"or")==0){
	    			esOr=1;
	    			if(nroElse != 0)
	    				nroElse++;
	    	}
	    	if(strcmp(nodo->info.valor,"and")==0){
	    	    	if(nroElse != 0)
	    				nroElse++;
	    	}
	    	recorrerGenerandoCodigo(nodo->izq,pf);
	    	if(strcmp(nodo->info.valor,"if")==0){
				fprintf(pf,"true_if_%d:\n",(*pilaNroIf).info.info.nro);
	    	}
	    	if(strcmp(nodo->info.valor,"while")==0){
				fprintf(pf,"true_while_%d:\n",(*pilaNroWhile).info.info.nro);
	    	}
	    	if(strcmp(nodo->info.valor,"bloque if")==0){
	    		fprintf(pf,"\tjmp\t end_if_%d\n",(*pilaNroIf).info.info.nro);
	    		fprintf(pf,"else_if_%d:\n",(*pilaNroIf).info.info.nro);
	    	}
	    	recorrerGenerandoCodigo(nodo->der,pf);
	    	if(esHoja(nodo)==0&&esHoja(nodo->izq)&&esHoja(nodo->der)){ //Si solo tiene hijos hojas
	   			grabarOperacionAssembler(nodo->izq,nodo->der,nodo,pf);
	   		}
	    }
	}

	void grabarOperacionAssembler(t_nodo* op1, t_nodo *op2, t_nodo *opr, FILE* pf){
		//aux
		char aux[50]="Aux\0";
		char aux2[10];
		itoa(nroAux,aux2,10);
	   	strcat(aux,aux2);

		//OPERADORES ARITMETICOS
			if(strcmp(opr->info.valor,"*")==0){
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfmul\n");
				//Guardar el resultado en @aux
				fprintf(pf,"\tfstp \t@%s\n", aux);
				nroAux++;
			}
			if(strcmp(opr->info.valor,"+")==0){
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfadd\n");
				//Guardar el resultado en @aux
				fprintf(pf,"\tfstp \t@%s\n", aux);
				nroAux++;
			}
			if(strcmp(opr->info.valor,"/")==0){
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfdiv\n");
				//Guardar el resultado en @aux
				fprintf(pf,"\tfstp \t@%s\n", aux);
				nroAux++;
			}
			if(strcmp(opr->info.valor,"-")==0){
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfsub\n");
				//Guardar el resultado en @aux
				fprintf(pf,"\tfstp \t@%s\n", aux);
				nroAux++;
			}
		
		//COMPARADORES
			if(strcmp(opr->info.valor,">")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						if(! esOr)
							fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjbe\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						else
							fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\ttrue_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						if(! esOr)
							fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjbe\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
						else
							fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\ttrue_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					if(! esOr)
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\tend_while_%d\n",(*pilaNroWhile).info.info.nro);
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\tend_while_%d\n",(*pilaNroWhile).info.info.nro);
				}
				esOr=0;
			}
			if(strcmp(opr->info.valor,"<")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjae\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjae\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjae\t\tend_while_%d\n",contWhile);
				}
			}
			if(strcmp(opr->info.valor,"<=")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tja\t\tend_while_%d\n",contWhile);
				}
			}
			if(strcmp(opr->info.valor,">=")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjb\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjb\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjb\t\tend_while_%d\n",contWhile);
				}
			}
			if(strcmp(opr->info.valor,"==")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjne\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjne\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjne\t\tend_while_%d\n",contWhile);
				}
			}
			if(strcmp(opr->info.valor,"!=")==0){
				if(esCondWhile==0){//if
					fprintf(pf,"cond_if_%d_%d:\n",(*pilaNroIf).info.info.nro,contCondiciones++);
				}
				else{
					fprintf(pf,"cond_while_%d_%d:\n",contWhile,contCondiciones++);
				}
				fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
				fprintf(pf,"\tfld \t@%s\n", op1->info.valor);
				if(esCondWhile==0){//if
					if(nroElse>0){
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tje\t\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tje\t\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				}
				else{
					fprintf(pf,"\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tje\t\tend_while_%d\n",contWhile);
				}
			}

		//ENDS:  IF - WHILE -ALLEQUAL
			if(strcmp(opr->info.valor,"if")==0){
				int auxIf=sacar_de_pila2(&pilaNroIf)->info.nro;
				fprintf(pf,"end_if_%d:\n",auxIf);
			}
			if(strcmp(opr->info.valor,"while")==0){
				int nro=sacar_de_pila2(&pilaNroWhile)->info.nro;
				fprintf(pf,"\tjmp cond_while_%d\n",nro);
				fprintf(pf,"end_while_%d:\n",nro);
			}
			if(strcmp(opr->info.valor,"AllEqual")==0){
				if(nroElse>0){
						fprintf(pf,"\tfld\t@@allequal\n\tfld\t@true\n\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjne\telse_if_%d\n",(*pilaNroIf).info.info.nro);
						nroElse--;
					}
					else
						fprintf(pf,"\tfld\t@@allequal\n\tfld\t@true\n\tfcomp\n\tfstsw\tax\n\tfwait\n\tsahf\n\tjne\tend_if_%d\n",(*pilaNroIf).info.info.nro);
				//fprintf(pf,"end_if_%d:\n",sacar_de_pila2(&pilaNroIf)->info.nro);
			}
		//CONCATENACION
			if(strcmp(opr->info.valor,"++")==0){
				if(strlen(op1->info.valor)+strlen(op2->info.valor)>=50){
					printf("*ADVERTENCIA: La concatenacion de cadenas excede el tamaño maximo (50)\n");

				}
				fprintf(pf,"\tmov ax, @DATA\n\tmov ds, ax\n\tmov es, ax\n");
				fprintf(pf,"\tmov si, OFFSET\t@%s\n", op1->info.valor);
				fprintf(pf,"\tmov di, OFFSET\t@%s\n",aux);
				fprintf(pf,"\tcall copiar\n");
				fprintf(pf,"\tmov si, OFFSET\t@%s\n",op2->info.valor);
				fprintf(pf,"\tmov di, OFFSET\t@%s\n",aux);
				fprintf(pf,"\tcall concat\n");
				strcpy(aux,"Aux\0");
				itoa(nroAux,aux2,10);
	   			strcat(aux,aux2);
				nroAux++;
			}

		//ASIGNACION
			if(strcmp(opr->info.valor,"=")==0){
				if(obtenerTipoASM(op1->info.valor)==TipoCadena){
					fprintf(pf,"\tmov ax, @DATA\n\tmov ds, ax\n\tmov es, ax\n");
					fprintf(pf,"\tmov si, OFFSET\t@%s\n",op2->info.valor);
					fprintf(pf,"\tmov di, OFFSET\t@%s\n",op1->info.valor);
					fprintf(pf,"\tcall copiar\n");
				}
				else{
					fprintf(pf,"\tfld \t@%s\n", op2->info.valor);
					fprintf(pf,"\tfstp \t@%s\n", op1->info.valor);
				}

			}

		//IN-OUT
			if(strcmp(opr->info.valor,"WRITE")==0){
				if(obtenerTipoASM(op2->info.valor)==TipoEntero)
					fprintf(pf,"\tdisplayFloat \t@%s,3\n\tnewLine 1\n", op2->info.valor);
				else 
					if(obtenerTipoASM(op2->info.valor)==TipoReal)
						fprintf(pf,"\tdisplayFloat \t@%s,3\n\tnewLine 1\n", op2->info.valor);
					else
						if(obtenerTipoASM(op2->info.valor)==TipoCadena)
							fprintf(pf,"\tdisplayString \t@%s\n\tnewLine 1\n", op2->info.valor);
			}

			if(strcmp(opr->info.valor,"READ")==0){
				if(obtenerTipoASM(op2->info.valor)==TipoEntero)
					fprintf(pf,"\tgetFloat \t@%s\n", op2->info.valor);
				else 
					if(obtenerTipoASM(op2->info.valor)==TipoReal)
						fprintf(pf,"\tgetFloat \t@%s\n", op2->info.valor);
					else
						if(obtenerTipoASM(op2->info.valor)==TipoCadena)
							fprintf(pf,"\tgetString \t@%s\n", op2->info.valor);
			}

		//MODIFICACION DE NODO Y ELIMINACION DE HIJOS HOJAS
			if(strcmp(opr->info.valor,"FILTER")==0)
				strcpy(opr->info.valor,"@filter");
			else
				strcpy(opr->info.valor,aux);
			opr->izq=NULL;
			opr->der=NULL;
	}

	void generarAssembler(t_nodo* arbol){
		FILE*pf=fopen("Final.txt","w+");
		if(!pf){
			printf("Error al guardar el arbol\n");
			return;
		}
		fprintf(pf,"include macros2.asm\n");
		fprintf(pf,"include number.asm\n\n");
		fprintf(pf,".MODEL LARGE\n.STACK 200h\n.386\n.387\n.DATA\n\n\tMAXTEXTSIZE equ 50\n\t@true dd 1.0\n\t@false dd 0.0\n");
		int i;

		//DECLARACION DE VARIABLES
		for(i = 0; i<indicesVariable.nombre; i++){
			fprintf(pf,"\t@%s ",tablaVariables[i].nombre);
			if(obtenerTipo(i)==TipoEntero)
				fprintf(pf,"\tDD 0.0\n");
			else
				if (obtenerTipo(i)==TipoReal)
					fprintf(pf,"\tDD 0.0\n");
				else
					if(obtenerTipo(i)==TipoCadena)
						fprintf(pf,"\tDB MAXTEXTSIZE dup (?),'$'\n");
		}

		//DECLARACION DE CONSTANTES
		for(i = 0; i<indiceConstante; i++){
			if(obtenerTipoConstante(i)==TipoEntero)
				fprintf(pf,"\t@%s \tDD %d.0\n",tablaConstantes[i].nombre,atoi(tablaConstantes[i].valor));
			else
				if (obtenerTipoConstante(i)==TipoReal)
					fprintf(pf,"\t@%s \tDD %s\n",tablaConstantes[i].nombre,tablaConstantes[i].valor);
				else
					if(obtenerTipoConstante(i)==TipoCadena)
						fprintf(pf,"\t@%s \tDB \"%s\",'$',%d dup(?)\n",tablaConstantes[i].nombre,tablaConstantes[i].valor,50-strlen(tablaConstantes[i].valor));
		}
		
		//DECLARACION DE AUXILIARES
		int cantAux=contarAux(arbol);
		int j;
		for(j=0;j<cantAux;j++){
			fprintf(pf,"\t@Aux%d \tDD 0.0\n",j+1);
		}
		fprintf(pf,"\t@@filter \tDD 0.0\n");
		fprintf(pf,"\t@@allequal \tDD 0.0\n");
		fprintf(pf,"\t@null \tDD -1.0\n");
		fprintf(pf,"\n.CODE\n.startup\n\tmov AX,@DATA\n\tmov DS,AX\n\n\tFINIT\n\n");
		nroAux=1;

		//GENERACION DE CODIGO
		recorrerGenerandoCodigo(arbol, pf);
		fprintf(pf,"\tmov ah, 4ch\n\tint 21h\n\n;FIN DEL PROGRAMA DE USUARIO\n");

		//PROCEDIMIENTOS
		grabarManejoDeCadenas(pf);

		//FIN DE ARCHIVO
		fprintf(pf,"\nend");
		fclose(pf);
	}

	void grabarManejoDeCadenas(FILE *pf){
		fprintf(pf,"\nstrlen proc\n\tmov bx, 0\n\tstrl01:\n\tcmp BYTE PTR [si+bx],'$'\n\tje strend\n\tinc bx\n\tjmp strl01\n\tstrend:\n\tret\nstrlen endp\n");
		fprintf(pf,"\ncopiar proc\n\tcall strlen\n\tcmp bx , MAXTEXTSIZE\n\tjle copiarSizeOk\n\tmov bx , MAXTEXTSIZE\n\tcopiarSizeOk:\n\tmov cx , bx\n\tcld\n\trep movsb\n\tmov al , '$'\n\tmov byte ptr[di],al\n\tret\ncopiar endp\n");
		fprintf(pf,"\nconcat proc\n\tpush ds\n\tpush si\n\tcall strlen\n\tmov dx , bx\n\tmov si , di\n\tpush es\n\tpop ds\n\tcall strlen\n\tadd di, bx\n\tadd bx, dx\n\tcmp bx , MAXTEXTSIZE\n\tjg concatSizeMal\n\tconcatSizeOk:\n\tmov cx , dx\n\tjmp concatSigo\n\tconcatSizeMal:\n\tsub bx , MAXTEXTSIZE\n\tsub dx , bx\n\tmov cx , dx\n\tconcatSigo:\n\tpush ds\n\tpop es\n\tpop si\n\tpop ds\n\tcld\n\trep movsb\n\tmov al , '$'\n\tmov byte ptr[di],al\n\tret\nconcat endp\n");
	}

	enum tipoDeDato obtenerTipoASM(char* valor){
		int i;
		for(i = 0; i<indicesVariable.nombre; i++){
			if(strcmp(tablaVariables[i].nombre,valor)==0){
				if(obtenerTipo(i)==TipoEntero)
					return TipoEntero;
				else
					if (obtenerTipo(i)==TipoReal)
						return TipoReal;
					else
						if(obtenerTipo(i)==TipoCadena)
							return TipoCadena;
			}
		}
			

		for(i = 0; i<indiceConstante; i++){
			if(strcmp(tablaConstantes[i].nombre,valor)==0){
				if(obtenerTipoConstante(i)==TipoEntero)
					return TipoEntero;	
				else
					if (obtenerTipoConstante(i)==TipoReal)
						return TipoReal;
					else
						if(obtenerTipoConstante(i)==TipoCadena)
							return TipoCadena;
			}
		}
		return SinTipo;
	}

	void generarArchivoGraphViz(t_nodo *raiz){
		nroNodo=0;
		enumerarNodos(raiz);
		FILE*pf=fopen("graphInfo.txt","w+");
		if(!pf){
			printf("Error al generar el archivo para GraphViz\n");
			return;
		}
		fprintf(pf, "graph g{\n");
		recorrerGenerandoViz(raiz,pf);
		fprintf(pf, "}\n");
		fclose(pf);
	}

	void enumerarNodos(t_nodo *n){
		if(n){
			n->info.nroNodo=nroNodo;
			nroNodo++;
			enumerarNodos(n->izq);
			enumerarNodos(n->der);
		}
	}

	void recorrerGenerandoViz(const t_nodo* nodo, FILE* pf)
	{
	    if(nodo)
	    {
	    	if(nodo->izq!=NULL&&nodo->der!=NULL){
	   			fprintf(pf,"\t%d[label=\"%s\"]\n", nodo->info.nroNodo,nodo->info.valor);
	   			fprintf(pf,"\t%d[label=\"%s\"]\n", nodo->izq->info.nroNodo,nodo->izq->info.valor);
	   			fprintf(pf,"\t%d[label=\"%s\"]\n", nodo->der->info.nroNodo,nodo->der->info.valor);
	   			if(nodo->izq)
	   				fprintf(pf,"\t%d--%d\n", nodo->info.nroNodo,nodo->izq->info.nroNodo);
	   			if(nodo->der)
	   				fprintf(pf,"\t%d--%d\n", nodo->info.nroNodo,nodo->der->info.nroNodo);
	   		}
	    	recorrerGenerandoViz(nodo->izq,pf);
	    	recorrerGenerandoViz(nodo->der,pf);
	    }
	}

/////////////////////////PILA//////////////////////////////////////////////////////////

	void crearPila(t_pila* pp)
	{
	    *pp=NULL; 
	}

	int ponerEnPila(t_pila* pp,t_nodo* nodo)
	{
	    t_nodoPila* pn=(t_nodoPila*)malloc(sizeof(t_nodoPila));
	    if(!pn)
	        return 0;
	    pn->info=*nodo;
	    pn->psig=*pp;
	    *pp=pn;
	    return 1;
	}

	int sacar_de_pila(t_pila* pp,t_nodo* info)
	{
	    if(!*pp){
	    	printf("PILA NULA**************************************************\n");
	    	return 0;
	    }
	    *info=(*pp)->info;
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
	    *pp=(*pp)->psig;
	    return info;

	}

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