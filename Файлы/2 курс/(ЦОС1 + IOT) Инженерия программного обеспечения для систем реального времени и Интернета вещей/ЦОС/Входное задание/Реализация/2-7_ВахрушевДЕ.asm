model SMALL
dataseg

str_max_len     db  100
str_len         db  ?
str_str         db  100 dup("$")

out_str         db 100

codeseg
startupcode

mov AX, @DATA
mov ES, AX
mov DS, AX

lea    DX, [str_max_len] 
mov    AH, 0AH 
int    21h 

mov CH, 0
mov CL, str_len
call reverseAndClean PASCAL, offset str_str, CX offset out_str

lea    DX, [out_str] 
mov    AH, 09h 
int    21h 

exitcode 0

reverseAndClean proc PASCAL @@inpStr:word, @@inpStrLen:word, @@outStr:word
uses AX, BX, CX

;find start ptr
mov CX, @@inpStrLen
mov AL, ' '
mov DI, @@inpStr
repe scasb
mov BX, DI ;save start ptr on BX
sub BX, 1

std
mov CX, BX
sub CX, @@inpStr
mov DI, @@inpStr
add DI, @@inpStrLen
dec DI
mov AL, ' '
repe scasb 
inc DI
mov DX, DI

mov CX, DI
sub CX, BX
inc CX
cld
mov DI, @@outStr
mov SI, BX
rep movsb
mov DI, '$'

ret
reverseAndClean endp

end