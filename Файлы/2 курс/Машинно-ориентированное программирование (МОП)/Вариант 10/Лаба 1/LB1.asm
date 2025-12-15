model SMALL
stack 100h
	dataseg
A dw 1
B dw 2
C dw 3
X dw ?
	codeseg
	startupcode
	MOV AX, A
	SUB AX, B
	MOV BX, 5
	MUL BX
	MOV CX, C
	SHR CX, 1
	ADD AX, CX
	INC AX
	MOV X, AX
;Конец работы
QUIT: exitcode 0
end

