model SMALL
stack 100h
dataseg 
	Ask1 db 0Ah,0Dh,'Enter the first term (less 11 digits):$' 
	Ask2 db 0Ah,0Dh,'Enter the second term (less 11 digits):$'
	
	Buf1 db 11 
	Len1 db ? 
	Opnd1 db 12 dup( ? ) 
	Buf2 db 11 
	Len2 db ? 
	Opnd2 db 12 dup( ? )  
	ResT db 0Ah,0Dh,'Result:$' 	
	Res db 11 dup(' '),'$' 
	DesT db 0Ah,0Dh,'Result:-$' 	
	Des db 11 dup(' '),'$' 
	AskCont db 0Ah,0Dh 
	flag dw 0
	Db 'End program - Esc, continue - any key' 
	db '$' 

codeseg 
start:
	startupcode 
	push DS 
	pop ES ; ES <- DS 
BEGIN: 
	;Ввод первого слагаемого
	mov flag, 0
In1:
	lea DX, Ask1 
	mov AH, 09h 
	int 21h 
	lea DX, Buf1 
	mov AH, 0Ah 
	int 21h 
	cmp Len1, 0 
	je In1 
	;проверка 0?9 и очистка старшей тетрады
	lea BX, Opnd1 
	xor CX, CX 
	mov CL, Len1 
	xor SI, SI 
validate1: 
	mov AL, [BX][SI] 
	cmp AL, '0' 
	jb In1 ; ошибка
	cmp AL, '9' 
	ja In1 ; ошибка
	and AL, 0Fh 
	mov [BX][SI], AL 
	inc SI 
	loop validate1 
	;прижать к правому краю
	mov CL, Len1 
	cmp CL, 10 
	je toIn2 
	mov DI, 9 
	mov SI, CX 
	dec SI 
emtys1: ; работа с оставшимися пустыми разрядами
	mov AL, [BX][SI] 
	mov [BX][DI], AL 
	dec DI 
	dec SI 
	loop emtys1 
	;обнулить лишнее
	xor DI, DI 
	mov CL, 10 
	sub CL, Len1 
tozero1: ; обнуление лишних разрядов
	mov byte ptr [BX][DI], 0 
	inc DI 
	loop tozero1 
toIn2: 
	;Ввод второго слагаемого
In2: 
	lea DX, Ask2 
	mov AH, 09h 
	int 21h 
	lea DX, Buf2 
	mov AH, 0Ah 
	int 21h 
	cmp Len2, 0 
	je In2 
	;проверка 0?9 и очистка старшей тетрады
	lea BX, Opnd2 
	xor CX, CX 
	mov CL, Len2 
	xor SI, SI 
validate2: ; начало проверки
	mov AL, [BX][SI] 
	cmp AL, '0' 
	jb In2 ; ошибка
	cmp AL, '9' 
	ja In2 ; ошибка
	and AL, 0Fh 
	mov [BX][SI], AL 
	inc SI 
	loop validate2 
	;прижать к правому краю
	mov CL, Len2 
	cmp CL, 10 
	je minused 
	mov DI, 9 
	mov SI, CX 
	dec SI 
emtys2: ; работа с оставшимися пустыми разрядами
	mov AL, [BX][SI] 
	mov [BX][DI], AL 
	dec DI 
	dec SI 
	loop emtys2 
	;обнулить лишнее
	xor DI, DI 
	mov CL, 10 
	sub CL, Len2 
tozero2: 
	mov byte ptr [BX][DI], 0 
	inc DI 
	loop tozero2 
minused: 
	;Вычитание
	mov CX, 10 
	clc 
	lea SI, Opnd1+9 
	lea DI, Opnd2+9 
	lea BX, Res+9 
startCalc: ; начало вычитания чисел
	mov AL, [SI] 
	sbb AL, [DI] 
	aas 
	mov [BX], AL 
	dec SI 
	dec DI 
	dec BX 
	loop startCalc 
	mov AL, 0 
	adc AL, 0 
	mov [BX], AL 
	xor AX,AX
	mov AX,0
	cmp [BX],0
	je iszero
	jne isnotzero
isnotzero: 
	;Вычитание
	mov flag, 1
	mov CX, 10 
	clc 
	lea DI, Opnd1+9 
	lea SI, Opnd2+9 
	lea BX, Des+9  
	mov AL, [SI] 
	sbb AL, [DI] 
	aas 
	mov [BX], AL 
	dec SI 
	dec DI 
	dec BX 
	loop startCalc 
	mov AL, 0 
	adc AL, 0
	mov [BX], AL 
iszero:
	;Преобразование результата в ASCII
	mov CX, 11 
toASCII: 
	or byte ptr [BX], 30h 
	inc BX 
	loop toASCII ; Возвращение в начало цикла (toASCII), пока CX не равен нулю
	;Вывод результата
	cmp flag,0
	jne withMinus
	lea DX, ResT
	mov AH, 09h 
	int 21h
	jmp continueProgram
withMinus: 
	lea DX, DesT
	mov AH, 09h 
	int 21h
continueProgram:
	;Запрос на продолжение работы
	lea DX, AskCont 
	mov AH, 09h 
	int 21h 
	mov AH, 08h 
	int 21h 
	cmp AL, 27 ;ESC 
	je QUIT 
	jmp BEGIN 
	;Конец работы
QUIT: 
exitcode 0 
end
