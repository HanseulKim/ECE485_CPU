library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity mux4_1 is
     port (imm: in std_logic_vector(31 downto 0);
	   signal pc_inc: std_logic_vector(31 downto 0) := x"00000004";
	   dataB: in std_logic_vector(31 downto 0);
	   target: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end mux4_1;

architecture behavior of mux4_1 is 
 begin
  output <= imm;			--fix this
end architecture behavior;
