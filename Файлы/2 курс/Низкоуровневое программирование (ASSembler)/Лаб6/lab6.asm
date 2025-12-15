.386
.model flat, stdcall

includelib kernel32.lib
includelib user32.lib

ExitProcess PROTO, :DWORD
MessageBoxA PROTO, :DWORD, :DWORD, :DWORD, :DWORD

.data
    msg_yes db "Yes", 0
    msg_no db "No", 0
    msg_title db "Triangle Check", 0

    segment1 dd 3
    segment2 dd 4
    segment3 dd 5

.code


check_triangle PROC
    ; Если a+b > c, eax = 1 / если < или =, eax = 0
    add eax, ebx        ; a + b
    cmp eax, ecx        ; a+b ? c
    setg al             
    ret
check_triangle ENDP

WinMain PROC

    mov eax, segment1
    mov ebx, segment2
    mov ecx, segment3

    ;segment1 + segment2 > segment3
    call check_triangle
    test eax, eax
    jz not_triangle

    ;segment2 + segment3 > segment1
    mov eax, segment2
    mov ebx, segment3
    mov ecx, segment1
    call check_triangle
    test eax, eax
    jz not_triangle

    ;segment1 + segment3 > segment2
    mov eax, segment1
    mov ebx, segment3
    mov ecx, segment2
    call check_triangle
    test eax, eax
    jz not_triangle

    ;Если все прошли выводим "Yes"
    push 0            
    push offset msg_title 
    push offset msg_yes 
    push 0            
    call MessageBoxA
    jmp end_program

not_triangle:
    ;"No"
    push 0            
    push offset msg_title 
    push offset msg_no 
    push 0            
    call MessageBoxA

end_program:
    push 0            
    call ExitProcess

WinMain ENDP

END WinMain
