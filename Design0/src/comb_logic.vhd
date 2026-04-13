library ieee;
use ieee.std_logic_1164.all;

entity comb_logic is
    port (
        A_BUS, B_BUS : in std_logic_vector(15 downto 0);
        CTRL         : in std_logic_vector(3 downto 0);
        RES          : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of comb_logic is

    -- 1.  ⁄—Ì› «·‹ Components (ﬁ»· «·‹ begin)
    component non_linear_lookup is
        port (
            LUT_IN  : in std_logic_vector(7 downto 0);
            LUT_OUT : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component shifter is
        generic ( N : integer := 16 );
        port (
            SHIFT_INPUT : in  std_logic_vector(N-1 downto 0);
            SHIFT_Ctrl  : in  std_logic_vector(3 downto 0); 
            SHIFT_OUT   : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    component ALU is
        port (
            A_BUS    : in std_logic_vector(15 downto 0);
            B_BUS    : in std_logic_vector(15 downto 0);
            ALU_CTRL : in std_logic_vector(3 downto 0);
            ALU_OUT  : out std_logic_vector(15 downto 0)
        );
    end component;  

    -- 2.  ⁄—Ì› «·√”·«ﬂ «·œ«Œ·Ì… (Signals)
    signal out1_LUT : std_logic_vector(15 downto 0);
    signal out2_ALU : std_logic_vector(15 downto 0);
    signal out3_shf : std_logic_vector(15 downto 0);
    signal LUT_out_sig : std_logic_vector(7 downto 0); -- ”·ﬂ ··‹ 8 »  » Ê⁄ «·‹ LUT

begin   

    LUT_unit: non_linear_lookup
    port map(
        LUT_IN  => A_BUS(7 downto 0), -- ·«“„ ‰Õœœ «·‹ 8 » 
        LUT_OUT => LUT_out_sig
    );
    
    --  Ã„Ì⁄ «·‹ 16 »  » Ê⁄ «·‹ LUT
    out1_LUT <= A_BUS(15 downto 8) & LUT_out_sig;
    
    SHIFT_unit: shifter
    generic map ( N => 16 )
    port map(
        SHIFT_INPUT => B_BUS,
        SHIFT_Ctrl  => CTRL,
        SHIFT_OUT   => out3_shf
    );
    
    ALU_unit: ALU 
    port map(
        A_BUS    => A_BUS,
        B_BUS    => B_BUS,
        ALU_CTRL => CTRL,
        ALU_OUT  => out2_ALU
    );   
    
    control_logic: process(CTRL, out1_LUT, out2_ALU, out3_shf) is
    begin
        case CTRL(3 downto 3) is
            when "0" => 
                RES <= out2_ALU;
            when others => 
                case CTRL(1 downto 0) is
                    when "11" =>
                        RES <= out1_LUT;
                    when others =>
                        RES <= out3_shf; -- ﬂ«‰ „ﬂ Ê» out2_shf ÊÂÌ „‘ „ÊÃÊœ…
                end case;
        end case;
    end process control_logic;

end architecture;