library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MD is 
   port ( addr: in std_logic_vector (7 downto 0);
          rd, wr, clk: in std_logic;
          W_data: in std_logic_vector (15 downto 0);
          R_data: out std_logic_vector (15 downto 0)


   );
end MD;

architecture estrutura of MD is

   type matrizdados is array (0 to 255) of std_logic_vector (15 downto 0); --vetor de vetores
   signal dados: matrizdados := 
   (
    0 => "0000000000000101", -- 5
    1 => "0000000000000111", -- 7
    2 => "0000000000001000", -- 8
    3 => "0000000000000001", -- 1
    4 => "0000000000000100", -- 4
    5 => "0000000000000101", -- 5
    6 => "0000000000000110", -- 6
    7 => "0000000000000011", -- 3
    8 => "0000000000001000", -- 8
    9 => "0000000000000001", -- 1
    10 => "0000000000001001", -- 9
    11 => "0000000000000101", -- 1
    12 => "0000000000000010", -- 2
    13 => "0000000000000100", -- 4
    14 => "0000000000000001", -- 1
    15 => "0000000000000011", -- 3
    16 => "0000000000000101", -- 5
    17 => "0000000000000110", -- 6
    18 => "0000000000001001", -- 9
    19 => "0000000000000100", -- 4
    20 => "0000000000000011", -- 3

    others =>"0000000000000000");

begin
    process (clk, addr, rd, wr, W_data)
        begin
                 if rising_edge(clk) then
						if (wr = '1') then
                    dados (to_integer(unsigned(addr))) <= W_data; 
						end if;
					  end if;
						if	(rd = '1') then
                    R_data <= dados (to_integer(unsigned(addr)));
						else
						  R_data <= "ZZZZZZZZZZZZZZZZ";
						end if;
               
    end process;

end estrutura;