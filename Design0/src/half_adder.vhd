library	ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	port (
		x, y	: in std_logic;
		s, cout	: out std_logic
		);
end entity;

architecture rtl of half_adder is
begin
	
	s <= x xor y;
	cout <= x and y;
	
end architecture;
