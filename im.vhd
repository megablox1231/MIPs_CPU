
-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;

ENTITY instructionMemory IS
generic(delay : time := 1 ns);
	PORT (
	clk: IN STD_LOGIC;
	memr: IN STD_LOGIC;
	addr : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	
	);
END instructionMemory;

ARCHITECTURE Behavioral OF instructionMemory IS
--signal tempAddr: std_logic_vector(31 downto 0);
--signal dout: std_logic_vector(7 downto 0);


	TYPE RAM_12_x_32 IS ARRAY(0 TO 12) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL IM : RAM_12_x_32 := (
   	"00100001010010100000000000000100",-- addi $t2, $t2, 2
	"10001101001010000000000000000000",-- lw t0 0x00000000(t1)
   	"10101101001010000000000000000000",-- sw t0 0x00000000(t1)
   	"00000001001010100100000000100000",-- add t0 t1 t2
   	"00000001001010100100000000100010",-- sub t0 t1 t2
   	"00000000000010010100000010000000",-- sll t0 t1 0x00000002
   	"00000000000010010100000010000010",-- srl t0 t1 0x00000002
   	"00000000000000000000000000000000",
   	"00000000000000000000000000000000",
   	"00000000000000000000000000000000",
   	"00000000000000000000000000000000",
   	"00000000000000000000000000000000",
   	"00000000000000000000000000000000"
	);
BEGIN
PROCESS(clk)

BEGIN

	IF (rising_edge(clk) and memr = '1') THEN
  		instruction <= im(to_integer(unsigned(addr)));
	end if;

END PROCESS;
END Behavioral;

