library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNTER_TB is
end COUNTER_TB;

architecture TB_ARCH of COUNTER_TB is
    signal reset_tb : STD_LOGIC:='0';
    signal CLK_tb : STD_LOGIC:='0';
    signal COIN_tb : STD_LOGIC_VECTOR (3 downto 0):="0000";
    signal OK_tb : STD_LOGIC:='0';
    signal count_tb : STD_LOGIC_VECTOR (6 downto 0):="0000000";
    signal ok_cuenta_tb : STD_LOGIC:='0';

    constant CLK_PERIOD : time := 1 ms; -- Adjust as needed

    -- Instantiate the COUNTER module
    component COUNTER
        Port ( reset : in STD_LOGIC;
               CLK : in STD_LOGIC;
               COIN : in STD_LOGIC_VECTOR (3 downto 0);
               OK : in STD_LOGIC;
               count : out STD_LOGIC_VECTOR (6 downto 0);
               ok_cuenta : out STD_LOGIC);
    end component;
begin
    UUT: COUNTER port map (reset=>reset_tb, CLK=>clk_tb, COIN=>coin_tb, OK=>ok_tb, count=>count_tb, ok_cuenta=>ok_cuenta_tb);
    -- Clock generation process
    process
    begin
      while now < 100 ms loop  -- simulate for 5000 ns 
            clk_tb <= not clk_tb;
           wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    -- Stimulus process
    process
    begin
 
        wait for CLK_PERIOD;
        coin_tb <= "0001"; -- Set some example input values
           wait for CLK_PERIOD;
        coin_tb <= "0010"; -- Set some example input values
           wait for CLK_PERIOD;
        coin_tb <= "1000"; -- Set some example input values
           wait for CLK_PERIOD;
        coin_tb <= "0000"; -- Set some example input values
            wait  for CLK_PERIOD;
            reset_tb<='1';
        wait;
        -- Add more test cases as needed
    end process;

    -- Instantiate the COUNTER module and connect signal
end TB_ARCH;
