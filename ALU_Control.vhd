-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
generic(delay:time:= 1 ns);
port(
  ALU_Control: out std_logic_vector(2 downto 0);
  ALUOp : in std_logic_vector(2 downto 0);
  ALU_Funct : in std_logic_vector(5 downto 0)
);
end ALUControl;

architecture Behavioral of ALUControl is
begin
	ALU_Control<= 	"000" after delay when (ALUOP="010")--lw/sw
	else		"001" after delay when (ALUOP="001")--beq
	else		"100" after delay when (ALUOP="011")--slti
	else		"011" after delay when (ALUOP="101")--ori
	else		"000" after delay when (ALUOP="110")--addi
	else		"010" after delay when (ALUOP="111")--andi
	else		"000" after delay when (ALUOP="100" and ALU_Funct="100000")--add
	else		"001" after delay when (ALUOP="100" and ALU_Funct="100010")--sub
	else		"010" after delay when (ALUOP="100" and ALU_Funct="100100")--and
	else		"011" after delay when (ALUOP="100" and ALU_Funct="100101")--or
	else		"110" after delay when (ALUOP="100" and ALU_Funct="100110")--xor
	else		"101" after delay when (ALUOP="100" and ALU_Funct="000000")--sll
	else		"111" after delay when (ALUOP="100" and ALU_Funct="000010")--srl
	else		"100" after delay when (ALUOP="100" and ALU_Funct="101010");--slt
end Behavioral;