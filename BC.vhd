library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BC is 

generic
		(
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 255
		);

		port 

		

      (data: in std_logic_vector (15 downto 0);
       RF_Rp_zero, clock, reset: in std_logic;
       RF_s : out std_logic_vector (1 downto 0);
		 alu_s : out std_logic_vector (1 downto 0);
	    RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector (3 downto 0);
		 RF_W_wr, RF_Rp_rd, RF_Rq_rd: out std_logic;
		 addr: out integer range MIN_COUNT to MAX_COUNT;
		 rd: out std_logic;
		 RF_W_data: out std_logic_vector (15 downto 0);
		 D_addr: out std_logic_vector (7 downto 0);
		 D_rd, D_wr: out std_logic;
		 LED: out std_logic_vector (7 downto 0)


       );

end BC;

architecture estrutura of BC is 

   signal sigldPC, sigclrPC, sigincPC, sigldIR: std_logic;
	signal sigIR: std_logic_vector (15 downto 0);

   component FSM1 is port 

(      IR: in std_logic_vector (15 downto 0);
       clock, reset, RF_Rp_zero: in std_logic;
		 RF_W_addr, RF_Rp_addr, RF_Rq_addr: out std_logic_vector (3 downto 0);
		 RF_W_wr, RF_Rp_rd, RF_Rq_rd: out std_logic;
		 alu_s, RF_s: out std_logic_vector (1 downto 0);
		 RF_W_data: out std_logic_vector (15 downto 0);
		 D_addr: out std_logic_vector (7 downto 0);
		 D_rd, D_wr: out std_logic;
		 PC_ld, PC_clr, PC_inc: out std_logic; 
		 I_rd: out std_logic;
		 IR_ld: out std_logic;
		 LED: out std_logic_vector (7 downto 0)
);

   end component;
	
	component IR is port 

(      instIN: in std_logic_vector (15 downto 0);
		 load, clk: in std_logic;
		 instOUT: out std_logic_vector (15 downto 0)
		 
);

   end component;
	
	component PC is

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 255
	);

	port
	(
		clk, clear, load, inc: in std_logic;
		pcOUT: out integer range MIN_COUNT to MAX_COUNT;
		offset : in std_logic_vector (7 downto 0)
	);

  end component;

begin

fsm2: FSM1 port map (IR => sigIR, clock => clock, reset => reset, RF_Rp_zero => RF_Rp_zero, RF_W_addr => RF_W_addr, RF_Rp_addr => RF_Rp_addr, 
RF_Rq_addr => RF_Rq_addr, RF_W_wr => RF_W_wr, RF_Rp_rd => RF_Rp_rd, RF_Rq_rd => RF_Rq_rd, alu_s => alu_s, RF_s => RF_s, RF_W_data => RF_W_data, 
D_addr => D_addr, D_rd => D_rd, D_wr => D_wr, PC_ld => sigldPC, PC_clr => sigclrPC, PC_inc => sigincPC, I_rd => rd, IR_ld => sigldIR, LED => LED);

reginst: IR port map (instIN => data, load => sigldIR, clk => clock, instOUT => sigIR);

contprog: PC port map (clk => clock, clear => sigclrPC, load => sigldPC, inc => sigincPC, pcOUT => addr, offset => sigIR(7 downto 0));

end estrutura; 