library ieee; 
use ieee.std_logic_1164.all;


entity PC_Calc is 
   port (PC_in : in std_logic_vector(31 downto 0); --input
	 PC_out : out std_logic_vector(31 downto 0)); -- output
end PC_Calc;

--define behavior
architecture behavior of PC_Calc is 
  begin
	PC_out <= (PC_in +4);

end architecture behavior;