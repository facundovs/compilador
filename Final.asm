include macros2.asm
include number.asm

.MODEL LARGE
.STACK 200h
.386
.387
.DATA

	MAXTEXTSIZE equ 50
	@true dd 1.0
	@false dd 0.0
	@a 	DD 0.0
	@b 	DD 0.0
	@c 	DB MAXTEXTSIZE dup (?),'$'
	@d 	DB MAXTEXTSIZE dup (?),'$'
	@e 	DD 0.0
	@_Inicio_del_programa 	DB "Inicio del programa",'$',31 dup(?)
	@_10 	DD 10.0
	@_20 	DD 20.0
	@_cadena 	DB "cadena",'$',44 dup(?)
	@__de_prueba 	DB " de prueba",'$',40 dup(?)
	@_2 	DD 2.0
	@_0 	DD 0.0
	@_1 	DD 1.0
	@_a_es_igual_a_cero 	DB "a es igual a cero",'$',33 dup(?)
	@_a_es_distinto_de_cero 	DB "a es distinto de cero",'$',29 dup(?)
	@_Ingrese_un_valor_para_e 	DB "Ingrese un valor para e",'$',27 dup(?)
	@_3 	DD 3.0
	@_5 	DD 5.0
	@_4 	DD 4.0
	@_TRUE 	DB "TRUE",'$',46 dup(?)
	@_FALSE 	DB "FALSE",'$',45 dup(?)
	@_Fin_del_programa 	DB "Fin del programa",'$',34 dup(?)
	@Aux1 	DD 0.0
	@Aux2 	DD 0.0
	@Aux3 	DD 0.0
	@Aux4 	DD 0.0
	@Aux5 	DD 0.0
	@@filter 	DD 0.0
	@@allequal 	DD 0.0
	@null 	DD -1.0

.CODE
.startup
	mov AX,@DATA
	mov DS,AX

	FINIT

	displayString 	@_Inicio_del_programa
	newLine 1
	fld 	@_10
	fstp 	@a
	fld 	@_20
	fstp 	@b
	mov ax, @DATA
	mov ds, ax
	mov es, ax
	mov si, OFFSET	@_cadena
	mov di, OFFSET	@c
	call copiar
	mov ax, @DATA
	mov ds, ax
	mov es, ax
	mov si, OFFSET	@__de_prueba
	mov di, OFFSET	@d
	call copiar
	fld 	@_2
	fstp 	@e
if_1:
cond_if_1_1:
	fld 	@b
	fld 	@a
	fcomp
	fstsw	ax
	fwait
	sahf
	jae		end_if_1
cond_if_1_2:
	fld 	@_20
	fld 	@b
	fcomp
	fstsw	ax
	fwait
	sahf
	jne		end_if_1
true_if_1:
while_1:
cond_while_1_1:
	fld 	@_0
	fld 	@a
	fcomp
	fstsw	ax
	fwait
	sahf
	je		end_while_1
true_while_1:
while_2:
cond_while_2_1:
	fld 	@_1
	fld 	@e
	fcomp
	fstsw	ax
	fwait
	sahf
	jbe		end_while_2
true_while_2:
	fld 	@e
	fld 	@_1
	fsub
	fstp 	@Aux1
	fld 	@Aux1
	fstp 	@e
	jmp cond_while_2_1
end_while_2:
	fld 	@a
	fld 	@_1
	fsub
	fstp 	@Aux2
	fld 	@Aux2
	fstp 	@a
	jmp cond_while_1_1
end_while_1:
if_2:
cond_if_2_1:
	fld 	@_0
	fld 	@a
	fcomp
	fstsw	ax
	fwait
	sahf
	jne		else_if_2
true_if_2:
	displayString 	@_a_es_igual_a_cero
	newLine 1
	jmp	 end_if_2
else_if_2:
	displayString 	@_a_es_distinto_de_cero
	newLine 1
end_if_2:
end_if_1:
	mov ax, @DATA
	mov ds, ax
	mov es, ax
	mov si, OFFSET	@c
	mov di, OFFSET	@Aux3
	call copiar
	mov si, OFFSET	@d
	mov di, OFFSET	@Aux3
	call concat
	mov ax, @DATA
	mov ds, ax
	mov es, ax
	mov si, OFFSET	@Aux3
	mov di, OFFSET	@c
	call copiar
	displayString 	@c
	newLine 1
	displayString 	@_Ingrese_un_valor_para_e
	newLine 1
	getFloat 	@e
	fld 	@_1
	fstp 	@a
	fld 	@_3
	fstp 	@b
	fld 	@_5
	fstp 	@e
if_4:
	fld 	@e
	fld 	@_4
	fsub
	fstp 	@Aux4
cond_if_4_1:
	fld 	@a
	fld 	@Aux4
	fcomp
	fstsw	ax
	fwait
	sahf
	jne		else_if_4
true_if_4:
if_5:
	fld 	@a
	fld 	@_2
	fadd
	fstp 	@Aux5
cond_if_5_1:
	fld 	@b
	fld 	@Aux5
	fcomp
	fstsw	ax
	fwait
	sahf
	jne		else_if_5
true_if_5:
	fld 	@true
	fstp 	@@allequal
	jmp	 end_if_5
else_if_5:
	fld 	@false
	fstp 	@@allequal
end_if_5:
	jmp	 end_if_4
else_if_4:
	fld 	@false
	fstp 	@@allequal
end_if_4:
	fld	@@allequal
	fld	@true
	fcomp
	fstsw	ax
	fwait
	sahf
	jne	else_if_3
true_if_3:
	displayString 	@_TRUE
	newLine 1
	jmp	 end_if_3
else_if_3:
	displayString 	@_FALSE
	newLine 1
end_if_3:
if_6:
cond_if_6_1:
	fld 	@_4
	fld 	@e
	fcomp
	fstsw	ax
	fwait
	sahf
	jae		else_if_6
true_if_6:
	fld 	@e
	fstp 	@@filter
	jmp	 end_if_6
else_if_6:
if_7:
cond_if_7_1:
	fld 	@_4
	fld 	@b
	fcomp
	fstsw	ax
	fwait
	sahf
	jae		else_if_7
true_if_7:
	fld 	@b
	fstp 	@@filter
	jmp	 end_if_7
else_if_7:
	fld 	@null
	fstp 	@@filter
end_if_7:
end_if_6:
	fld 	@@filter
	fstp 	@a
	displayFloat 	@a,3
	newLine 1
	displayString 	@_Fin_del_programa
	newLine 1
	mov ah, 4ch
	int 21h

;FIN DEL PROGRAMA DE USUARIO

strlen proc
	mov bx, 0
	strl01:
	cmp BYTE PTR [si+bx],'$'
	je strend
	inc bx
	jmp strl01
	strend:
	ret
strlen endp

copiar proc
	call strlen
	cmp bx , MAXTEXTSIZE
	jle copiarSizeOk
	mov bx , MAXTEXTSIZE
	copiarSizeOk:
	mov cx , bx
	cld
	rep movsb
	mov al , '$'
	mov byte ptr[di],al
	ret
copiar endp

concat proc
	push ds
	push si
	call strlen
	mov dx , bx
	mov si , di
	push es
	pop ds
	call strlen
	add di, bx
	add bx, dx
	cmp bx , MAXTEXTSIZE
	jg concatSizeMal
	concatSizeOk:
	mov cx , dx
	jmp concatSigo
	concatSizeMal:
	sub bx , MAXTEXTSIZE
	sub dx , bx
	mov cx , dx
	concatSigo:
	push ds
	pop es
	pop si
	pop ds
	cld
	rep movsb
	mov al , '$'
	mov byte ptr[di],al
	ret
concat endp

end