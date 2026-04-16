library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity co_processor is
    port (
        clk		: in std_logic;
        rst    	: in std_logic;
        CTRL   	: in std_logic_vector(3 downto 0);
        Ra     	: in std_logic_vector(3 downto 0);
        Rb     	: in std_logic_vector(3 downto 0);
        Rd     	: in std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of co_processor is

    component register_file is
        port (
            clk		: in  std_logic;
            reset   : in  std_logic;
            en		: in  std_logic;
            RES    	: in  std_logic_vector(15 downto 0);
            Ra     	: in  std_logic_vector(3 downto 0);
            Rb     	: in  std_logic_vector(3 downto 0);
            Rd     	: in  std_logic_vector(3 downto 0);
            SRCa   	: out std_logic_vector(15 downto 0);
            SRCb   	: out std_logic_vector(15 downto 0)
        );
    end component;

    component CLU is
        port (
            A_BUS  	: in  std_logic_vector(15 downto 0);
            B_BUS  	: in  std_logic_vector(15 downto 0);
            CTRL   	: in  std_logic_vector(3 downto 0);
            RESULT 	: out std_logic_vector(15 downto 0)
        );
    end component;

    signal write_en	: std_logic;
    signal src_a    : std_logic_vector(15 downto 0);
    signal src_b    : std_logic_vector(15 downto 0);
    signal result   : std_logic_vector(15 downto 0);
    signal ctrl_reg	: std_logic_vector(3 downto 0);
    signal rd_reg   : std_logic_vector(3 downto 0);

begin

    -- TODO: port map register_file	
	register_16x16: register_file port map (
        clk   => clk, 
        reset => rst, 
        en    => write_en, 
        RES   => result, 
        Ra    => Ra, 
        Rb    => Rb, 
        Rd    => rd_reg, 
        SRCa  => src_a, 
        SRCb  => src_b
    );
    -- TODO: port map structural_VHDL
	combinational_logic: CLU port map (
        A_BUS  => src_a,
        B_BUS  => src_b, 
        CTRL   => ctrl_reg, 
        RESULT => result
    );
    -- TODO: input register process (latch CTRL and Rd on clock edge)  
	process(clk, rst)
	begin
		if (rst = '1') then
			ctrl_reg <= (others => '0');
			rd_reg 	 <= (others => '0'); 	
		elsif (rising_edge(clk)) then
			ctrl_reg <= CTRL;
			rd_reg 	 <= Rd;
		end if;
	end process;
    -- TODO: write_en logic (disable on NOP) 
	with ctrl_reg select
		write_en <= '0' when "0111",
					'1' when others;

end architecture rtl;