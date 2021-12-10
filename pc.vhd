
-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pc is
generic(width:integer:=32);
port(
input:in std_logic_vector(width-1 downto 0);
result:out std_logic_vector(width-1 downto 0);
clock:in std_logic;
reset:in std_logic
);
end pc;
architecture pc_arch of pc is
begin
	process(clock,reset)
	begin 
		if(reset='1') then
			if(width=32) then
				result <= x"00000000";
			end if;
			if(width=64) then
				result <= x"0000000000000000";
			end if;
			if(width=149) then
				result <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			end if;
			if(width=107) then
				result <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			end if;
			if(width=71) then
				result <= "00000000000000000000000000000000000000000000000000000000000000000000000";
		end if;
		else
			if(clock'event and clock = '1') then
				result <= input;
			end if;
		end if;
	end process;
end pc_arch;