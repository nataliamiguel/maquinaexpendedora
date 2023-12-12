----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:22:58
-- Design Name: 
-- Module Name: DISPLAY_ERR - Behavioral
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

entity DISPLAY_ERR is
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       error: in STD_LOGIC;
       digsel : out STD_LOGIC_VECTOR (3 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0));
end DISPLAY_ERR;

architecture Behavioral of DISPLAY_ERR is

begin


end Behavioral;
