-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 10/17/2021
-- Project: Homework 3
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behavior of tb is

signal ir : std_logic_vector(31 downto 0);
signal pc: std_logic_vector(31 downto 0) := (OTHERS => '0');
-- Inputs

signal clk : std_logic := '0';
signal memr : std_logic := '0';
signal addr : std_logic_vector(31 downto 0);


-- Outputs
signal dout : std_logic_vector(7 downto 0);


-- Clock period definiton
constant clk_period : time := 100 ps;

begin

	-- Instantiate the Unit Under Test (UUT)
	dut : entity work.instructionMemory port map (
		clk => clk,
		memr => memr,
		addr => addr,
		dout => dout
		);

	-- Clock process
	clk <= not clk after clk_period;

	-- Stimulus process
	stim_proc : 
	process 
	variable j : integer := 31;
	variable i : integer := 0;
	begin
	
	memr <= '1';
	

	for i in 0 to 5 loop
		while j > 0 loop
			addr <= pc;
			wait for 150 ps;
			ir(j downto j-7) <= dout;
			pc <= pc + 1;
			wait for 50 ps;
			j := j - 8;
		end loop;
		j := 31;
	--ir(31 downto 0) <= (OTHERS => '0');
	end loop;

	end process stim_proc;
end;














