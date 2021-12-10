
-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Register_File is
    port(
        signal regWrite, clk : in std_logic;
        signal reg_write_dest, reg_read_addr_1, reg_read_addr_2 : in std_logic_vector(4 downto 0);
        signal write_data : in std_logic_vector(31 downto 0);
        signal read_data1, read_data2: out std_logic_vector(31 downto 0)
	    );
end entity Register_File;


architecture behavior of Register_File is
    type registerFile is array(31 downto 0) of std_logic_vector(31 downto 0);
    signal r : registerFile:= (others=>(others=>'0'));

    begin

        writeReg : process(clk, reg_write_dest, regWrite)
            begin
                if rising_edge(clk) and regWrite = '1' then
                    case reg_write_dest is
			                 -- we cannot write to r(0)=$zero
                        when "00001" =>
                            r(1) <= write_data;
                        when "00010" =>
                            r(2) <= write_data;
                        when "00011" =>
                            r(3) <= write_data;
                        when "00100" =>
                            r(4) <= write_data;
                        when "00101" =>
                            r(5) <= write_data;
                        when "00110" =>
                            r(6) <= write_data;
                        when "00111" =>
                            r(7) <= write_data;
                        when "01000" =>
                            r(8) <= write_data;
                        when "01001" =>
                            r(9) <= write_data;
                        when "01010" =>
                            r(10) <= write_data;
                        when "01011" =>
                            r(11) <= write_data;
                        when "01100" =>
                            r(12) <= write_data;
                        when "01101" =>
                            r(13) <= write_data;
                        when "01110" =>
                            r(14) <= write_data;
                        when "01111" =>
                            r(15) <= write_data;
                        when "10000" =>
                            r(16) <= write_data;
                        when "10001" =>
                            r(17) <= write_data;
                        when "10010" =>
                            r(18) <= write_data;
                        when "10011" =>
                            r(19) <= write_data;
                        when "10100" =>
                            r(20) <= write_data;
                        when "10101" =>
                            r(21) <= write_data;
                        when "10110" =>
                            r(22) <= write_data;
                        when "10111" =>
                            r(23) <= write_data;
                        when "11000" =>
                            r(24) <= write_data;
                        when "11001" =>
                            r(25) <= write_data;
                        when "11010" =>
                            r(26) <= write_data;
			                  -- we cannot write to r(27)=$k1,r(28)=$gp ,r(29)=$sp
                        when "11110" =>
                            r(30) <= write_data;
			                  -- return address register
                        when "11111" =>
                            r(31) <= write_data;
                        when others => null;
                    end case;
                    --r(27) <= k1;
                   -- r(28) <= gp;
                end if;
        end process;

        readReg1 : process(clk, reg_read_addr_1)
            begin
                case reg_read_addr_1 is
                    when "00000" =>
                        read_data1 <= r(0);
                    when "00001" =>
                        read_data1 <= r(1);
                    when "00010" =>
                        read_data1 <= r(2);
                    when "00011" =>
                        read_data1 <= r(3);
                    when "00100" =>
                        read_data1 <= r(4);
                    when "00101" =>
                        read_data1 <= r(5);
                    when "00110" =>
                        read_data1 <= r(6);
                    when "00111" =>
                        read_data1 <= r(7);
                    when "01000" =>
                        read_data1 <= r(8);
                    when "01001" =>
                        read_data1 <= r(9);
                    when "01010" =>
                        read_data1 <= r(10);
                    when "01011" =>
                        read_data1 <= r(11);
                    when "01100" =>
                        read_data1 <= r(12);
                    when "01101" =>
                        read_data1 <= r(13);
                    when "01110" =>
                        read_data1 <= r(14);
                    when "01111" =>
                        read_data1 <= r(15);
                    when "10000" =>
                        read_data1 <= r(16);
                    when "10001" =>
                        read_data1 <= r(17);
                    when "10010" =>
                        read_data1 <= r(18);
                    when "10011" =>
                        read_data1 <= r(19);
                    when "10100" =>
                        read_data1 <= r(20);
                    when "10101" =>
                        read_data1 <= r(21);
                    when "10110" =>
                        read_data1 <= r(22);
                    when "10111" =>
                        read_data1 <= r(23);
                    when "11000" =>
                        read_data1 <= r(24);
                    when "11001" =>
                        read_data1 <= r(25);
                    when "11010" =>
                        read_data1 <= r(26);
                    when "11011" =>
                        read_data1 <= r(27);
                    when "11100" =>
                        read_data1 <= r(28);
                    when "11101" =>
                        read_data1 <= r(29);
                    when "11110" =>
                        read_data1 <= r(30);
                    when "11111" =>
                        read_data1 <= r(31);
                    when others => null;
                end case;
        end process;

        readReg2 : process(clk, reg_read_addr_2 )
            begin
                case reg_read_addr_2  is
                    when "00000" =>
                        read_data2 <= r(0);
                    when "00001" =>
                        read_data2 <= r(1);
                    when "00010" =>
                        read_data2 <= r(2);
                    when "00011" =>
                        read_data2 <= r(3);
                    when "00100" =>
                        read_data2 <= r(4);
                    when "00101" =>
                        read_data2 <= r(5);
                    when "00110" =>
                        read_data2 <= r(6);
                    when "00111" =>
                        read_data2 <= r(7);
                    when "01000" =>
                        read_data2 <= r(8);
                    when "01001" =>
                        read_data2 <= r(9);
                    when "01010" =>
                        read_data2 <= r(10);
                    when "01011" =>
                        read_data2 <= r(11);
                    when "01100" =>
                        read_data2 <= r(12);
                    when "01101" =>
                        read_data2 <= r(13);
                    when "01110" =>
                        read_data2 <= r(14);
                    when "01111" =>
                        read_data2 <= r(15);
                    when "10000" =>
                        read_data2 <= r(16);
                    when "10001" =>
                        read_data2 <= r(17);
                    when "10010" =>
                        read_data2 <= r(18);
                    when "10011" =>
                        read_data2 <= r(19);
                    when "10100" =>
                        read_data2 <= r(20);
                    when "10101" =>
                        read_data2 <= r(21);
                    when "10110" =>
                        read_data2 <= r(22);
                    when "10111" =>
                        read_data2 <= r(23);
                    when "11000" =>
                        read_data2 <= r(24);
                    when "11001" =>
                        read_data2 <= r(25);
                    when "11010" =>
                        read_data2 <= r(26);
                    when "11011" =>
                        read_data2 <= r(27);
                    when "11100" =>
                        read_data2 <= r(28);
                    when "11101" =>
                        read_data2 <= r(29);
                    when "11110" =>
                        read_data2 <= r(30);
                    when "11111" =>
                        read_data2 <= r(31);
                    when others => null;
                end case;
        end process;

        r(0) <= X"00000000";   -- zero register
        r(29) <= X"00000020";  -- stack pointer

end architecture behavior;
