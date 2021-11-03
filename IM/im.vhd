LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY instructionMemory IS
	PORT (
	CLK: IN STD_LOGIC;
	MEMR: IN STD_LOGIC;
	ADDR : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	DOUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END instructionMemory;
ARCHITECTURE Behavioral OF instructionMemory IS
	VARIABLE index : integer := 0;
	TYPE RAM_16_x_8 IS ARRAY(0 TO 31) OF std_logic_vector(7 DOWNTO 0);
	SIGNAL IM : RAM_32_x_8 := (
	"10001101","00101000","00000000","00000000",-- lw t0 0x00000000(t1)
   	"10101101","00101000","00000000","00000000",-- sw t0 0x00000000(t1)
   	"00000001","00101010","01000000","00100000",-- add t0 t1 t2
   	"00000001","00101010","01000000","00100010",-- sub t0 t1 t2
   	"00000000","00001001","01000000","10000000",-- sll t0 t1 0x00000002
   	"00000000","00001001","01000000","10000010",-- srl t0 t1 0x00000002
   	"00000000","00000000","00000000","00000000",
   	"00000000","00000000","00000000","00000000"
	);
BEGIN
PROCESS(clk)
	IF rising_edge(clk) AND MEMR='1' THEN
		FOR i in DOUT'range LOOP
			IF ( i = 24)
  				DOUT(i) <= IM( to_integer(unsigned(ADDR)));
			ELSE IF ( i = 16) 
				DOUT(i) <= IM( to_integer(unsigned(ADDR + 1)));
			ELSE IF ( i = 8) 
				DOUT(i) <= IM( to_integer(unsigned(ADDR + 2)));
			ELSE IF ( i = 0) 
				DOUT(i) <= IM( to_integer(unsigned(ADDR + 3)));
			END IF;
		END LOOP;
END PROCESS;

END Behavioral;
