library ieee; 
use ieee.stdlogic.all;


entity PC_Calc is 
   port (PC_in : in std_logic_vector(31 downto 0); --input
	 PC_out : out std_logic_vector(31 downto 0)); -- output
end PC_Calc;

--define behavior
architecture behave of PC_Calc is 
  begin
	PC_out <= (PC_in +4);

end architecture behave;