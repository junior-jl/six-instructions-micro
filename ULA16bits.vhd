library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all; 

entity ULA16bits is port  

(    A, B : in  std_logic_vector(15 downto 0); 
     S    : in  std_logic_vector (1 downto 0); 
     X    : out std_logic_vector (15 downto 0); 
	  x0   : out std_logic 
);

end ULA16bits; 

architecture estrutura of ULA16bits is 

begin 

process (A, B, S) 
begin 

	  if (A=0) then  
			x0 <= '1'; 
	  else 
	      x0 <= '0'; 
			
	  end if;

     case S is -- código que indica execução condicional;
	  when "00" => X <= A;  -- 00, manda A para a saída X;
	  when "01" => X <= A + B;  -- 01, realiza a operação de soma das entradas A e B e manda para a saida X;
	  when "10" => X <= A - B; -- 10, realiza a operação de subtração das entradas A e B e manda para a saida X;
	  when others => X <= "ZZZZZZZZZZZZZZZZ";  
	  
	  end case; -- fim da condição;
end process; -- fim do bloco de processamento;
end estrutura; -- fim do bloco de arquitetura. 