library	ieee;
use ieee.std_logic_1164.all;

entity shifter is
	generic	(
		N: integer := 16
	);
	port (
		SHIFT_INPUT	: in std_logic_vector(N-1 downto 0);
		SHIFT_CTRL	: in std_logic_vector(3 downto 0);
		SHIFT_OUT	: out std_logic_vector(N-1 downto 0)
		);
end entity;

architecture rtl of shifter is
begin
	
<<<<<<< Updated upstream
	-- TODO
=======
SHIFT_OUT <= SHIFT_INPUT(7 downto 0)&SHIFT_INPUT(15 downto 8) when SHIFT_CTRL = "1000" else	--ROR8
			 SHIFT_INPUT(3 downto 0)&SHIFT_INPUT(15 downto 4) when SHIFT_CTRL = "1001" else	--ROR4
			 SHIFT_INPUT(7 downto 0)&"00000000" when SHIFT_CTRL = "1010" else
			 x"0000";	 
>>>>>>> Stashed changes
	
end architecture;
	