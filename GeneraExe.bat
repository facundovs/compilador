c:\GnuWin32\bin\flex Lexico.l
pause
c:\GnuWin32\bin\bison -dyv Sintactico.y
pause
c:\MinGW\bin\gcc.exe lex.yy.c y.tab.c -o TPFinal.exe
pause
TPfinal.exe "prueba.txt"
C:\"Program Files"\Graphviz2.38\bin\dot -Tpng graphInfo.txt > intermedia.png
.\intermedia.png
COPY .\Final.txt C:\Tasm4\Final.txt
pause
del lex.yy.c
del y.tab.c
del y.output
del y.tab.h
del TPFinal.exe
del graphInfo.txt
pause
