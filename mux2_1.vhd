library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity mux2_1 is
     port (opcode: in std_logic_vector (5 downto 0);
	   pc: in std_logic_vector(31 downto 0);
	   dataA: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end mux2_1;

architecture behavior of mux2_1 is 
 begin
  output <= pc when opcode = "000010"	--jump instrcution takes pc as ALU sourceA
	    else dataA; 
end architecture behavior;
