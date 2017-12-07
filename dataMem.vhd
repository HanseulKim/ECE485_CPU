library ieee;
use ieee.std_logic_1164.all;

entity dataMem is
port ( addr: in std_logic_vector (31 downto 0); 
       l_s_flag: in std_logic; -- 1; load, 0; store
	memWriteData: in std_logic_vector (31 downto 0);
       output: out std_logic_vector (31 downto 0));
end entity;

architecture behavior of dataMem is 

--memory values that were used in the instruction set will be implemented only

 signal loadData: std_logic_vector(31 downto 0) := x"00000123"; --pre-calculated data, that will be loaded to the reg
 signal storeData: std_logic_vector(31 downto 0) := x"00000123"; --pre-calculated data, that will be stored in memory

begin 
    --load
    output <= loadData when (l_s_flag = '1' AND addr = x"00000580" ) ;

    -- store
    storeData <= memWriteData when (addr = x"00000584" and l_s_flag = '0');

end architecture behavior;
