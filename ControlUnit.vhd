-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library IEEE;
use IEEE.std_logic_1164.all;

entity ControlUnit is
generic(delay :time:=1 ns);
port(
	opCode: in std_logic_vector(5 downto 0);
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
	signal temp : std_logic_vector(10 downto 0);

begin
	temp <= "01001000100" when (opCode="000000")--R format		
	else    "00111100010" when (opCode="100011")--lw		
	else    "00100010010" when (opCode="101011")--sw		
	else    "00000001001" when (opCode="000100")--beq		
	else    "00000001000" when (opCode="000101")--bne
	else    "10000000000" when (opCode="000010")--j				
	else    "00011000011" when (opCode="001010")--slti			
	else    "00101000101" when (opCode="001101")--ori
	else    "00101000110" when (opCode="001000")--addi	
	else    "00101000111" when (opCode="001100");--andi				
	
	
	jump		<= temp(10) after delay;
	regDst		<= temp(9) after delay;
	alusrc		<= temp(8) after delay;
	memtoreg	<= temp(7) after delay;
	regwrite	<= temp(6) after delay;
	memread		<= temp(5) after delay;
	memwrite	<= temp(4) after delay;
	branch		<= temp(3) after delay;
	aluop		<= temp(2 downto 0) after delay;

		



end behavioral;
