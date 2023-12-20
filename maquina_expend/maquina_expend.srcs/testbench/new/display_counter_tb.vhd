library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DISPLAY_COUNTER_tb is
end DISPLAY_COUNTER_tb;

architecture tb_arch of DISPLAY_COUNTER_tb is
    signal clk_tb: std_logic := '0';
    signal reset_tb: std_logic := '0';
    signal coin_in_tb: std_logic_vector(3 downto 0) := "0000";
    signal ok_in_tb: std_logic := '0';

    signal digsel_tb: std_logic_vector(7 downto 0);
    signal segment_out_tb: std_logic_vector(6 downto 0);
    signal count_tb: std_logic_vector(6 downto 0);
    signal ok_out_tb: std_logic;
    signal DP_tb: std_logic;
    signal ok_aux_tb: std_logic;
    signal reset_aux_tb: std_logic;
    signal digit_cycle_tb: natural range 0 to 1 := 0;
    signal counter_1ms_tb: natural range 0 to 99999 := 0;
    signal number_int_tb: integer:=0;
    signal number_unidades_tb: std_logic_vector(3 downto 0);
    signal number_decenas_tb: std_logic_vector(3 downto 0);
    signal number_vector_tb: std_logic_vector(6 downto 0);
    signal decoder_in_tb: std_logic_vector(3 downto 0);
    signal clk_aux_tb: std_logic;
    signal sync_aux_tb: std_logic_vector(3 downto 0);
    signal async_aux_tb: std_logic_vector(3 downto 0);
    constant CLK_PERIOD : time := 10 ns; -- Adjust the period as needed

    component DISPLAY_COUNTER
        Port ( 
            clk : in STD_LOGIC;
            coin_in : in std_logic_vector(3 downto 0);
            reset : in STD_LOGIC;
            ok_in : in std_logic;
            digsel : out STD_LOGIC_VECTOR (7 downto 0);
            segment_out : out STD_LOGIC_VECTOR (6 downto 0);
            count : out STD_LOGIC_VECTOR (6 downto 0);
            ok_out : out std_logic;
            DP : out std_logic
        );  
          end component;
        begin
        inst_UUT: DISPLAY_COUNTER port map (
            clk => clk_aux_tb,
            coin_in => coin_in_tb,
            reset => reset_aux_tb,
            ok_in => ok_in_tb,
            digsel => digsel_tb,
            segment_out => segment_out_tb,
            count => count_tb,
            ok_out => ok_out_tb,
            DP => DP_tb
        );


    -- Clock process
    process
    begin
        while now < 5000 ns loop  -- simulate for 5000 ns
            clk_tb <= not clk_tb;
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        wait for CLK_PERIOD * 2; -- Wait for initial conditions
        reset_tb <= '0';
        wait for CLK_PERIOD * 3;
        coin_in_tb <= "0001"; -- Set some example input values

        wait for CLK_PERIOD * 4;
        coin_in_tb <= "0010"; -- Change input values
 
        wait for CLK_PERIOD * 5;
        coin_in_tb <= "1000"; -- Change input values

        wait for CLK_PERIOD * 6;
         ok_in_tb <= '1';
        wait;
    end process;

    -- Instantiate the unit under test (UUT)
        -- Monitoring process
        process
        begin
            wait for CLK_PERIOD / 2;
            if now > 20 ns then
                assert ok_out_tb = ok_aux_tb
                    report "Mismatch between ok_out and ok_aux"
                    severity error;
                assert reset_tb = reset_aux_tb
                    report "Mismatch between reset and reset_aux"
                    severity error;
                -- Add assertions for other signals as needed
            end if;
            wait;
        end process;

    end tb_arch;
