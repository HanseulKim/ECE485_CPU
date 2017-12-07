library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity mux2_1 is
     port (pc: in std_logic_vector(31 downto 0);
	   dataA: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end mux2_1;

architecture behavior of mux2_1 is 
 begin
  output <= pc;			--fix this
end architecture behavior;