library	ieee;
use ieee.std_logic_1164.all;

entity comb_logic is
	port (
		A_BUS, B_BUS: in std_logic_vector(15 downto 0);
		CTRL		: in std_logic_vector(3 downto 0);
		RES			: out std_logic_vector(15 downto 0)
		);
end entity;

architecture rtl of comb_logic is
begin
	
	-- TODO
	
end architecture;
