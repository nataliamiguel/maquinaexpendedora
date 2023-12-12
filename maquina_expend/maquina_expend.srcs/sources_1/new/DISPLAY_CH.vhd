----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:37:35
-- Design Name: 
-- Module Name: DISPLAY_CH - Behavioral
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

entity DISPLAY_CH is
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       change: in STD_LOGIC_VECTOR (3 downto 0);
       digsel : out STD_LOGIC_VECTOR (3 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0));
end DISPLAY_CH;

architecture Behavioral of DISPLAY_CH is

begin


end Behavioral;