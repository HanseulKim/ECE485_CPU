library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--jump? branch? regular increment?

entity writeDataMux is
     port (alu_out: in std_logic_vector(31 downto 0);
	   jump: in std_logic_vector(31 downto 0);
	   branch: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end writeDataMux;

architecture behavior of writeDataMux is 
 begin
  output <= alu_out;			--fix this
end architecture behavior;
