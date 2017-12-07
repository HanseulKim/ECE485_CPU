library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity signext is
     port (input: in std_logic_vector(15 downto 0);
	   output: out std_logic_vector (31 downto 0));
end signext;

architecture behavior of signext is 
 begin
  P1: process (input) is
  begin
    if (input(15 downto 12)>=x"a") then
     output (31 downto 16) <= x"ffff";
    else
     output (31 downto 16) <= x"0000";
    end if;
    output(15 downto 0) <= input;
 end process P1;  			
end architecture behavior;
