
Library ieee;
use ieee.std_logic_1164.all;

entity alu_op02 is
port(
	X,Y  : in Std_Logic_Vector(40 downto 0);
	Z1out  : out Std_Logic_Vector(40 downto 0)     
);
end alu_op02;

Architecture ALU of alu_op02 is
  constant const0 :std_Logic_Vector(40 downto 0) := (others => '0');
  
BEGIN

    Z1out <= X and Y;
    
END;