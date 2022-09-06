library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MICRO is 

	generic
		(
			MIN_COUNT : natural := 0;
			MAX_COUNT : natural := 255
		);
		
	port 
		( 
			reset, clock: in std_logic;
			LED: out std_logic_vector (7 downto 0)

	
	);
 end MICRO;
 
 architecture estrutura of MICRO is 
 
 
	signal sigaddr: integer range MIN_COUNT to MAX_COUNT;
	signal sigrd, sigD_rd, sigD_wr: std_logic;
	signal sigdata, sigR_data, sigW_data: std_logic_vector (15 downto 0);
	signal sigD_addr: std_logic_vector (7 downto 0);
	
	component BCBO is

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
	end component;
	
	component MI is 
   port 
			(
			 addr: in integer range MIN_COUNT to MAX_COUNT;
          rd, clk: in std_logic;
          data: out std_logic_vector (15 downto 0)
			 
			);
	end component;
	
	component MD is 
	
   port 
			( 
			 addr: in std_logic_vector (7 downto 0);
          rd, wr, clk: in std_logic;
          W_data: in std_logic_vector (15 downto 0);
          R_data: out std_logic_vector (15 downto 0)
			 
			);
	end component;
	
	
 begin
 
 blocos: BCBO port map (data => sigdata, R_data => sigR_data, reset => reset, 
 clock => clock, W_data => sigW_data, addr => sigaddr, rd => sigrd, 
 D_addr => sigD_addr, D_rd => sigD_rd, D_wr => sigD_wr, LED => LED);
 memoriains: MI port map (addr => sigaddr, rd => sigrd, 
 clk => clock, data => sigdata);
 memoriadados: MD port map (addr => sigD_addr, rd => sigD_rd, wr => sigD_wr,
clk => clock, W_data => sigW_data, R_data => sigR_data);
 
 
 end estrutura;
