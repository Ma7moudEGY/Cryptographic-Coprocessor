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
	
	-- TODO
	
end architecture;
	