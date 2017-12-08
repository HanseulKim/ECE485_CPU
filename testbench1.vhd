library ieee;
use ieee.std_logic_1164.all;

entity testbench1 is 
	port (test_pc: in std_logic_vector(31 downto 0);
	      new_pc: out std_logic_vector (31 downto 0);
	      alu_out_final: out std_logic_vector (31 downto 0));
end entity;

architecture behavior of testbench1 is
-------------------global temporary constants-----------------
signal test_inst: std_logic_vector (31 downto 0);
signal test_opcode: std_logic_vector(5 downto 0);
signal test_rs: std_logic_vector (4 downto 0);
signal test_rd: std_logic_vector (4 downto 0);
signal test_r_flag: std_logic;
signal test_rt: std_logic_vector (4 downto 0);
signal test_functionField: std_logic_vector (5 downto 0);
signal test_shmt: std_logic_vector (4 downto 0);
signal test_branchImm: std_logic_vector (15 downto 0);
signal test_jumpImm: std_logic_vector (25 downto 0);
signal test_writeReg: std_logic_vector (4 downto 0);
signal test_a_data_input: std_logic_vector (31 downto 0);
signal test_b_data_input: std_logic_vector (31 downto 0);
signal test_writeData: std_logic_vector (31 downto 0);
signal test_a_data: std_logic_vector (31 downto 0);
signal test_b_data: std_logic_vector (31 downto 0);
signal test_Imm: std_logic_vector (31 downto 0);
signal test_pc_inc: std_logic_vector (31 downto 0) := x"00000004";
signal test_branchFlag: std_logic;
signal test_l_s_flag: std_logic;
signal test_alu_out: std_logic_vector (31 downto 0);
signal test_memData: std_logic_vector (31 downto 0);
------------------------components----------------------------
--IF
component instrMem
	port (pc: in std_logic_vector (31 downto 0);
	       output: out std_logic_vector (31 downto 0));
end component;

--ID
component InstrDecode
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
end component;

  -- R-type? set rd
component writeMux
     port (r_flag: in std_logic;
           rt: in std_logic_vector(4 downto 0);
	   rd: in std_logic_vector(4 downto 0);
	   output: out std_logic_vector (4 downto 0));
end component;

component registers
     port(opcode: in std_logic_vector (5 downto 0);
	     read1: in std_logic_vector(4 downto 0);
	     read2: in std_logic_vector (4 downto 0);
	     writeReg: in std_logic_vector (4 downto 0);
	     writeData: in std_logic_vector (31 downto 0);
	     a_data: out std_logic_vector (31 downto 0);
	     b_data: out std_logic_vector (31 downto 0));
end component;

  -- input A to ALU
component mux2_1
     port (opcode: in std_logic_vector (5 downto 0);
	   pc: in std_logic_vector(31 downto 0);
	   dataA: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end component;

component signExtension
     port (opcode: in std_logic_vector (5 downto 0);
	   imm: in std_logic_vector(15 downto 0);
	   output: out std_logic_vector (31 downto 0));
end component;

  -- input B to ALU
component mux4_1
     port (opcode: in std_logic_vector (5 downto 0);
	   imm: in std_logic_vector(31 downto 0);
	   signal pc_inc: std_logic_vector(31 downto 0) := x"00000004";
	   dataB: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end component;

-- EXE
component ALU
    port ( functionField : in std_logic_vector(5 downto 0);
	   opcode: in std_logic_vector (5 downto 0);
	   a_data : in std_logic_vector(31 downto 0);
	   b_data : in std_logic_vector(31 downto 0);
	   branchFlag: out std_logic;
	   l_s_flag: out std_logic;
	   alu_out : out std_logic_vector(31 downto 0)); --outputs
end component;

component PC_Calc
   port (PC_in : in std_logic_vector(31 downto 0); --input
	 opcode : in std_logic_vector(5 downto 0); --input
	 branchImm: in std_logic_vector (15 downto 0);
	 jumpImm: in std_logic_vector (25 downto 0); 
	 branchFlag: in std_logic; -- 1: yes, 0: no 
	 PC_out : out std_logic_vector(31 downto 0)); -- output
end component;

--MEM
component dataMem
port ( addr: in std_logic_vector (31 downto 0); 
       l_s_flag: in std_logic; -- 1; load, 0; store
	memWriteData: in std_logic_vector (31 downto 0);
       output: out std_logic_vector (31 downto 0));
end component;


--WB -> load only
component writeDataMux
     port (l_s_flag: in std_logic;
	   alu_out: in std_logic_vector(31 downto 0);
	   memData: in std_logic_vector(31 downto 0);
	   output: out std_logic_vector (31 downto 0));
end component;


begin

Instruction_Memory: instrMem port map (pc => test_pc, output => test_inst);

Instruction_Decode: instrDecode port map (instr => test_inst, opcode => test_opcode, rs => test_rs, rd => test_rd, r_flag => test_r_flag, rt => test_rt, functionField => test_functionField, shmt => test_shmt, branchImm => test_branchImm, jumpImm => test_jumpImm);

Write_reg : writeMux port map (r_flag => test_r_flag, rt=> test_rt, rd => test_rd, output=> test_writeReg);

Reg: registers port map (opcode => test_opcode, read1 => test_rs, read2 => test_rt, writeReg => test_writeReg, writeData => test_writeData , a_data => test_a_data_input, b_data => test_b_data_input);

A_data: mux2_1 port map (opcode => test_opcode, pc=>test_pc, dataA => test_a_data_input, output => test_a_data);

Sign_Extension: signExtension port map (opcode => test_opcode, imm => test_branchImm, output => test_Imm);

B_data: mux4_1 port map (opcode => test_opcode, imm => test_Imm, pc_inc => test_pc_inc, dataB => test_b_data_input,output => test_b_data);

EXE: ALU port map (functionField => test_functionField, opcode => test_opcode, a_data => test_a_data, b_data => test_b_data, branchFlag => test_branchFlag, l_s_flag => test_l_s_flag, alu_out => test_alu_out);

MEM: dataMem port map (addr => test_alu_out, l_s_flag => test_l_s_flag, memWriteData => test_b_data, output => test_memData);

PC: PC_Calc port map (PC_in => test_pc, opcode => test_opcode, branchImm => test_branchImm, jumpImm => test_jumpImm, branchFlag => test_branchFlag, PC_out => new_pc);

WB: writeDataMux port map (l_s_flag => test_l_s_flag, alu_out => test_alu_out, memData => test_memData, output => test_writeData);

alu_out_final <= test_alu_out;
end architecture behavior; 