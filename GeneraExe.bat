c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o TPFinal.exe
pause
TPfinal.exe "prueba.txt"
GraficadorArbol.jar 
pause
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del TPFinal.exe
pause
