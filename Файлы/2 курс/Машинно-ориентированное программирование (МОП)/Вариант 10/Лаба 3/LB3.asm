model SMALL
stack 100h

dataseg
dates dw 221h, 221h, 221h, 221h, 221h, 261h, 261h, 261h, 261h, 0FFFFh
maxMonth dw 0
maxMonthIndex dw 0

codeseg
startupcode
    mov cx, 10 ; количество элементов в массиве
    mov bx, offset dates ; начальный адрес массива
    mov ax, [bx] ; первый элемент массива
    shr ax, 5 ; сдвигаем 5 вправо
    and ax, 0Fh ; извлекаем месяц
    mov maxMonth, ax ; устанавливаем первый месяц как максимальный
    mov maxMonthIndex, 0 ; индекс максимального месяца

nextDate:
    add bx, 2 ; переходим к следующему элементу массива
    dec cx ; уменьшаем счетчик
    jz end ; если обработали все элементы, переходим к концу

    mov ax, [bx] ; текущий элемент массива
    shr ax, 5 ; сдвигаем 5 вправо
    and ax, 0Fh ; извлекаем месяц
    cmp ax, maxMonth ; сравниваем с максимальным месяцем
    jle nextDate ; если меньше или равно, переходим к следующему элементу

    mov maxMonth, ax ; обновляем максимальный месяц
    mov maxMonthIndex, cx ; обновляем индекс максимального месяца
    jmp nextDate ; переходим к следующему элементу
    end:
QUIT: exitcode 0    ;Конец работы
end

