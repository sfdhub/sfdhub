-- Используемые библиотеки
Library ieee;
use ieee.std_logic_1164.all;
-- Заголовок файла описания op0 объекта АЛУ
-- SAL, SAR, SHL, SHR, ROL, ROR, RCR, RCL
-- SHR1((SAL2(X).0 xor ROR1(Y))).1
entity alu_op0 is
port( 
	X, Y  : in Std_Logic_Vector(7 downto 0);
	--Y: in Std_Logic_Vector(7 downto 0);
		Z0,QYI,QYII,QYIII: out Std_Logic_Vector(7 downto 0);
		XL: out Std_Logic_Vector(1 downto 0);
        YR: out Std_Logic;
	  --CF, OvF: out Std_Logic;
      ZF: out Std_Logic;
        SF: out Std_Logic
);
end alu_op0;
-- Архитектура (приватная часть) файла описания объекта АЛУ
Architecture ALU of alu_op0 is
-- Область объявления локальных сигналов
--signal Pin: std_Logic_Vector(8 downto 0);
signal YI,YII,YIII,YIIII: std_Logic_Vector(7 downto 0);
BEGIN
-- ROR1(Y)
YI(7 downto 0) <= Y(0)&Y(7 downto 1);
-- SAL2(X).0
YII(7 downto 0) <= X(7)& X(4 downto 0) & "00";
XL(1 downto 0) <= X(6 downto 5);
-- (SAL2(X).0 xor ROR1(Y))
YIII(7 downto 0) <= YI(7 downto 0) xor YII(7 downto 0);
-- SHR1((SAL2(X).0 xor ROR1(Y))).1
YIIII(7 downto 0) <= '1'& YIII(7 downto 1);
YR <= YIII(0);
Z0(7 downto 0) <= YIIII(7 downto 0);
SF <= YIIII(7);
ZF <= '1' when YIIII(7 downto 0) = "00000000" else '0';
QYI<=YI;
QYII<=YII;
QYIII<=YIII;

END ALU;
