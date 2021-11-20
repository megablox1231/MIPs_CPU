-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 11/15/2021
-- Project: Homework 5
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb is
end tb;

architecture behavior of tb is

signal clk : std_logic := '0';
signal reset: std_logic := '0';
signal instruction: std_logic_vector(5 downto 0);
signal regDst: std_logic  := '1';
signal jump: std_logic  := '0';
signal branch: std_logic  := '0';
signal memRead: std_logic  := '0';
signal memToReg: std_logic  := '0';
signal aluOp: std_logic_vector(2 downto 0);
signal memWrite : std_logic := '0';
signal aluSrc: std_logic  := '0';
signal regWrite: std_logic  := '1';

constant clk_period : time := 100 ps;

begin

dut : entity work.ControlUnit port map (
		clk => clk,
		reset => reset,
		instruction => instruction ,
		regDst => regDst,
		jump => jump,
		branch => branch,
		memRead => memRead,
		memToReg => memToReg,
		aluOp => aluOp,
		memWrite => memWrite,
		aluSrc => aluSrc,
		regWrite => regWrite
		);
	-- clock process
	clk <= not clk after clk_period;

	-- Stimulus process
	stim_proc : 
	process 

	begin
	--reset <= '1';
	wait for 100 ps;
	reset <= '0';
	--j
	instruction<="000010";
	wait for 200 ps;
 	--r type
	instruction<="000000";
	wait for 200 ps;
	reset <= '1';
	wait for 200 ps;
	--ori with reset
	instruction<="001101";
	wait for 200 ps;
	reset <= '0';
	wait for 200 ps;
	 --slti
	instruction<="001010";
	wait for 200 ps;
	--andi
	instruction<="001100";
	wait for 200 ps;
	--ori
	instruction<="001101";
	wait for 200 ps;
	--addi
	instruction<="001000";
	wait for 200 ps;
	--beq
	instruction<="000100";
	wait for 100 ps;
	
	end process stim_proc;
end;
