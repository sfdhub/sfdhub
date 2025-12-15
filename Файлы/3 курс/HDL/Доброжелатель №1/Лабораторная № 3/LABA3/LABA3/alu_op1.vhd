-- Используемые библиотеки
Library ieee;
use ieee.std_logic_1164.all;
-- Заголовок файла описания op0 объекта АЛУ
-- SAL, SAR, SHL, SHR, ROL, ROR, RCR, RCL
-- SHR1((SAL2(X).0 xor ROR1(Y))).1
entity alu_op1 is
port( 
	X, Y  : in Std_Logic_Vector(7 downto 0);
	--Y: in Std_Logic_Vector(7 downto 0);
		Z1: out Std_Logic_Vector(7 downto 0);
		--XL: out Std_Logic_Vector(1 downto 0);
        --YR: out Std_Logic;
	  --CF, OvF: out Std_Logic;
      ZF: out Std_Logic;
        SF: out Std_Logic
);
end alu_op1;
-- Архитектура (приватная часть) файла описания объекта АЛУ
Architecture ALU of alu_op1 is
-- Область объявления локальных сигналов
--signal Pin: std_Logic_Vector(8 downto 0);
signal YI: std_Logic_Vector(7 downto 0);
--,YII,YIII,YIIII: std_Logic_Vector(7 downto 0);
BEGIN
-- ROR1(Y)
YI(7 downto 0) <= Y(7 downto 0) or not (X(7 downto 0));
Z1 <= YI;
SF <= YI(7);
ZF <= '1' when YI(7 downto 0) = "00000000" else '0';
END ALU;
