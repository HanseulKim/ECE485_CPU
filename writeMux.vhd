library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--Write to rt or rd?

entity writeMux is
     port (r_flag: in std_logic;
           rt: in std_logic_vector(4 downto 0);
	   rd: in std_logic_vector(4 downto 0);
	   output: out std_logic_vector (4 downto 0));
end writeMux;

architecture behavior of writeMux is 
 begin
  output <= rd when (r_flag = '1') -- R-instruction
	else rt;
end architecture behavior;