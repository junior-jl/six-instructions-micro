library ieee;
use ieee.std_logic_1164.all;

	entity FSM1 is port 

(      IR: in std_logic_vector (15 downto 0);
       clock, reset, RF_Rp_zero: in std_logic;
		 RF_W_addr, RF_Rp_addr, RF_Rq_addr: out std_logic_vector (3 downto 0);
		 RF_W_wr, RF_Rp_rd, RF_Rq_rd: out std_logic;
		 alu_s, RF_s: out std_logic_vector (1 downto 0);
		 RF_W_data: out std_logic_vector (15 downto 0);
		 D_addr: out std_logic_vector (7 downto 0);
		 D_rd, D_wr: out std_logic;
		 PC_ld, PC_clr, PC_inc: out std_logic; 
		 I_rd: out std_logic;
		 IR_ld: out std_logic;
		 LED: out std_logic_vector (7 downto 0)
);

end FSM1;

architecture estrutura of FSM1 is 

    type est is 
	 (inicio, busca, decodificar, carregar, armazenar, somar, carregarc, subtrair, saltar0, saltar);
	 
    signal atual, proximo: est; 
	 
begin

    process (clock, reset, atual, proximo, IR, RF_Rp_zero)
	 begin 
	      if (reset = '0') then
			    atual <= inicio;
		   elsif (rising_edge(clock)) then
			    atual <= proximo;
		   end if;
		
	      case atual is 
				when inicio => 
				
				PC_clr <= '1';
				D_rd <= '0';
				D_wr <= '0';
				RF_W_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				RF_s <= "00";
				I_rd <= '0';
				
				RF_W_addr <= "ZZZZ";
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				
				proximo <= busca;
				LED <= "00000000";
				
				
				when busca => 
				
				PC_clr <= '0';
				I_rd <= '1';
				PC_inc <= '1';
				IR_ld <= '1';
				D_rd <= '0';
				D_wr <= '0';
				RF_W_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				RF_s <= "00";
				
			
				
				RF_W_addr <= "ZZZZ";
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				
				proximo <= decodificar;
				LED <= "00000001";
				
				when decodificar =>
				
				I_rd <= '0';
				PC_inc <= '0';
				IR_ld <= '0';
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				RF_W_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				RF_s <= "00";
				
				RF_W_addr <= "ZZZZ";
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				
				
				if (IR(15 downto 12) = "0000") then 
				    proximo <= carregar;
				elsif (IR(15 downto 12) = "0001") then 
				    proximo <= armazenar;
			   elsif (IR(15 downto 12) = "0010") then 
				    proximo <= somar;
				elsif (IR(15 downto 12) = "0011") then 
				    proximo <= carregarc;
				elsif (IR(15 downto 12) = "0100") then 
				    proximo <= subtrair;
				elsif (IR(15 downto 12) = "0101") then 
				    proximo <= saltar0;
				else proximo <= busca;
					 
				end if; 
				
				LED <= "00000010";
				
				-- IR(7 downto 0) = d
				-- IR(11 downto 8) = ra
				-- IR(7 downto 4) = rb
				-- IR(3 downto 0) = rc
				
				when carregar => 
				
				D_addr <= IR (7 downto 0);
				D_rd <= '1';
				RF_s <= "01";
				RF_W_addr <= IR(11 downto 8);
				RF_W_wr <= '1';
				
				I_rd <= '0';
				
				PC_clr <= '0';
				D_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
			
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00000011";
				
				when armazenar =>
				
				D_addr <= IR (7 downto 0);
				D_wr <= '1';
				RF_s <= "ZZ";
				RF_Rp_addr <= IR(11 downto 8);
				RF_Rp_rd <= '1';
				
				PC_clr <= '0';
				D_rd <= '0';
				RF_W_wr <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				I_rd <= '0';
				
				RF_W_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00000100";
				
				when somar => 

            RF_Rp_addr <= IR(7 downto 4);
				RF_Rp_rd <= '1'; 
				RF_s <= "00";
				RF_Rq_addr <= IR(3 downto 0);
				RF_Rq_rd <= '1';
				RF_W_addr <= IR(11 downto 8);
				RF_W_wr <= '1';
				alu_s <= "01"; 
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				PC_ld <= '0';
				I_rd <= '0';
				
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00000101";
				
				when carregarc =>
				
				RF_W_data(15 downto 8) <= "00000000";
				RF_W_data(7 downto 0) <= IR(7 downto 0);
				RF_s <= "10";
				RF_W_addr <= IR(11 downto 8);
				RF_W_wr <= '1';
				
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				I_rd <= '0';
				
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00000110";
				
				when subtrair => 
				
				RF_Rp_addr <= IR(7 downto 4);
				RF_Rp_rd <= '1'; 
				RF_s <= "00";
				RF_Rq_addr <= IR(3 downto 0);
				RF_Rq_rd <= '1';
				RF_W_addr <= IR(11 downto 8);
				RF_W_wr <= '1';
				alu_s <= "10"; 
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				PC_ld <= '0';
				I_rd <= '0';
				
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00000111";	 
			
			   when saltar0 => 
				
				RF_Rp_addr <= IR(11 downto 8);
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '0';
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				RF_W_wr <= '0';
				PC_ld <= '0';
				alu_s <= "00";
				RF_s <= "00";
				I_rd <= '0';
				
				RF_W_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				if (RF_Rp_zero = '1') then 
				proximo <= saltar;
				else 
				proximo <= busca;
				end if; 
				
				LED <= "00001000";
				
				when saltar => 
				
				PC_ld <= '1';
				
				PC_clr <= '0';
				D_rd <= '0';
				D_wr <= '0';
				RF_W_wr <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s <= "00";
				RF_s <= "00";
				I_rd <= '0';
				
				RF_W_addr <= "ZZZZ";
				RF_Rp_addr <= "ZZZZ";
				RF_Rq_addr <= "ZZZZ";
				RF_W_data <= "ZZZZZZZZZZZZZZZZ"; 
				D_addr <= "ZZZZZZZZ";
				PC_inc <= '0';
				IR_ld <= '0';
				
				proximo <= busca;
				LED <= "00001001";
				
			end case; 
	end process;
end estrutura;
				
				
				
				