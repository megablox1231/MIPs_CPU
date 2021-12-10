-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
entity adder is
generic(delay:time:= 1 ns);
port(
input1:in std_logic_vector(31 downto 0);
input2:in std_logic_vector(31 downto 0);
result:out std_logic_vector(31 downto 0)
);
end adder;
----------------------------------------------------------------
architecture behavioral of adder is
begin
	result <=  input1+input2 after delay;
end behavioral;