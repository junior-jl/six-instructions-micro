library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IR is port 

(      instIN: in std_logic_vector (15 downto 0);
		 load, clk: in std_logic;
		 instOUT: out std_logic_vector (15 downto 0)
		 
		 
);

end IR;

architecture estrutura of IR is 

begin

 process (clk)
	 begin 
	     if (rising_edge (clk)) then
	
				if (load = '1') then
		         instOUT <= instIN;
		      end if; 
		 end if;
	end process; 


end estrutura; 
