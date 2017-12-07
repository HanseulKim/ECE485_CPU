library ieee;
use ieee.std_logic_1164.all;

entity reg is 
	port(opcode: in std_logic_vector (5 downto 0);
	     read1: in std_logic_vector(4 downto 0);
	     read2: in std_logic_vector (4 downto 0);
	     writeReg: in std_logic_vector (4 downto 0);
	     writeData: in std_logic_vector (31 downto 0);
	     a_data: out std_logic_vector (31 downto 0);
	     b_data: out std_logic_vector (31 downto 0));
end entity;

architecture behavior of reg is
	signal regWriteControl : std_logic := '0'; 
  --registers (read purpose)
	constant reg0: std_logic_vector (31 downto 0) := x"00000123";
	constant reg1: std_logic_vector (31 downto 0) := x"00000001";
	constant reg2: std_logic_vector (31 downto 0) := x"00000002"; 
	constant reg3: std_logic_vector (31 downto 0) := x"00000003";
	constant reg4: std_logic_vector (31 downto 0) := x"00000004";
	constant reg5: std_logic_vector (31 downto 0) := x"00000005";
	constant reg6: std_logic_vector (31 downto 0) := x"00000006";
	constant reg7: std_logic_vector (31 downto 0) := x"00000007";

  --registers (write purpose)
	signal wreg0: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg1: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg2: std_logic_vector (31 downto 0) := x"00000000"; 
	signal wreg3: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg4: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg5: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg6: std_logic_vector (31 downto 0) := x"00000000";
	signal wreg7: std_logic_vector (31 downto 0) := x"00000000";

 begin
  -- read1 -> set a_data
  a_data <= reg0 when (read1 = "01000") else
	    reg1 when (read1 = "01001") else
	    reg2 when (read1 = "01010") else
	    reg3 when (read1 = "01011") else
	    reg4 when (read1 = "01100") else
	    reg5 when (read1 = "01101") else
	    reg6 when (read1 = "01110") else
	    reg7 when (read1 = "01111") else
	    x"ffffffff"; --error

  -- read2 -> set b_data
  b_data <= reg0 when (read1 = "01000") else
	    reg1 when (read1 = "01001") else
	    reg2 when (read1 = "01010") else
	    reg3 when (read1 = "01011") else
	    reg4 when (read1 = "01100") else
	    reg5 when (read1 = "01101") else
	    reg6 when (read1 = "01110") else
	    reg7 when (read1 = "01111") else
	    x"ffffffff"; --error

  -- write to register
  -- regWriteControl should be set to 1
  regWriteControl <= '1' when (opcode = "100011" OR opcode = "000000" OR opcode = "001000" OR opcode = "001100" OR opcode = "001101") else 
		     '0';

 -- writeData -> writeReg 
  wreg0 <= writeData when (writeReg = "01000" AND regWriteControl = '1');
  wreg1 <= writeData when (writeReg = "01001" AND regWriteControl = '1');
  wreg2 <= writeData when (writeReg = "01010" AND regWriteControl = '1');
  wreg3 <= writeData when (writeReg = "01011" AND regWriteControl = '1');
  wreg4 <= writeData when (writeReg = "01100" AND regWriteControl = '1');
  wreg5 <= writeData when (writeReg = "01101" AND regWriteControl = '1');
  wreg6 <= writeData when (writeReg = "01110" AND regWriteControl = '1');
  wreg7 <= writeData when (writeReg = "01111" AND regWriteControl = '1');

end architecture behavior;