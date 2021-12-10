-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shift is
generic(delay:time:= 1 ns);
port(
	input:in std_logic_vector(31 downto 0);
	result:out std_logic_vector(31 downto 0));
end shift;

architecture behavioral of shift is
	signal tmp:std_logic_vector(31 downto 0);
begin
	tmp(0)<='0';
	tmp(1)<='0';
	label1:for i in 0 to 29 generate
		tmp(i+2)<=input(i);
	end generate label1;
	result<=tmp after delay;
end behavioral;