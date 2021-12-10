-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library IEEE;
use IEEE.std_logic_1164.all;

USE IEEE.NUMERIC_STD.ALL;

Entity data_Memory IS
  PORT(
    clk: IN STD_LOGIC;
    memWrite, memRead: IN STD_LOGIC;
    addr : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    mem_write_data: in STD_LOGIC_VECTOR (31 downto 0);
    mem_read_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
end data_Memory;

architecture Behavioral of data_Memory is
  
  type mem_array is array (51 downto 0) of std_logic_vector(7 downto 0);
  signal data_mem : mem_array:= (others=>(others=>'0')) ;
      
begin
 writeMem : process(clk, addr, memWrite, mem_write_data)
            begin
                if rising_edge(clk) and memWrite = '1' then
                    case addr(7 downto 0) is
                        when X"00" =>
                            data_mem(0) <= mem_write_data(31 downto 24);
                            data_mem(1) <= mem_write_data(23 downto 16);
                            data_mem(2) <= mem_write_data(15 downto 8);
                            data_mem(3) <= mem_write_data(7 downto 0);

			when X"04" =>
                            data_mem(4) <= mem_write_data(31 downto 24);
                            data_mem(5) <= mem_write_data(23 downto 16);
                            data_mem(6) <= mem_write_data(15 downto 8);
                            data_mem(7) <= mem_write_data(7 downto 0);
                        when X"08" =>
                            data_mem(8) <= mem_write_data(31 downto 24);
                            data_mem(9) <= mem_write_data(23 downto 16);
                            data_mem(10) <= mem_write_data(15 downto 8);
                            data_mem(11) <= mem_write_data(7 downto 0);

			when X"0C" =>
                            data_mem(12) <= mem_write_data(31 downto 24);
                            data_mem(13) <= mem_write_data(23 downto 16);
                            data_mem(14) <= mem_write_data(15 downto 8);
                            data_mem(15) <= mem_write_data(7 downto 0);
                        when X"10" =>
                            data_mem(16) <= mem_write_data(31 downto 24);
                            data_mem(17) <= mem_write_data(23 downto 16);
                            data_mem(18) <= mem_write_data(15 downto 8);
                            data_mem(19) <= mem_write_data(7 downto 0);

			when X"14" =>
                            data_mem(20) <= mem_write_data(31 downto 24);
                            data_mem(21) <= mem_write_data(23 downto 16);
                            data_mem(22) <= mem_write_data(15 downto 8);
                            data_mem(23) <= mem_write_data(7 downto 0);
                        when X"18" =>
                            data_mem(24) <= mem_write_data(31 downto 24);
                            data_mem(25) <= mem_write_data(23 downto 16);
                            data_mem(26) <= mem_write_data(15 downto 8);
                            data_mem(27) <= mem_write_data(7 downto 0);

			when X"1C" =>
                            data_mem(28) <= mem_write_data(31 downto 24);
                            data_mem(29) <= mem_write_data(23 downto 16);
                            data_mem(30) <= mem_write_data(15 downto 8);
                            data_mem(31) <= mem_write_data(7 downto 0);
                        when X"20" =>
                            data_mem(32) <= mem_write_data(31 downto 24);
                            data_mem(33) <= mem_write_data(23 downto 16);
                            data_mem(34) <= mem_write_data(15 downto 8);
                            data_mem(35) <= mem_write_data(7 downto 0);

			when X"24" =>
                            data_mem(36) <= mem_write_data(31 downto 24);
                            data_mem(37) <= mem_write_data(23 downto 16);
                            data_mem(38) <= mem_write_data(15 downto 8);
                            data_mem(39) <= mem_write_data(7 downto 0);
                        when X"28" =>
                            data_mem(40) <= mem_write_data(31 downto 24);
                            data_mem(41) <= mem_write_data(23 downto 16);
                            data_mem(42) <= mem_write_data(15 downto 8);
                            data_mem(43) <= mem_write_data(7 downto 0);

			when X"2C" =>
                            data_mem(44) <= mem_write_data(31 downto 24);
                            data_mem(45) <= mem_write_data(23 downto 16);
                            data_mem(46) <= mem_write_data(15 downto 8);
                            data_mem(47) <= mem_write_data(7 downto 0);
                        when X"30" =>
                            data_mem(48) <= mem_write_data(31 downto 24);
                            data_mem(49) <= mem_write_data(23 downto 16);
                            data_mem(50) <= mem_write_data(15 downto 8);
                            data_mem(51) <= mem_write_data(7 downto 0);

                        when others => null;
end case;
end if;
end process;

 readMem : process(CLK, addr, memRead)
            begin
                if memRead = '1' then
                    case addr(7 downto 0) is
                        when X"00" =>
                         mem_read_data <= data_mem(0) & data_mem(1) & data_mem(2) & data_mem(3);

                        when X"04" =>
			 mem_read_data	<= data_mem(4) & data_mem(5) & data_mem(6) & data_mem(7);

                        when X"08" =>
                         mem_read_data <= data_mem(8) & data_mem(9) & data_mem(10) & data_mem(11);

                        when X"0C" =>
			 mem_read_data	<= data_mem(12) & data_mem(13) & data_mem(14) & data_mem(15);

                        when X"10" =>
			 mem_read_data	<= data_mem(16) & data_mem(17) & data_mem(18) & data_mem(19);

                        when X"14" =>
                         mem_read_data <= data_mem(20) & data_mem(21) & data_mem(22) & data_mem(23);

                        when X"18" =>
			 mem_read_data	<= data_mem(24) & data_mem(25) & data_mem(26) & data_mem(27);

                        when X"1C" =>
			 mem_read_data	<= data_mem(28) & data_mem(29) & data_mem(30) & data_mem(31);

                        when X"20" =>
                         mem_read_data <= data_mem(32) & data_mem(33) & data_mem(34) & data_mem(35);

                        when X"24" =>
			 mem_read_data	<= data_mem(36) & data_mem(37) & data_mem(38) & data_mem(39);

                        when X"28" =>
			 mem_read_data	<= data_mem(40) & data_mem(41) & data_mem(42) & data_mem(43);

                        when X"2C" =>
                         mem_read_data <= data_mem(44) & data_mem(45) & data_mem(46) & data_mem(47);

                        when X"30" =>
			 mem_read_data	<= data_mem(48) & data_mem(49) & data_mem(50) & data_mem(51);
                         
			when others => null;
end case;
end if;
end process;


  end architecture Behavioral;   