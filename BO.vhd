library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BO is 
   port ( R_data, RF_W_data: in std_logic_vector (15 downto 0);
			 RF_s : in std_logic_vector (1 downto 0);
			 alu_s : in std_logic_vector (1 downto 0);
	       RF_W_addr, RF_Rp_addr, RF_Rq_addr : in std_logic_vector (3 downto 0);
			 RF_W_wr, RF_Rp_rd, RF_Rq_rd : in std_logic;
			 RF_Rp_zero : out std_logic;
			 W_data : out std_logic_vector (15 downto 0);
			 clock : in std_logic
	);
	
end BO;

architecture estrutura of BO is

   signal sigALU, sigRp, sigRq, sigMUX: std_logic_vector (15 downto 0);
	signal sigD: std_logic_vector (15 downto 0) := "0000000000000000"; 

   component BANCOREG is 
      port ( W_addr, Rp_addr, Rq_addr : in std_logic_vector (3 downto 0);
	 		    clock, W_wr, Rp_rd, Rq_rd : in std_logic;
			    W_data : in std_logic_vector (15 downto 0);
			    Rp_data, Rq_data : out std_logic_vector (15 downto 0)
				 
	
	);
	
   end component;

   component MUX is  
	   port ( A, B, C, D: in std_logic_vector (15 downto 0);
             s: in std_logic_vector (1 downto 0);
			    E: out std_logic_vector (15 downto 0)
  );
	
   end component;

   component ULA16bits is 
	   port (A, B : in  std_logic_vector (15 downto 0); 
            S    : in  std_logic_vector (1 downto 0); 
            X    : out std_logic_vector (15 downto 0); 
	         x0   : out std_logic 
   );
	
   end component;

begin

	W_data <= sigRp;
	
banco : BANCOREG port map (W_addr => RF_W_addr, Rp_addr => RF_Rp_addr, Rq_addr => RF_Rq_addr, W_wr => RF_W_wr, Rp_rd => RF_Rp_rd,
Rq_rd => RF_Rq_rd, W_data => sigMUX, Rp_data => sigRp, Rq_data => sigRq, clock => clock);

mux1 : MUX port map (A => sigALU, B => R_data, C => RF_W_data, D => sigD, s => RF_s, E => sigMUX);

ula : ULA16bits port map (A => sigRp, B => sigRq, S => alu_s, X => sigALU, x0 => RF_Rp_zero);


end estrutura;