library	ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port (
	A_BUS, B_BUS: in std_logic_vector(15 downto 0);
	ALU_CTRL	: in std_logic_vector(3 downto 0);
	ALU_OUT		: out std_logic_vector(15 downto 0)
	);
	
end entity;

architecture rtl of ALU is
begin

	-- TODO
	
end architecture;
