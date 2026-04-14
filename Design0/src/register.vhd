library	ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port (
		Clk		: in  std_logic;
		Rst		: in  std_logic;
		En		: in  std_logic;
		Ra		: in  std_logic_vector  (3 downto 0);
		Rb		: in  std_logic_vector  (3 downto 0);
		Rd		: in  std_logic_vector  (3 downto 0);
		RES		: in  std_logic_vector (15 downto 0);
		SRCa	: out std_logic_vector (15 downto 0);
		SRCb    : out std_logic_vector (15 downto 0)
	);
end entity;

architecture rtl of register_file is

--Declaration & Initialization Register_Files
type reg_array is array(0 to 15) of std_logic_vector(15 downto 0);
signal REG_FILE : reg_array := (
	0 		=> x"0005",
	1 		=> x"C404",
	2 		=> x"9D22",
	3 		=> x"1A50",
	4 		=> x"1234",
	5 		=> x"9876",
	6 		=> x"ABCD",
	7 		=> x"EF12",
	8 		=> x"1AB2",
	9 		=> x"9501",
	10		=> x"FF00",
	11		=> x"5500",
	12		=> x"DFDF",
	13		=> x"01CC",
	14		=> x"54BA",
	15		=> x"C000",
	others 	=> (others => '0')
);
	
begin 
	
	--Write_Operation
	write_process: process(Clk)
	begin
		if(rising_edge(Clk)) then  
			if (En = '1')then 	  -- Write when En = '1'
				REG_FILE(to_integer(unsigned(Rd))) <= RES;	
			end if;	
		end if;	
	end process;
	
	--Read_Operation
	read_process: process(Clk)
	begin
		if(rising_edge(Clk)) then  
			if(Rst = '1') then    
				SRCa <= x"0000";
				SRCb <= x"0000";
			else 
				SRCa <= REG_FILE(to_integer(unsigned(Ra)));	
				SRCb <= REG_FILE(to_integer(unsigned(Rb)));
			end if;
		end if;	
	end process;

end architecture rtl;
