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
component N_bit_adder is
	generic	(
		N: integer := 16
		);	
	port (
		IN_1, IN_2	: in std_logic_vector(N-1 downto 0);
		res			: out std_logic_vector(N-1 downto 0)
		);
		
	end component;
		
signal NOT_B_BUS: std_logic_vector(15 downto 0);
signal temp_out1, temp_out2, temp: std_logic_vector(15 downto 0);

begin
	adder_1: N_bit_adder
	generic map (N => 16)
	port map (IN_1 => A_BUS, IN_2 => B_BUS, res => temp_out1);
	
	adder_2: N_bit_adder
	generic map (N => 16)
	port map (IN_1 => A_BUS, IN_2 => NOT_B_BUS, res => temp_out2);
	
	adder_3: N_bit_adder
	generic map (N => 16)
	port map (IN_1 => temp_out2, IN_2 => x"0001", res => temp);
	
	NOT_B_BUS <= not B_BUS;
	
	process(ALU_CTRL, A_BUS, B_BUS, temp_out1, temp)
	begin
		case (ALU_CTRL) is
			when "0000" =>  ALU_OUT <= temp_out1;  -- ADD
			when "0001" =>  ALU_OUT <= temp ;-- SUB 
			when "0010" =>  ALU_OUT <= A_BUS and B_BUS; -- AND
			when "0011" =>  ALU_OUT <= A_BUS or B_BUS; -- OR
			when "0100" =>  ALU_OUT <= A_BUS xor B_BUS; -- XOR
			when "0101" =>  ALU_OUT <= not A_BUS; -- NOT
			when "0110" =>  ALU_OUT <= A_BUS; -- MOVE
			when others => 	ALU_OUT <= temp_out1; 
		end case;
	end process;
	
end architecture;
