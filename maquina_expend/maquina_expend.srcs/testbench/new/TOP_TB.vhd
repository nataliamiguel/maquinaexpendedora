----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 19:53:50
-- Design Name: 
-- Module Name: TOP_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP_TB is
--  Port ( );
end TOP_TB;

architecture SIM of TOP_TB is
signal CLK_TB: std_logic := '0';
    signal RESET_TB: std_logic := '0';
    signal COIN_TB: std_logic_vector(3 downto 0) := "0000";
    signal REASSEMBLE_TB: std_logic := '0';
    signal SW_IN_TB: std_logic_vector(3 downto 0) := "0000";
    signal DIGSEL_TB: std_logic_vector(7 downto 0);
    signal SEGMENTS_TB: std_logic_vector(6 downto 0);
    signal DP_TB: std_logic;
    signal LED_TB: std_logic_vector(15 downto 0);

    constant CLOCK_PERIOD: time := 10 ns;
begin

-- Instantiate the unit under test
    UUT: entity work.Top
        port map (
            CLK => CLK_TB,
            RESET => RESET_TB,
            COIN => COIN_TB,
            REASSEMBLE => REASSEMBLE_TB,
            SW_IN => SW_IN_TB,
            DIGSEL => DIGSEL_TB,
            SEGMENTS => SEGMENTS_TB,
            DP => DP_TB,
            LED => LED_TB
        );

process
    begin
         while now < 50 ms loop  -- simulate for 5000 ns 
            clk_tb <= not clk_tb;
           wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
              -- Assert reset
        wait for 10 ns;
        reset_tb <= '0';  -- De-assert reset
        sw_in_tb(0)<='0';
        -- Test case 1: Counter State
        wait for 1 ms;
        coin_tb <= "1000";  -- Set coin input  -- Set SW input for Counter State
        wait for 5 ms;
        coin_tb<= "0000";
        -- Test case 2: Options State  -- Set SW input for Options State
        wait for 1ms;
        sw_in_tb(0)<='1';
        -- Test case 3: Change State-- Set reassemble input
        wait for 10 ms;
        sw_in_tb(1)<='1';
        -- Test case 4: Error State
        wait for 10ms;
        reassemble_tb<='1';
        -- Add more test cases as needed

        wait;
    end process;

end sim;
