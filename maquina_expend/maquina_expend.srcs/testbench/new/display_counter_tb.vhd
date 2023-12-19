library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_DISPLAY_COUNTER is
end tb_DISPLAY_COUNTER;

architecture testbench of tb_DISPLAY_COUNTER is
    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- Adjust the clock period as needed

    -- Signals
    signal clk_tb      : std_logic := '0';
    signal coin_in_tb  : std_logic_vector(3 downto 0) := (others => '0');
    signal reset_tb    : std_logic := '0';
    signal ok_in_tb    : std_logic := '0';
    signal digsel_tb   : std_logic_vector(3 downto 0);
    signal segment_tb  : std_logic_vector(6 downto 0);
    signal count_tb    : std_logic_vector(6 downto 0);
    signal ok_out_tb   : std_logic;
    signal dp_tb       : std_logic;
    signal coin_aux_tb : std_logic_vector(3 downto 0);
    signal reset_aux_tb : std_logic;
    signal ok_aux_tb : std_logic;
    -- Instantiate the Design
    COMPONENT DISPLAY_COUNTER
        Port ( 
            clk         : in STD_LOGIC;
            coin_in     : in std_logic_vector(3 downto 0);
            reset       : in STD_LOGIC;
            ok_in       : in STD_LOGIC;
            digsel      : out STD_LOGIC_VECTOR (3 downto 0);
            segment_out : out STD_LOGIC_VECTOR (6 downto 0);
            count       : out STD_LOGIC_VECTOR (6 downto 0);
            ok_out      : out std_logic;
            DP          : out std_logic
        );
    end COMPONENT;
    -- Clock Process
    begin
    process
    begin
        wait for CLK_PERIOD / 2;
        clk_tb <= not clk_tb;
    end process;

    -- Stimulus Process
    process
    begin
        -- Initialize Inputs
        coin_in_tb <= "0000";
        reset_tb <= '0';
        ok_in_tb <= '0';

        wait for 10 ns;

        -- Apply Reset
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';

        -- Test 1: Display Number 42
        coin_in_tb <= "0100";  -- Simulate a coin insertion
        ok_in_tb <= '1';       -- Simulate pressing OK
        wait for 100 ns;
        ok_in_tb <= '0';

        -- Test 2: Display Number 99
        coin_in_tb <= "1001";  -- Simulate a coin insertion
        ok_in_tb <= '1';       -- Simulate pressing OK
        wait for 100 ns;
        ok_in_tb <= '0';

        -- Additional tests can be added here

        wait;
    end process;
    -- Connect the Design
        uut: DISPLAY_COUNTER port map (
            clk         => clk_tb,
            coin_in     => coin_aux_tb, -- Corrected signal name
            reset       => reset_aux_tb, -- Corrected signal name
            ok_in       => ok_aux_tb, -- Corrected signal name
            digsel      => digsel_tb,
            segment_out => segment_tb,
            count       => count_tb,
            ok_out      => ok_out_tb,
            DP          => dp_tb
        );
    end testbench;