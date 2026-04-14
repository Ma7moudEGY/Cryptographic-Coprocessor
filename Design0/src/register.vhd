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
signal REG_FILE : reg_array := (others => (others => '0'));
	
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
