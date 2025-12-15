-- Используемые библиотеки
Library ieee;
use ieee.std_logic_1164.all;
-- Заголовок файла описания op0 объекта АЛУ
-- SAL, SAR, SHL, SHR, ROL, ROR, RCR, RCL
-- SHR1((SAL2(X).0 xor ROR1(Y))).1
entity alu_mux is
generic ( N  : integer:=8
);
port( 
	X0,X1, X2, X3  : in Std_Logic_Vector(N-1 downto 0);
	Sel: in Std_Logic_Vector(1 downto 0);
	OE: in Std_Logic;
		ZY: out Std_Logic_Vector(N-1 downto 0)
		--XL: out Std_Logic_Vector(1 downto 0);
        --YR: out Std_Logic;
	  --CF, OvF: out Std_Logic;
      --ZF: out Std_Logic;
       --SF: out Std_Logic
);
end alu_mux;
-- Архитектура (приватная часть) файла описания объекта АЛУ
Architecture ALU of alu_mux is
-- Область объявления локальных сигналов
constant ConstZ: std_Logic_Vector(7 downto 0):= (others => 'Z');
signal SSS: std_Logic_Vector(2 downto 0);
--,YII,YIII,YIIII: std_Logic_Vector(N-1 downto 0);
BEGIN
-- ROR1(Y)'
SSS <= (OE & Sel);
my_mux: with SSS select
        ZY <= X3 when "111",
         X1 when "101",
         X2 when "110",
         X0 when "100",
         ConstZ when others;
         
END ALU;
