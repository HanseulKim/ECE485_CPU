library ieee;
use ieee.std_logic_1164.all;

--This mux is for 2 32bit input 
--PC or Data A?

entity instrMem is
     port (pc: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0)); --give instruction written under that pc
end instrMem;

architecture behavior of instrMem is 
 begin
  output <= x"8D280064" when pc = x"00000500" --lw $t0, 100($t1)
       else x"AD280064" when pc = x"00000504" --sw $t0, 100($t1)
       else x"012D4020" when pc = x"00000508" --add $t0, $t1, $t5
       else x"012E4022" when pc = x"0000050C" --sub $t0, $t1, $t6
       else x"012A4024" when pc = x"00000600" --and $t0, $t1, $t2
       else x"012B4025" when pc = x"00000604" --or $t0, $t1, $t3
       else x"012F402A" when pc = x"00000608" -- slt $t0, $t1, $t7
       else x"08000064" when pc = x"0000060C" -- j 100
       else x"11090064" when pc = x"00000700" -- beq $t0, $t1, 100
       else x"012A4027" when pc = x"00000704" --nor $t0, $t1, $t2
       else x"15090064" when pc = x"00000708" -- bne $t0, $t1, 100
       else x"21280064" when pc = x"0000070C" -- addi $t0, $t1, 100
       else x"31280064" when pc = x"00000800" --and $t0, $t1, 100
       else x"35280064" when pc = x"00000804"; --ori $t0, $t1, 100


end architecture behavior;