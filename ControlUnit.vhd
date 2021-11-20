-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 11/15/2021
-- Project: Homework 5
-- Course: CS 3650

library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is
port(
	instruction: in std_logic_vector(5 downto 0);
	clk: in std_logic;
	reset: in std_logic;
	regDst: out std_logic;
	jump: out std_logic;
	branch: out std_logic;
	memRead: out std_logic;
	memToReg: out std_logic;
	aluOp: out std_logic_vector(2 downto 0);
	memWrite: out std_logic;
	aluSrc: out std_logic;
	regWrite: out std_logic
	
	);
end ControlUnit;

architecture behavioral of ControlUnit is

begin
process(reset, instruction, clk)
begin
	if(rising_edge(clk)) then
	if(reset = '1') then
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "000";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		
	else
	case instruction is
	when "000000" => --R type
		regDst <= '1';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "100";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '1';
		
	when "100011" => --lw from table
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '1';
		memToReg <= '1';
		aluOp <= "010";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';
		
	when "101011" => --sw from table
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		aluOp <= "010";
		memWrite <= '1';
		aluSrc <= '1';
		regWrite <= '0';
		
	when "000100" => --beq from table
		jump <= '0';
		branch <= '1';
		memRead <= '0';
		aluOp <= "001";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		
	when "000010" => --j
		jump <= '1';
		branch <= '0';
		memRead <= '0';
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		
	when "001010" => --slti
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '1';
		aluOp <= "011";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '1';
		
	when "001101" => --ori 
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "101";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';
		
	when "001000" => --addi
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "110";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';

	when "001100" => --andi
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "111";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';
		

	when others =>
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';

end case;
end if;
end if;
end process;

end behavioral;

