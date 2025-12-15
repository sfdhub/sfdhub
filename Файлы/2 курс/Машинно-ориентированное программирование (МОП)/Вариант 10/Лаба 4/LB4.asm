.model small 
.386 
dataseg 

txt1 db 'Input string',13,10,36 ;1 сообщение для вывода на экран
txt2 db 'Result: '				;2 сообщение для вывода на экран
 
cr db 13,10,36 					;сиволы перевода строки
buf db 80 						;буфер для сохранения введенной строки
len db ? 						;длинна строки
string db 80 dup (?) 			;переменная для хранения обработанной строки
StRS db 80 dup(?)				;модифицированная строка которая будет выводиться при недостоточной длинне исходной строки
need db 20		 				;требуемая длина 
countOFspace db 0				;количество пробелов которое придётся добавить между словами
words_count dw 0				;количество слов в строке

codeseg  
start: 			; beginning of program execution
	startupcode 
	
	mov AX,@data 
	mov DS,AX 
	lea DX,txt1 
	mov es,ax
	mov AH,9 
	int 21h 
	
	;Ввод строки 
	lea DX,buf ;адрес буфера в регистр dx
	inc AH 
	int 21h 
	
	;данный код отвечает за поиск количества слов в строке
		sub     ax,2 ;считаем длину нашей строку без символа возврата каретки и перевода строкаи
        mov     cx,ax ;записываем сколько раз повторить команду rep
		xor     si,si
        xor     ax,ax
		cld
        mov     al,' ' ;символ для сравнивания
		lea     di,string ;указатель на строку для обработки
 
oi:     repne     scasb   ; повторяем для каждого символа
        jne     oi1
        inc     words_count      ; увеличиваем счетчик слов
        jmp     oi          ; прыгаем обратно если не равен
oi1:
        inc words_count    ;рассчитываем на то, что последнее слово без пробела
        xor     ax,ax      ;начинаем вывод на экран результат
        mov     ax,words_count
 
        xor     cx, cx
        mov     bx, 10
oi2:
        xor     dx,dx
        div     bx
        push    dx
        inc     cx
        test    ax, ax
        jnz     oi2
        mov     ah, 02h
oi3: ;дошли до конца
        pop     dx
        add     dl, '0'
        int     21h
        loop    oi3
	;данный код отвечается за поиск количества слов в строке
	mov cl,len
	cmp cl,need 
	
	jb short m1 ;если длина введенной строки меньше требуемой
	;если длиннее 20, то обрезка 
	lea di,string ; в di загрузил строку
	movzx ax,need ;загружает в регистр ax значение переменной need, расширяя его до размера регистра ax.
	add di,ax 	  ;Этот шаг выполняется для того, чтобы di указывал на последний символ строки.
	mov byte ptr [di],'$' ;делаем так чтобы строка занимала столько символов сколько указано добавляя доллар в последний символ
	mov ah,9 
	lea dx,cr 
	int 21h 
	lea dx,txt2 
	int 21h 
	lea dx,string	
	int 21h 
	xor ah,ah 
	int 16h 
	mov ax,4C00h 
	int 21h
	jmp short exit ;метка перехода
	
	;растягивание 
	m1:
	mov countOFspace,20
	sub countOFspace,cl
	mov bl,countOFspace
	sub words_count,-1
	mov AX, words_count
	div bl	
	mov countOFspace,ah
	
	lea si,string
	lea di, StRS
	
	next_char:
	  mov al, [si] ; загружаем текущий символ
	  cmp [si],13 ; если длинна строки равна 20
	  je short H
	  
	  ; проверяем, является ли текущий символ пробелом
	  cmp al, ' ' ; пробел
	  je add_space
	  
	  ; копируем текущий символ в выходную строку
	  mov [di], al
	  
	  ; переходим к следующему символу
	  inc si
	  add di, 1
	  jmp next_char
	  
	add_space:
	  ; копируем пробел в выходную строку
	  mov Ch, countOFspace
	  f:
	  cmp countOFspace,0
	  je short l
	  mov [di], ' '
	  add len,1
	  inc di
	  sub countOFspace,1
	  jmp short f
	  
	  l:
	  mov countOFspace,Ch
	  ; переходим к следующему символу
	  inc si
	  jmp next_char
	
	; выовд
	H:
	mov byte ptr [di],'$' 
	mov ah,9 
	lea dx,cr 
	int 21h 
	lea dx,txt2 
	int 21h 
	lea dx,StRS
	int 21h 
	xor ah,ah 
	int 16h 
	mov ax,4C00h 
	int 21h 
	
	exit: 
	end start
