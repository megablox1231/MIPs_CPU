-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
entity clock is
generic(delay : time := 200 ns);
port(clk : out std_logic;
reset : in std_logic);
end clock;
----------------------------------------------------------------
architecture behavioral of clock is
begin 
	process
	begin
		
		
		clk <= '0';
		wait for delay;
		if (reset='0') then
			clk <= '1';
			wait for delay;
		end if;
	
		
	end process;
end behavioral;