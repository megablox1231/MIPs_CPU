LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY instructionMemory IS
	PORT (
	CLK: IN STD_LOGIC;
	MEMR: IN STD_LOGIC;
	PC : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END instructionMemory;
ARCHITECTURE Behavioral OF instructionMemory IS
	TYPE RAM_16_x_32 IS ARRAY(0 TO 15) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL IM : RAM_16_x_32 := (
	"10001101001010000000000000000000",-- lw t0 0x00000000(t1
   	"10101101001010000000000000000000",-- sw t0 0x00000000(t1)
   	"00000001001010100100000000100000",-- add t0 t1 t2
   	"00000001001010100100000000100010",-- sub t0 t1 t2
   	"00000000000010010100000010000000",-- sll t0 t1 0x00000002
   	"00000000000010010100000010000010",-- srl t0 t1 0x00000002
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000",
   	"0000000000000000"
	);
BEGIN
	-- Note: 4194304 = 0x0040 0000
	-- reset when address is 003FFFFC else if readAddress is 0040 0000 then reset also
	instruction <= x"00000000" when PC = x"003FFFFC" else 
		IM(( to_integer(unsigned(PC)) - 4194304) /4);
END Behavioral;