.386
.model flat, stdcall
option casemap:none

includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO :DWORD
MessageBoxA PROTO :DWORD, :DWORD, :DWORD, :DWORD

.data
    str1 db 'hi', 0
    str2 db 'hii', 0
    msg_more db 'str1 more than str2', 0  
    msg_less db 'str1 less than str2', 0
    msg_equal db 'Strings are equal', 0
    msg_title db 'Comparison Result', 0

.code
WinMain PROC
    mov esi, offset str1     ; Str1 в esi
    mov edi, offset str2     ; Str2 в edi

compare_loop:
    mov al, [esi]            
    mov bl, [edi]            

    ; Сравниваем биты
    cmp al, bl
    jne not_equal

    ; Проверка на конец строки
    cmp al, 0
    je equal

    ; Инкримент индексов
    inc esi
    inc edi
    jmp compare_loop

not_equal:
    ; Если if str1 > str2 или str1 < str2 - конец
    ja str1_more
    jb str1_less

str1_more:
    ; Показываем "more"
    push 0                   
    push offset msg_title    
    push offset msg_more     
    push 0                   
    call MessageBoxA
    jmp exit

str1_less:
    ; Показываем "less"
    push 0                   
    push offset msg_title    
    push offset msg_less     
    push 0                   
    call MessageBoxA
    jmp exit

equal:
    ; Показываем "equal"
    push 0                   
    push offset msg_title    
    push offset msg_equal    
    push 0                   
    call MessageBoxA

exit:
    push 0                  
    call ExitProcess
WinMain endp

end WinMain