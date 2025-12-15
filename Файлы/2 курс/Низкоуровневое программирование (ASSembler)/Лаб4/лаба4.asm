.386
.model flat, stdcall
includelib kernel32.lib
ExitProcess PROTO, : DWORD

.data
numbers dd 0, 13, 255, -1, -4  ; массив целых чисел
res db 5 dup (0)               ; массив для хранения количества установленных битов в каждом элементе numbers
s = 5                          ; количество элементов в массиве numbers

.code
Winmain PROC
    lea ebx, numbers  ; загружаем адрес массива numbers в регистр ebx
    lea edi, res      ; загружаем адрес массива res в регистр edi
    mov ecx, s        ; загружаем количество элементов в массиве numbers в регистр ecx

cycle:
    mov eax, [ebx]    ; загружаем очередное число из массива numbers в регистр eax
    mov edx, eax      ; сохраняем это число в регистр edx для обработки
    xor eax, eax      ; сбрасываем eax, чтобы использовать его для подсчета битов

count_bits:
    test edx, 1       ; проверяем младший бит числа в edx
    jz no_bit_set     ; если бит не установлен (0), переходим к метке no_bit_set
    inc eax           ; если бит установлен (1), увеличиваем счетчик установленных битов

no_bit_set:
    shr edx, 1        ; сдвигаем edx на 1 бит вправо
    jnz count_bits    ; если edx не равен 0, повторяем подсчет битов

    ; сохраняем количество установленных битов в текущую ячейку массива res
    mov [edi], al
    add ebx, 4        ; переходим к следующему элементу в массиве numbers
    inc edi           ; переходим к следующей ячейке в массиве res
    loop cycle        ; уменьшаем ecx на 1 и, если ecx не равен 0, повторяем цикл

    ; завершение программы
    push 0
    call ExitProcess
Winmain endp

end Winmain
