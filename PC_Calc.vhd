library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC_Calc is 
   port (PC_in : in std_logic_vector(31 downto 0); --input
	 opcode : in std_logic_vector(5 downto 0); --input
	 branchImm: in std_logic_vector (15 downto 0);
	 jumpImm: in std_logic_vector (25 downto 0); 
	 branchFlag: in std_logic; -- 1: yes, 0: no 
	 PC_out : out std_logic_vector(31 downto 0)); -- output
end PC_Calc;

--define behavior
architecture behavior of PC_Calc is 
  begin
  P1: process (opcode, jumpImm, PC_in, branchImm) is
    begin
     if (branchFlag = '1') AND ((opcode = "000100") OR (opcode = "000101")) then -- branch
        PC_out <= std_logic_vector(unsigned(PC_in) + (unsigned(branchImm) sll 2));
     elsif (opcode = "000010") then
	PC_out <= std_logic_vector(unsigned(jumpImm) sll 2);	
     else
	PC_out <= std_logic_vector(unsigned(PC_in) +4); --pc increment
     end if;
   end process P1;
end architecture behavior;