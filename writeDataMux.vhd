library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity writeDataMux is
     port (l_s_flag: in std_logic;
	   alu_out: in std_logic_vector(31 downto 0);
	   memData: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end writeDataMux;

architecture behavior of writeDataMux is 
 begin
  output <= memData when (l_s_flag = '1')
	else alu_out;			
end architecture behavior;
