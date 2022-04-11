-- Quartus II VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is

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

end entity;

architecture estrutura of PC is


begin

	
	process (clk, load, inc, clear, offset)
		variable cnt: integer range MIN_COUNT to MAX_COUNT;

	begin
		if (rising_edge(clk)) then

			if clear = '1' then
				-- Reset the counter to 0
				cnt := 0;
			
			elsif inc = '1' then
				-- Increment the counter if counting is enabled			   
				cnt := cnt + 1;

			elsif load = '1' then
				cnt := cnt + to_integer(signed(offset)) - 1;
			end if;
		end if;

		-- Output the current count
		pcOUT <= cnt;
	end process;

end estrutura;
