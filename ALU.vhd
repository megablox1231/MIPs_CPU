-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
generic(delay:time:=1 ns);
port(
 a,b : in std_logic_vector(31 downto 0); -- src1, src2
 shamt : in std_logic_vector(4 downto 0); -- shift amount
 alu_control : in std_logic_vector(2 downto 0); -- function select
 alu_result: out std_logic_vector(31 downto 0); -- ALU Output alu_result
 zero: out std_logic -- Zero Flag
 );
end ALU;
   
architecture Behavioral of ALU is
signal result: std_logic_vector(31 downto 0);
begin

 result <= 	std_logic_vector(signed(a) + signed(b)) when (alu_control="000") -- add
	else	std_logic_vector(signed(a) - signed(b)) when (alu_control="001") -- sub
	else	a and b					when (alu_control="010") -- and
	else	a or b					when (alu_control="011") -- or
	else	a xor b					when (alu_control="110") -- xor
	else	std_logic_vector(signed(b) sll to_integer(unsigned(shamt))) when (alu_control="101") -- sll
	else	std_logic_vector(signed(b) srl to_integer(unsigned(shamt))) when (alu_control="111") -- srl
	else	x"00000001"				when (alu_control="100" and signed(a)<signed(b))
	else	x"00000000"				when (alu_control="100" and signed(a)>=signed(b));

  zero <= '1' after delay when result = x"00000000" else '0' after delay;
  alu_result <= result after delay;

end Behavioral;