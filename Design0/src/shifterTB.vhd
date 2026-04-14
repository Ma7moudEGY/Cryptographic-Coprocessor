library	ieee;
use ieee.std_logic_1164.all;

entity shifterTB is

end entity;

architecture struct of shifterTB is
 signal SHIFT_INPUT : std_logic_vector(15 downto 0) := x"0000";
 signal SHIFT_Ctrl : std_logic_vector(3 downto 0) := "0000";
 
 signal SHIFT_OUT : std_logic_vector(15 downto 0);

begin
G1:entity shifter
	port map(
	SHIFT_INPUT => SHIFT_INPUT,
	SHIFT_Ctrl => SHIFT_Ctrl,
	SHIFT_OUT => SHIFT_OUT
	);	
	
sim_process: process
   begin  
      SHIFT_INPUT <= x"1144";
      wait for 20 ns; 
  SHIFT_Ctrl <= "1000";-- ROR8
  wait for 20 ns; 
  SHIFT_Ctrl <= "1001";-- ROR4
  wait for 20 ns; 
  SHIFT_Ctrl <= "1010";-- SLL8
  wait for 20 ns; 
  SHIFT_Ctrl <= "1111";-- unknown
      wait;
   end process;	
	
	
end architecture;
	