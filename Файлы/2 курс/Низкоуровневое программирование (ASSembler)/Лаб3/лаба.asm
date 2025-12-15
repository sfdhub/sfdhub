 .386
.model flat, stdcall
includelib kernel32.lib
ExitProcess PROTO :DWORD

.data
inpdd  dd 4, -13, 3, 0  ; Входные данные
N      dd 4             ; Размер массива
index  dd -1            ; Индекс первого нуля (по умолчанию -1, если ноль не найден)

.code
main PROC
    mov ecx, N             ; Количество элементов в массиве
    lea esi, inpdd         ; Загрузить адрес начала массива в esi
    xor eax, eax           ; Обнулить eax для проверки элемента
    
find_zero:
    cmp [esi], eax         ; Сравнить текущий элемент массива с нулем, который в eax
    je  zero_found         ; Если элемент равен нулю, перейти на метку zero_found
    
    add esi, 4             ; Перейти к следующему элементу массива (4 байта для dd)
    loop find_zero         ; Повторить цикл, пока ecx не станет равен нулю
    
    jmp end_program        ; Переход к завершению программы, если ноль не найден

zero_found:
    sub esi, offset inpdd  ; Вычислить индекс элемента
    shr esi, 2             ; Разделить на 4, чтобы получить индекс в словах (dd)
    mov index, esi         ; Сохранить индекс в переменной index

end_program:
    push 0
    call ExitProcess

main endp

end main
