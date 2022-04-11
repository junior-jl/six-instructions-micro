library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BANCOREG is 
   port ( W_addr, Rp_addr, Rq_addr : in std_logic_vector (3 downto 0);
			 clock, W_wr, Rp_rd, Rq_rd : in std_logic;
			 W_data : in std_logic_vector (15 downto 0);
			 Rp_data, Rq_data : out std_logic_vector (15 downto 0)
	
	);
	
end BANCOREG;

architecture estrutura of BANCOREG is

	type banco is array (0 to 15) of std_logic_vector (15 downto 0);
	signal breg: banco := (
	
		
		others => "0000000000000000"
	
	);
	

begin
	
		process(clock)
			begin
		
				if(rising_edge(clock) and W_wr = '1') then
						breg(to_integer(unsigned(W_addr))) <= W_data;
				end if;
	
		end process;

	Rp_data <= breg(to_integer(unsigned(Rp_addr))) when Rp_rd = '1' else "ZZZZZZZZZZZZZZZZ";
	Rq_data <= breg(to_integer(unsigned(Rq_addr))) when Rq_rd = '1' else "ZZZZZZZZZZZZZZZZ";
		
			
	
end estrutura; 
