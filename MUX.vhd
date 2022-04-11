library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MUX is 
  port ( A, B, C, D: in std_logic_vector (15 downto 0);
         s: in std_logic_vector (1 downto 0);
			E: out std_logic_vector (15 downto 0)
        
  
  );
 end MUX;
 
 architecture estrutura of MUX is 
 
   begin 
	
	process (s, A, B, C, D)
	begin
	
	   if (s = "00") then E <= A;
		elsif (s = "01") then E <= B;
		elsif (s = "10") then E <= C;
	   else E <= D;
	
	   end if;
	end process;
	
end estrutura;
	