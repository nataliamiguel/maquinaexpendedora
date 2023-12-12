----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:22:58
-- Design Name: 
-- Module Name: DISPLAY_COUNTER - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISPLAY_COUNTER is
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       count_int : in STD_LOGIC_VECTOR (3 downto 0);
       count_dec : in STD_LOGIC_VECTOR (3 downto 0);
       digsel : out STD_LOGIC_VECTOR (3 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0));      
end DISPLAY_COUNTER;

architecture Behavioral of DISPLAY_COUNTER is

begin


end Behavioral;