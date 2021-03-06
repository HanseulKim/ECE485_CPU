library ieee;
use ieee.std_logic_1164.all;

entity testbench1 is 
end entity;

architecture behavior of testbench1 is 

 component testbench1 is 
	port (test_pc: in std_logic_vector(31 downto 0);
	      new_pc: out std_logic_vector (31 downto 0);
	      alu_out_final: out std_logic_vector (31 downto 0));
 end component;

signal test_input: std_logic_vector (31 downto 0);
signal new_pc_out: std_logic_vector (31 downto 0);
signal alu_out_final_out: std_logic_vector (31 downto 0);

 begin

test: testbench1 port map (test_pc => test_input, new_pc => new_pc_out, alu_out_final => alu_out_final_out);

    PC_Process: process
	begin
		test_input <=   x"8D280064" after 0ns,
      				x"AD280064" after 10ns,
       				x"012D4020" after 20ns,
       				x"012E4022" after 30ns,
       				x"012A4024" after 40ns,
       				x"012B4025" after 50ns,
       				x"012F402A" after 60ns,
       				x"08000064" after 70ns,
       				x"11090064" after 80ns,
       				x"012A4027" after 90ns,
       				x"15090064" after 100ns,
       				x"21280064" after 110ns,
       				x"31280064" after 120ns,
       				x"35280064" after 130ns;
	wait;
    end process PC_Process;

end architecture behavior;
