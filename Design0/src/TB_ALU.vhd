library	ieee;
use ieee.std_logic_1164.all;

entity TB_ALU is
end entity;

architecture sim of TB_ALU is

signal A_BUS_TB: std_logic_vector(15 downto 0);
signal B_BUS_TB: std_logic_vector(15 downto 0);
signal ALU_OUT_TB: std_logic_vector(15 downto 0);
signal ALU_CTRL_TB: std_logic_vector(3 downto 0) := "0000";

begin
	DUT: entity	ALU
		port map(A_BUS => A_BUS_TB, B_BUS => B_BUS_TB, ALU_OUT => ALu_OUT_TB, ALU_CTRL => ALU_CTRL_TB);
		
	process is
	begin
		A_BUS_TB <= x"0003";
		B_BUS_TB <= x"0001";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0001";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0010";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0011";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0100";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0101";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0110";
		wait for 10 ns;
		
		ALU_CTRL_TB <= "0111";
		
	end process;
	
end architecture;
