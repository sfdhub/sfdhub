model SMALL
stack 100h
dataseg
MAX db ?
MASS db 1,3,5,7,9,2,15,4,6,8
codeseg
startupcode
    lea BX, MASS    ; Загрузить адрес массива
    mov CX, 10      ; Установить счетчик
    mov AL, [BX]    ; Первый элемент массива в аккумулятор
BEG: cmp [BX], AL   ; Сравнить текущий элемент массива с максимумом
    jl NO           ; он меньше
    mov AL, [BX]    ; он больше
NO: inc BX          ; Следующий элемент массива
    loop BEG        ; Возврат, если счетчик CX не пуст
    
    mov MAX, AL
QUIT: exitcode 0    ;Конец работы
end