library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity writeMux is
     port (rs: in std_logic_vector(4 downto 0);
	   rt: in std_logic_vector(4 downto 0);
	   output: out std_logic_vector (4 downto 0));
end writeMux;

architecture behavior of writeMux is 
 begin
  output <= rs;			--fix this
end architecture behavior;