library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity instrDecode is 
   port (instr : in std_logic_vector(31 downto 0); --input
	 opcode: out std_logic_vector (5 downto 0);
	 rs: out std_logic_vector(4 downto 0);
	 rd: out std_logic_vector (4 downto 0);
	 r_flag: out std_logic;
	 rt: out std_logic_vector (4 downto 0);
	 functionField: out std_logic_vector (5 downto 0);
	 shmt: out std_logic_vector (4 downto 0); 
	 branchImm: out std_logic_vector(15 downto 0);
	 jumpImm: out std_logic_vector(25 downto 0));
end instrDecode;

--define behavior
architecture behavior of instrDecode is 
begin
  r_flag <= '0';
  P1: process (instr) is
    begin
     if instr(31 downto 26) = "000000" then
	opcode <= instr(31 downto 26);
	rs <= instr(25 downto 21);
	rt <= instr(20 downto 16);
	rd <= instr(15 downto 11);
	shmt <= instr(10 downto 6);
	functionField <= instr(5 downto 0);
	r_flag <= '1';
     elsif instr(31 downto 26) = "100011" or instr(31 downto 26) = "101011" or instr(31 downto 26) = "000100" or instr(31 downto 26) = "000101" or instr(31 downto 26) = "001000" or instr(31 downto 26) = "001100" or instr(31 downto 26) = "001101" then
   	opcode <= instr(31 downto 26);
	rs <= instr(25 downto 21);
	rt <= instr (20 downto 16); 
	branchImm <= instr (15 downto 0);
     elsif instr(31 downto 26) = "000010" then
	opcode <= instr(31 downto 26);
	jumpImm <= instr(25 downto 0);
     else
	opcode <= "111111";
	rs <= "11111";
	rt <= "11111";
	rd <= "11111";
	shmt <= "11111";
	functionField <= "111111";
     end if;
     end process P1;
end architecture behavior;
