library	ieee;
use ieee.std_logic_1164.all;

entity register_file is
	port (
		clk		: in std_logic;
		rst		: in std_logic;
		en		: in std_logic;
		RES		: in std_logic_vector(15 downto 0);
		Ra		: in std_logic_vector(3 downto 0);
		Rb		: in std_logic_vector(3 downto 0);
		Rd		: in std_logic_vector(3 downto 0);
		SRca	: out std_logic_vector(15 downto 0);
		SRcb	: out std_logic_vector (15 downto 0)
		);
end entity;

architecture rtl of register_file is

type reg_array is array(0 to 15) of std_logic_vector(15 downto 0);
signal REG_FILE : reg_array;
	
begin
	
	-- TODO: write process
	-- TODO: read process

end architecture rtl;
