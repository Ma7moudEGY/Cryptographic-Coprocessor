library IEEE;
use IEEE.std_logic_1164.all;

entity comb_logic_TB is
end entity;

architecture sum of comb_logic_TB is 
    signal A_BUS_TB: std_logic_vector(15 downto 0) := (others => '0');
    signal B_BUS_TB: std_logic_vector(15 downto 0) := (others => '0');
    signal CTRL_TB: std_logic_vector(3 downto 0)  := (others => '0');
    signal RES_TB: std_logic_vector(15 downto 0);

begin  		  
    UUT: entity comb_logic
        port map(
            A_BUS  => A_BUS_TB, 
            B_BUS  => B_BUS_TB, 
            CTRL   => CTRL_TB, 
            RES => RES_TB
        );
        
    process
    begin  		 
        A_BUS_TB <= x"0005"; 
        B_BUS_TB <= x"000E"; 
        CTRL_TB  <= "0000";   -- A+B
        wait for 10 ns;	
		
		CTRL_TB <= "0001";	  -- A-B
		wait for 10 ns;
		
		CTRL_TB <= "0010";	  -- A&B
		wait for 10 ns;
		
		CTRL_TB <= "0011";	  -- A|B
		wait for 10 ns;
		
		CTRL_TB <= "0100";	  -- A^B
		wait for 10 ns;
		
		CTRL_TB <= "0101";	  -- !A
		wait for 10 ns;
		
		CTRL_TB <= "0110";	  -- A
		wait for 10 ns;
		
		CTRL_TB <= "0111";	  -- nop
		wait for 10 ns;
        
        --B_BUS_TB <= x"ABCD"; 
        CTRL_TB  <= "1000";   -- ROR8
        wait for 10 ns;
		
		CTRL_TB  <= "1001";   -- ROR4
        wait for 10 ns;
		
		CTRL_TB  <= "1010";   -- SLL8
        wait for 10 ns;
        
        --A_BUS_TB <= x"FF01"; 				   			   
        CTRL_TB  <= "1011";   -- LUT
        wait for 10 ns;	
		
		CTRL_TB  <= "1100";   -- x"0000"
        wait for 10 ns;
        
        wait;
    end process;    
        
end architecture;