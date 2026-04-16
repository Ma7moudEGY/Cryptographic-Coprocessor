library	ieee;
use ieee.std_logic_1164.all;

entity N_bit_adder is
	generic	(
		N: natural := 32
	);
	port (
		IN_1, IN_2	: in std_logic_vector(N-1 downto 0);
		res			: out std_logic_vector(N-1 downto 0);
		carry_out	: out std_logic
		);
end entity;

architecture rtl of N_bit_adder is

component half_adder is
	port (
		x, y 	: in std_logic;
		s, cout : out std_logic
        );
end component;

component full_adder is
	port (
		x, y, cin 	: in std_logic;
		s, cout 	: out std_logic
        );
end component;
	
signal carry : std_logic_vector(N-1 downto 0);
	
begin
	gen_adders: for i in 0 to N-1 generate
		begin
			h_adder: if i = 0 generate
				ha: half_adder
				port map (x => IN_1(0), y => IN_2(0), s => res(0), cout => carry(0));
			end generate;
			
			f_adder: if i > 0 generate
				fa: full_adder
				port map(x => IN_1(i), y => IN_2(i), cin => carry(i - 1), s => res(i), cout => carry(i));
			end generate;
		end generate;
		
	carry_out <= carry(N-1);		
end architecture;