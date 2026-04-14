library	ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_TB is
end entity;

architecture rtl of register_TB is	 

signal Clk	  :  std_logic;
signal Rst	  :  std_logic;
signal En	  :  std_logic;
signal Ra	  :  std_logic_vector  (3 downto 0);
signal Rb     :  std_logic_vector  (3 downto 0);
signal Rd	  :  std_logic_vector  (3 downto 0);
signal RES	  :  std_logic_vector (15 downto 0);
signal SRCa   :  std_logic_vector (15 downto 0);
signal SRCb	  :  std_logic_vector (15 downto 0);
			 
begin  
	
	DUT: entity register_file
		port map(
			Clk  => Clk,
			Rst  => Rst,
			En   => En,
			Ra   => Ra,
			Rb   => Rb,
			Rd   => Rd,
			RES  => RES,
			SRCa => SRCa,
			SRCb => SRCb
		);	 
		
		Clk_Process: process
		begin		
			Clk <= '0';
			wait for 5 ns;
			Clk <= '1';
			wait for 5 ns;
		end process;	
		
		--TB
		process 
		begin	
			-- Initial values
   
			En  <= '0';
    
			Rst <= '0';
    
			Ra  <= "0000";
   
			Rb  <= "0000";
   
			Rd  <= "0000";
   
			RES <= x"0000";	
			
			--Step_1 : Writing_Operation => Writing in register(1)  
			En  <= '1';
			Rd  <= "0001"; 
			RES <= x"000A";	 
			wait until rising_edge(Clk);
			
			--Step_2 : Writing_Operation => Writing in register(5) 
			En  <= '1';
			Rd  <= "0101"; 
			RES <= x"00A0";	
			wait until rising_edge(Clk); 
			
			--Step_3 : Read_Operation => Read from register(1) & register(5)
			Rst  <= '0';
			Ra  <= "0001";  
			Rb  <= "0101"; 
			wait until rising_edge(Clk); 
			
			--Step_4 : Stop_Operation
			En <= '0';
			wait until rising_edge(Clk); 
			
			--Step_5 : Writing_Operation =>  Writing in register(2)
			En  <= '1';
			Rd  <= "0010"; 	 
			RES <= x"0A00";	
			wait until rising_edge(Clk); 
			
			--Step_6 : Writing_Operation =>	 Writing in register(10)
			En  <= '1';
			Rd  <= "1010"; 
			RES <= x"A000";
			wait until rising_edge(Clk); 
			
			--Step_7 : Read_Operation  => Read from register(2) & register(10)
			Rst  <= '0';
			Ra  <= "0010";  
			Rb  <= "1010";  
			wait until rising_edge(Clk); 
			
			--Step_8 : Stop_Operation
			En <= '0'; 
			wait until rising_edge(Clk); 
			
			--Step_9 : Writing_Operation => Writing in register (15)  
			En  <= '1';
			Rd  <= "1111"; 
			RES <= x"0A0A";	
			wait until rising_edge(Clk); 
			 
			wait;
		end process;		

end architecture rtl;
