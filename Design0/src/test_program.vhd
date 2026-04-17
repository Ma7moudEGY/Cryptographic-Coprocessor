library	ieee;
use ieee.std_logic_1164.all; 

entity test_program is
end entity;

architecture behaviour of test_program is

	component co_processor
    port(
         clk  : in  std_logic;
         rst  : in  std_logic;
         CTRL : in  std_logic_vector(3 downto 0);
         Ra   : in  std_logic_vector(3 downto 0);
         Rb   : in  std_logic_vector(3 downto 0);
         Rd   : in  std_logic_vector(3 downto 0)
        );
    end component;
	
	signal clk 	: std_logic := '0';
    signal rst 	: std_logic := '0';
    signal CTRL : std_logic_vector(3 downto 0);
    signal Ra 	: std_logic_vector(3 downto 0);
    signal Rb 	: std_logic_vector(3 downto 0);
    signal Rd 	: std_logic_vector(3 downto 0);
	constant clock_period : time := 50 ns;
	
	begin
		coprocessor: co_processor
		port map (clk  => clk,
			      rst  => rst,
				  CTRL => CTRL,
                  Ra   => Ra,
				  Rb   => Rb,
				  Rd   => Rd
				);
				
	clk <= not clk after clock_period / 2;
					   
    stim_proc: process
    begin  
		-- 1. Test MOV 
        Ra   <= "0000";
        Rb   <= "0001";
        Rd   <= "0010";
        CTRL <= "0110";
        wait for clock_period; 
        
        rst  <= '0';
		wait for clock_period;
        
        --- 2. Test ALU Op => AND R2, R15, R14
        Ra   <= "1111"; -- 15
        Rb   <= "1110"; -- 14
        Rd   <= "0010"; -- 2
        CTRL <= "0010";
        wait for clock_period;
        
        --- 3. Test ALU Op: OR R5, R2, R3
        Ra   <= "0010"; -- 2 
        Rb   <= "0011"; -- 3
        Rd   <= "0101"; -- 5
        CTRL <= "0011";
        wait for clock_period;
        
        --- 4. Test NOP: Ensure write_en safely disables
        Ra   <= "1111"; 
        Rb   <= "1111";
        Rd   <= "1111";
        CTRL <= "0111"; -- NOP
        wait for clock_period;    
        
        --- 5. Test ROR8 
        Ra   <= "1101"; -- Igonred 
        Rb   <= "0000";
        Rd   <= "0111"; -- 7
        CTRL <= "1000";
        wait for clock_period;
        
        --- ADD R10, R0, R7 
        Ra 	 <= "0000"; 
        Rb 	 <= "0111";
        Rd 	 <= "1010";
        CTRL <= "0000";
        wait for clock_period;
        
        --- 6. Test Arithmetic: SUB R1, R7, R5
        Ra   <= "0111"; -- 7 
        Rb   <= "0101"; -- 5
        Rd   <= "0001"; -- 1
        CTRL <= "0001";
        wait for clock_period;
        
        --- 7. Test Logic: NOT A_BUS R10, R1, R1
        Ra   <= "0001"; -- 1 
        Rb   <= "0100"; -- 1
        Rd   <= "1010"; -- 10
        CTRL <= "0101";
        wait for clock_period;
        
        --- 8. Test No OPCODE Binded to 1100 -> OUTPUT should be 0.
        Ra   <= "1010"; -- Ignored 
        Rb   <= "0000"; -- Ignored 
        Rd   <= "1011"; -- 11
        CTRL <= "1100";  
        wait for clock_period;
		
		CTRL <= "0111";
		
        wait;
    end process;

end architecture behaviour;