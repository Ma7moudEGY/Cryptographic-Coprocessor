library	ieee;
use ieee.std_logic_1164.all;

entity N_bit_adder is
	generic	(
		N: natural := 32
	);
	port (
		IN_1, IN_2	: in std_logic_vector(N-1 downto 0);
		res			: out std_logic_vector(N-1 downto 0);
		cout		: out std_logic
		);
end entity;

architecture rtl of N_bit_adder is
begin
	
	-- TODO
	
end architecture;