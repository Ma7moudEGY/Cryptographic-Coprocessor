library ieee;  
use ieee.std_logic_1164.all;
	 


  entity lockupTB is  
  end entity;
  
  architecture behavior of lockupTB is
  
  --signals
  signal LUT_IN,LUT_OUT: std_logic_vector(7 downto 0);
 
  begin
	  
	  
  -- component linkage 	  
  u: entity non_linear_lookup 
	 port map (
	   LUT_IN  => LUT_IN,
	   LUT_OUT => LUT_OUT
	   );
	   
	      

  -- Stimulus process
  process
  begin
        
        -- Test Cases
        LUT_IN <= "00000000"; 
        wait for 10 ns;

        
        LUT_IN <= "00010001";
        wait for 10 ns;

        
        LUT_IN <= "10101010";
        wait for 10 ns;

        
        LUT_IN <= "11111111";
        wait for 10 ns;

        
        LUT_IN <= "01010101";
        wait;
		
		
		
 end process;
 

end; 

	  
	  