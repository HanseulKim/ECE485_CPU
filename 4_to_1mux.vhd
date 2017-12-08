library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity mux4_1 is
     port (opcode: in std_logic_vector (5 downto 0);
	   imm: in std_logic_vector(31 downto 0);
	   signal pc_inc: std_logic_vector(31 downto 0) := x"00000004";
	   dataB: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end mux4_1;

architecture behavior of mux4_1 is 
 begin
  output <= imm when(opcode (5 downto 4) = "10") else --I-type
	    dataB when (opcode = "000000" OR opcode(5 downto 2) = "0001") else --R-type 
	    std_logic_vector(unsigned(imm) sll 2) when (opcode(5 downto 3)= "001") else --branch
	    pc_inc;
end architecture behavior;
