-- Group Members: Alex Gomez, Roya Salei, Roberto Toribio, and Harshit Rao
-- Date: 12/06/2021
-- Project: Final Project
-- Course: CS 3650

library IEEE;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;

entity mips is
generic(gatedelay:time:=10 ns;
	clockdelay:time:=200 ns
	);
--port (
	--reset: in std_logic
	--pc_out : out std_logic_vector(31 downto 0)
	--);
end mips;

architecture behavioral of mips is
----------------------------------------------------------------
component alu is
port (
  	a: in std_logic_vector(31 downto 0);
	b : in std_logic_vector(31 downto 0); -- src1, src2
	shamt : in std_logic_vector(4 downto 0); -- shift amount
	alu_control : in std_logic_vector(2 downto 0); -- function select
	alu_result: out std_logic_vector(31 downto 0); -- ALU Output alu_result
	zero: out std_logic -- Zero Flag
	);
end component;

------------------------------------------------------------------
component clock is
	generic(delay : time := clockdelay);
	port(clk : out std_logic;
	reset : in std_logic);
	end component;

-----------------------------------------------------------------
component instructionMemory is
port (	

	clk: IN STD_LOGIC;
	memr: IN STD_LOGIC;	
	addr : IN STD_LOGIC_VECTOR (31 DOWNTO 0); 
	instruction : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	
	);
end component;

-------------------------------------------------------------------
component mux is
generic(width:integer:= 32;
	delay:time:= gatedelay);
port(	inpu1:in std_logic_vector(width-1 downto 0);
	inpu2:in std_logic_vector(width-1 downto 0);
	s:in std_logic;
	outpt:out std_logic_vector(width-1 downto 0)
	);
end component;

-------------------------------------------------------------------

component shift is
port(
	input:in std_logic_vector(31 downto 0);
	result:out std_logic_vector(31 downto 0)
	);
end component;

--------------------------------------------------------------------
component sign_extend is
port(
	input:in std_logic_vector(15 downto 0);
	output:out std_logic_vector(31 downto 0)
	);
end component;

--------------------------------------------------------------------
component data_memory is
    port(
    clk:in std_logic;
    memWrite:in std_logic;
    memRead:in std_logic;
    addr:in std_logic_vector(31 downto 0);
    mem_write_data:in std_logic_vector(31 downto 0);
    mem_read_data:out std_logic_vector(31 downto 0)
    );
    end component;

-------------------------------------------------------------------
component alucontrol is 
   
    port(aluop: in std_logic_vector(2 downto 0);
    ALU_Funct: in std_logic_vector(5 downto 0);
    ALU_Control: out std_logic_vector(2 downto 0)
    );
    end component;

--------------------------------------------------------------------
component ControlUnit is 
    
    port(
    	opCode: in std_logic_vector(5 downto 0);
	regDst: out std_logic;
	branch: out std_logic;
	memRead: out std_logic;
	memToReg: out std_logic;
	aluOp: out std_logic_vector(2 downto 0);
    	memWrite: out std_logic;
   	aluSrc: out std_logic;
    	regWrite: out std_logic;
	jump: out std_logic;
	clk: in std_logic;
    	reset: in std_logic
 	);
    end component;

----------------------------------------------------------------------
component adder is
port (
	input1:in std_logic_vector(31 downto 0);
	input2:in std_logic_vector(31 downto 0);
	result:out std_logic_vector(31 downto 0)
	);
end component;

----------------------------------------------------------------------
component Register_File is

    Port(
	signal reg_read_addr_1: in std_logic_vector(4 downto 0); 
	signal reg_read_addr_2 : in std_logic_vector(4 downto 0);
	signal reg_write_dest: in std_logic_vector(4 downto 0); 
  	signal write_data : in std_logic_vector(31 downto 0);
  	signal read_data1: out std_logic_vector(31 downto 0); 
	signal read_data2: out std_logic_vector(31 downto 0);
  	signal clk     : in std_logic;
	signal regWrite: in std_logic);
    end component;

------------------------------------------------------------------------

component pc is
generic(width:integer:=32);
port(
	input:in std_logic_vector(width-1 downto 0);
	result:out std_logic_vector(width-1 downto 0);
	clock:in std_logic;
	reset:in std_logic
	);
end component;

------------------------------------------------------------------------
signal clk	     :std_logic:='0';
signal reset	     :std_logic:='0';

-------------------instrtuction Fetch----------------------------------
signal addFour       :std_logic_vector(31 downto 0):="00000000000000000000000000000001";
signal pcAdderOut    :std_logic_vector(31 downto 0):=x"00000000";
signal PcOut	     :std_logic_vector(31 downto 0):=x"00000000";
--signal addr          :std_logic_vector(31 downto 0):=x"00000000";
signal instruction   :std_logic_vector(31 downto 0):=x"00000000";
signal memr          :std_logic:='1';
signal adder2adder   :std_logic_vector(31 downto 0):=x"00000000";
signal adderresult2   :std_logic_vector(31 downto 0):=x"00000000";
signal andRes	     :std_logic:='0';

signal IFIDInput		:std_logic_vector(63 downto 0);
signal IFIDRresult		:std_logic_vector(63 downto 0);

---------------------Instruction Decode-----------------------------------

--register--
signal regWrite4	  :std_logic;
signal instruction2	  :std_logic_vector(31 downto 0):=x"00000000";
signal adder2adder2   	  :std_logic_vector(31 downto 0):=x"00000000";
signal regWrite           :std_logic:='0';
--signal reg_write_dest     :std_logic_vector(4 downto 0):="00000";
--signal reg_read_addr_1    :std_logic_vector(4 downto 0):="00000";
--signal reg_read_addr_2    :std_logic_vector(4 downto 0):="00000";
--signal write_data         :std_logic_vector(31 downto 0):=x"00000000";
signal read_data1         :std_logic_vector(31 downto 0):=x"00000000";
signal read_data2         :std_logic_vector(31 downto 0):=x"00000000";
signal assembler_temp     :std_logic_vector(31 downto 0):=x"00000000";
signal signExtendOut      :std_logic_vector(31 downto 0):=x"00000000";
signal MuxMemout	  :std_logic_vector(31 downto 0):=x"00000000";
signal muxInsOut3	  :std_logic_vector(4 downto 0):="00000";

signal Branchne1	  :std_logic:='0';
--control--
signal opCode               :std_logic_vector(5 downto 0):="000000";
signal regDst               :std_logic:='0';
signal jump                 :std_logic:='0';
signal branch               :std_logic:='0';
signal memRead              :std_logic:='0';
signal memToReg             :std_logic:='0';
signal aluOp                :std_logic_vector(2 downto 0):="000";
signal memWrite             :std_logic:='0';
signal aluSrc               :std_logic:='0';
--signal signExtend           :std_logic:='0'; 

signal IDEXRresult		:std_logic_vector(148 downto 0);
signal IDEXInput		:std_logic_vector(148 downto 0);



------------------Execution stage-------------------
signal shiftResult	  :std_logic_vector(31 downto 0):=x"00000000";
--signal instruction3	   :std_logic_vector(31 downto 0):=x"00000000";
signal adder2adder3   	  :std_logic_vector(31 downto 0):=x"00000000";
signal regWrite2           :std_logic:='0';
signal signExtendOut2      :std_logic_vector(31 downto 0):=x"00000000";
signal read_data12         :std_logic_vector(31 downto 0):=x"00000000";
signal read_data22         :std_logic_vector(31 downto 0):=x"00000000";
signal adderresult1   :std_logic_vector(31 downto 0):=x"00000000";
signal muxInsOut1	  :std_logic_vector(4 downto 0):="00000";
signal partOfInstructor	:std_logic_vector(9 downto 0):="0000000000";
signal MuxRegsout		:std_logic_vector(31 downto 0):=x"00000000";
signal branchne2		:std_logic:='0';
signal opCode2               :std_logic_vector(5 downto 0):="000000";
signal regDst2               :std_logic:='0';
signal jump2                 :std_logic:='0';
signal branch2               :std_logic:='0';
signal memRead2              :std_logic:='0';
signal memToReg2             :std_logic:='0';
signal aluOp2                :std_logic_vector(2 downto 0):="000";
signal memWrite2             :std_logic:='0';
signal aluSrc2               :std_logic:='0';

--alu--
signal ALUzerotmp		:std_logic:='0';
signal alu_result        :std_logic_vector(31 downto 0):=x"00000000";
signal zero              :std_logic:='0';
--mux--
signal aluMuxOut         :std_logic_vector(31 downto 0):=x"00000000";
--control--
signal ALU_Control       :std_logic_vector(2 downto 0):="000";
signal ALUout1			:std_logic_vector(31 downto 0):=x"00000000";

signal EXMEMInput		:std_logic_vector(106 downto 0);
signal EXMEMRresult		:std_logic_vector(106 downto 0);


---------------------Memory stage-------------------

signal muxInsOut	:std_logic_vector(4 downto 0):="00000";
signal branch3          :std_logic:='0';
signal memRead3         :std_logic:='0';
signal memToReg3        :std_logic:='0';
signal memWrite3        :std_logic:='0';
signal regWrite3        :std_logic:='0';
signal alu_result2      :std_logic_vector(31 downto 0):=x"00000000";
signal zero2            :std_logic:='0';
signal read_data23      :std_logic_vector(31 downto 0):=x"00000000";
signal muxInsOut2	:std_logic_vector(4 downto 0):="00000";

signal mem_read_data    :std_logic_vector(31 downto 0):=x"00000000";

signal MEMWBInput	:std_logic_vector(70 downto 0);
signal MEMWBRresult	:std_logic_vector(70 downto 0);

---------------------Write back stage-------------------

signal mem_read_data2		:std_logic_vector(31 downto 0):=x"00000000";
signal alu_result3		:std_logic_vector(31 downto 0):=x"00000000";
signal memToReg4            	 :std_logic:='0';


-----------------------begin Process IF Stage----------------------
begin

IFIDInput <= adder2adder & instruction;

mux1 : mux 
port map(
	adder2adder,
	adderresult2,
	andRes,
	pcAdderOut
	);
pc1 : pc	
port map(
	PcAdderOut,
	PcOut,
	clk,
	reset
	);
adder1 : adder			
port map(
	addFour,
	PcOut,
	adder2adder
	);

instMem	: instructionMemory
	
port map(
	clk,
	memr,
	PcOut,
	instruction
	);
IFID_PC	: pc
generic map(width => 64) 
port map(
	IFIDInput,
	IFIDRresult,
	clk,
	reset);
	



-----------------ID stage---------------------

adder2adder2	<= IFIDRresult(63 downto 32);
instruction2	<= IFIDRresult(31 downto 0);

IDEXInput <= branchne1 & regDst & branch & memRead 
	   & memtoReg & aluOp & memWrite & aluSrc 
	   & regWrite & adder2adder2 & read_Data1 
	   & read_Data2 & signExtendOut 
           & instruction2(20 downto 16) 
	   & instruction2(15 downto 11);

signextend : sign_extend		
port map(
	instruction(15 downto 0),
	signExtendOut
	);

RegisterFile  : Register_File 	
port map(
	instruction2(25 downto 21),
	instruction2(20 downto 16),
	muxInsOut3,
	MuxMemout,
	read_Data1,
	read_Data2,
	clk,
	regWrite4
	);
Control_Unit : ControlUnit		
port map(
	instruction2(31 downto 26),
	regDst,
	branch,
	memRead,
	memtoReg,
	aluOp,
	memWrite,
	aluSrc,
	regWrite,
	jump,
	clk,
	reset
	);

IDEX_PC	: pc
generic map(width => 149) 
port map(
	IDEXInput,
	IDEXRresult,
	clk,
	reset
	);
	

--------------Ex stage-------------------

branchne2		<= IDEXRresult(148);
regDst2			<= IDEXRresult(147);
branch2			<= IDEXRresult(146);
memRead2		<= IDEXRresult(145);
memtoReg2		<= IDEXRresult(144);
aluOp2			<= IDEXRresult(143 downto 141);
memWrite2		<= IDEXRresult(140);
aluSrc2			<= IDEXRresult(139);
regWrite2		<= IDEXRresult(138);

adder2adder3		<= IDEXRresult(137 downto 106);
read_Data12		<= IDEXRresult(105 downto 74);
read_Data22		<= IDEXRresult(73 downto 42);
signExtendOut2		 <= IDEXRresult(41 downto 10);
partOfInstructor 	<= IDEXRresult(9 downto 0);

zero			<= ALUzerotmp  xor branchne2 after gatedelay;
EXMEMInput		<= branch2 & memRead2 & memtoReg2 & memWrite2 
			& regWrite2 & adderResult1 & zero & alu_result 
			& read_Data22 & muxInsOut1;

adder2 : adder
port map(
	shiftResult,
	adder2adder3,
	adderResult1
	);

--shiftResult <= signExtendOut;
shiftR:shift	
port map(
	signExtendOut2,
	shiftResult
	);
A_LU : mux				
port map(
	read_Data22,
	signExtendOut2,
	aluSrc2,
	MuxRegsout
	);
mux2 : alu				
port map(
	read_Data12,
	MuxRegsout,
	instruction2(10 downto 6),
	ALU_Control,
	alu_result,
	ALUzerotmp
	);
ALU_Control2 : aluControl	
port map(
	aluOp2,
	signExtendOut2(5 downto 0),
	ALU_Control
	);
mux3 : mux
generic map(width => 5)			
port map(
	partOfInstructor(9 downto 5),
	partOfInstructor(4 downto 0),
	regDst2,
	muxInsOut
	);
		
EXMEM :	pc
generic map(width => 107) 
port map(
	EXMEMInput,
	EXMEMRresult,
	clk,
	reset);
	
--------------Mem Stage------------------

branch3			<= EXMEMRresult(106);
memRead3		<= EXMEMRresult(105);
memtoReg3		<= EXMEMRresult(104);
memWrite3		<= EXMEMRresult(103);
regWrite3		<= EXMEMRresult(102);
	---------------
	
adderResult2		<= EXMEMRresult(101 downto 70);
zero2			<= EXMEMRresult(69);
alu_result2		<= EXMEMRresult(68 downto 37);
read_Data23		<= EXMEMRresult(36 downto 5);
muxInsOut2		<= EXMEMRresult(4 downto 0);

MEMWBInput		<= memtoReg3 & regWrite3 & mem_read_data 
			& alu_result2 & muxInsOut2;
andRes			<= branch3 and zero2 after gatedelay;

DataMemory:data_memory		
port map(
	clk,
	memWrite3,
	memRead3,
	alu_result2,
	read_Data23,
	mem_read_data
	);

MEMWB :	pc
generic map(width => 71) 
port map(
	MEMWBInput,
	MEMWBRresult,
	clk,
	reset);
--------------Writeback Stage------------------

memtoReg4		<= MEMWBRresult(70);
regWrite4		<= MEMWBRresult(69);

mem_read_data2		<= MEMWBRresult(68 downto 37);
alu_result3		<= MEMWBRresult(36 downto 5);
muxInsOut3		<= MEMWBRresult(4 downto 0);

mux4 : mux				
 port map( 
	alu_result3,
	mem_read_data2,
	memtoReg4,
	MuxMemout
	);

Pclock : clock			
port map(
	clk,
	reset
	);

process
	begin
		reset	<=	'1';
		wait for 20 ns;
		reset	<=	'0';
		
		wait;
    end process;

end behavioral;