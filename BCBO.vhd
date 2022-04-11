library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BCBO is

	generic
		(
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 255
		);

	port 
		( 
		    data, R_data: in std_logic_vector (15 downto 0);
			 clock, reset: in std_logic;
	       W_data: out std_logic_vector (15 downto 0);
			 addr: out integer range MIN_COUNT to MAX_COUNT;
			 rd: out std_logic;
			 D_addr: out std_logic_vector (7 downto 0);
			 D_rd, D_wr: out std_logic;
			 LED: out std_logic_vector (7 downto 0)
			 
	
		);
end BCBO;

architecture estrutura of BCBO is 

	signal sigRF_W_data: std_logic_vector (15 downto 0);
	signal sigRF_s, sigalu_s: std_logic_vector (1 downto 0);
	signal sigRF_W_addr, sigRF_Rp_addr, sigRF_Rq_addr: std_logic_vector (3 downto 0);
	signal sigRF_W_wr, sigRF_Rp_rd, sigRF_Rq_rd, sigRF_Rp_zero: std_logic;
	

	component BC is 

		generic
		(
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 255
		);

		port 

      (
		 data: in std_logic_vector (15 downto 0);
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

	end component;
	
	component BO is 
		port 
		
		( 
		    R_data, RF_W_data: in std_logic_vector (15 downto 0);
			 RF_s : in std_logic_vector (1 downto 0);
			 alu_s : in std_logic_vector (1 downto 0);
	       RF_W_addr, RF_Rp_addr, RF_Rq_addr : in std_logic_vector (3 downto 0);
			 RF_W_wr, RF_Rp_rd, RF_Rq_rd : in std_logic;
			 RF_Rp_zero : out std_logic;
			 W_data : out std_logic_vector (15 downto 0);
			 clock : in std_logic
	);
	
	end component;

begin

blococontrole: BC port map (data => data, RF_Rp_zero => sigRF_Rp_zero, clock => clock, reset => reset, 
RF_s => sigRF_s, alu_s => sigalu_s, RF_W_addr => sigRF_W_addr, RF_Rp_addr => sigRF_Rp_addr, 
RF_Rq_addr => sigRF_Rq_addr, RF_W_wr => sigRF_W_wr, RF_Rp_rd => sigRF_Rp_rd, 
RF_Rq_rd => sigRF_Rq_rd, addr => addr, rd => rd, RF_W_data => sigRF_W_data, 
D_addr => D_addr, D_rd => D_rd, D_wr => D_wr, LED => LED);

blocooperacional: BO port map (R_data => R_data, RF_W_data => sigRF_W_data, RF_s => sigRF_s, alu_s => sigalu_s, 
RF_W_addr => sigRF_W_addr, RF_Rp_addr => sigRF_Rp_addr, RF_Rq_addr => sigRF_Rq_addr, RF_W_wr => sigRF_W_wr, 
RF_Rp_rd => sigRF_Rp_rd, RF_Rq_rd => sigRF_Rq_rd, RF_Rp_zero => sigRF_Rp_zero, W_data => W_data, clock => clock);


end estrutura; 
	