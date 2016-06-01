c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o TPFinal.exe
pause
TPfinal.exe "prueba.txt"
C:\"Program Files (x86)"\Graphviz2.34\bin\dot -Tpng graphInfo.txt > intermedia.png
pause
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del TPFinal.exe
pause
