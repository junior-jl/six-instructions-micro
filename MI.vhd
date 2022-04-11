library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity MI is 

	generic
	(
		MIN_COUNT : natural := 0;
		MAX_COUNT : natural := 255
	);
	
   port ( addr: in integer range MIN_COUNT to MAX_COUNT;
          rd: in std_logic;
          data: out std_logic_vector (15 downto 0)

   );
end MI;

architecture estrutura of MI is 

   type matrizinst is array (0 to 255) of std_logic_vector (15 downto 0); --vetor de vetores
   signal inst: matrizinst :=
	
	(
		0 => "0011000000000011", -- carregar cte 3 em RF[0] (valor analisado)
		1 => "0011000100000001", -- carregar cte 1 em RF[1] (incremento)
		2 => "0011001000000000", -- carregar cte 0 em RF[2] (usado no saltar se zero)
		3 => "0011001100000000", -- carregar cte 0 em RF[3] (contador)
		4 => "0000010000001100", -- carregar D[12] em RF[4]
		5 => "0100111101000000", -- subtrair RF[4] - RF[0] => RF[15]
		6 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+6]
		7 => "0000010100001101", -- carregar D[13] em RF[5]
		8 => "0100111101010000", -- subtrair RF[5] - RF[0] => RF[15]
		9 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+9]
		10 => "0000011000001110",-- carregar D[14] em RF[6]
		11 => "0100111101100000", -- subtrair RF[6] - RF[0] => RF[15]
		12 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+12]
		13 => "0000011100001111", -- carregar D[15] em RF[7]
		14 => "0100111101110000", -- subtrair RF[7] - RF[0] => RF[15]
		15 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+15]
		16 => "0000100000010000", -- carregar D[16] em RF[8]
		17 => "0100111110000000", -- subtrair RF[8] - RF[0] => RF[15]
		18 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+18]
		19 => "0000100100010001", -- carregar D[17] em RF[9]
		20 => "0100111110010000", -- subtrair RF[9] - RF[0] => RF[15]
		21 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+21]
		22 => "0000101000010010", -- carregar D[18] em RF[10]
		23 => "0100111110100000", -- subtrair RF[10] - RF[0] => RF[15]
		24 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+24]
		25 => "0000101100010011", -- carregar D[19] em RF[11]
		26 => "0100111110110000", -- subtrair RF[11] - RF[0] => RF[15]
		27 => "0101111100110010", -- saltar se RF[15] for 0 => inst[50+27]
		28 => "0101001011100010", -- saltar se RF[2] for 0 => inst[226+28]

--29 to 55 => "XXXXXXXXXXXXXXXX",

		56 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		57 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--58 => "XXXXXXXXXXXXXXXX",

		59 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		60 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--61 => "XXXXXXXXXXXXXXXX",

		62 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		63 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--64 => "XXXXXXXXXXXXXXXX",

		65 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		66 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--67 => "XXXXXXXXXXXXXXXX",

		68 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		69 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--70 => "XXXXXXXXXXXXXXXX",

		71 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		72 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--73 => "XXXXXXXXXXXXXXXX",

		74 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		75 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--76 => "XXXXXXXXXXXXXXXX",

		77 => "0010001100110001", -- somar RF[3] + RF[1] => RF[3]
		78 => "0101001011001110", -- saltar se RF[2] for 0 => -50

--79 to 253 => "XXXXXXXXXXXXXXXX",

		255 => "XXXXXXXXXXXXXXXX",

		others => "0000000000000000");


begin 
	data <= inst(addr) when rd = '1' else "ZZZZZZZZZZZZZZZZ";  
				
end estrutura;

--- INSTRUÇÕES
--- CARREGAR: 0000 R3R2R1R0 D7D6D5D4D3D2D1D0
--- ARMAZENAR: 0001 R3R2R1R0 D7D6D5D4D3D2D1D0
--- SOMAR: 0010 RA3RA2RA1RA0 RB3RB2RB1RB0 RC3RC2RC1RC0
--- CARREGAR CONSTANTE: 0011 R3R2R1R0 C7C6C5C4C3C2C1C0
--- SUBTRAIR: 0100 RA3RA2RA1RA0 RB3RB2RB1RB0 RC3RC2RC1RC0
--- SALTAR SE ZERO: 0101 RA3RA2RA1RA0 O7O6O5O4O3O2O1O0
