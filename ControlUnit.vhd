-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 11/15/2021
-- Project: Homework 5
-- Course: CS 3650

library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is
port(
	instruction: in std_logic_vector(31 downto 26);
	clk: in std_logic;
	reset: in std_logic;
	regDst: out std_logic;
	jump: out std_logic;
	branch: out std_logic;
	memRead: out std_logic;
	memToReg: out std_logic;
	aluOp: out std_logic_vector(1 downto 0);
	memWrite: out std_logic;
	aluSrc: out std_logic;
	regWrite: out std_logic;
	signExtend: out std_logic
	);
end ControlUnit;

architecture behavioral of ControlUnit is

begin
process(reset, instruction)
begin
	
	if(reset = '1') then
		regDst <= "00";
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= "00";
		aluOp <= "00";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		signExtend <= '1';
	else
	case instruction is
	when "000000" => --R type
		regDst <= '1';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "10";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '1';
		signExtend <= '1';
	when "001010" => --sliu
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '1';
		aluOp <= "10";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '1';
		signExtend <= '1';
	when "000010" => --j
		--regDst <= "00";
		jump <= '1';
		branch <= '0';
		memRead <= '0';
		--memToReg <= "10";
		aluOp <= "11";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		signExtend <= '1';
	when "000011" => --jal
		--regDst <= '1'; -- not sure
		jump <= '1';
		branch <= '0';
		memRead <= '0';
		--memToReg <= "10";
		--aluOp <= "00";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '1';
		signExtend <= '1';
	when "100011" => --lw from table
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '1';
		memToReg <= '1';
		aluOp <= "00";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
	when "101011" => --sw from table
		--regDst <= "00";
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		--memToReg <= "00";
		aluOp <= "00";
		memWrite <= '1';
		aluSrc <= '1';
		regWrite <= '0';
		signExtend <= '1';
	when "000100" => --beq from table
		--regDst <= "00";
		jump <= '0';
		branch <= '1';
		memRead <= '0';
		--memToReg <= "00";
		aluOp <= "01";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		signExtend <= '1';
	when "001000" => --addi from mipsconverter.com
		regDst <= '0';
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		memToReg <= '0';
		aluOp <= "00";
		memWrite <= '0';
		aluSrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
	when others =>
		--regDst <= "01";
		jump <= '0';
		branch <= '0';
		memRead <= '0';
		--memToReg <= "00";
		--aluOp <= "00";
		memWrite <= '0';
		aluSrc <= '0';
		regWrite <= '0';
		signExtend <= '1';
end case;
end if;
end process;

end behavioral;








