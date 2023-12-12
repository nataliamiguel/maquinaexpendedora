----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:05:26
-- Design Name: 
-- Module Name: CHANGE - Behavioral
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

entity CHANGE is
    Port ( reset : in STD_LOGIC;
           CLK : in STD_LOGIC;
           count_int : in STD_LOGIC_VECTOR (2 downto 0);
           count_dec : in STD_LOGIC_VECTOR (2 downto 0);
           change_dec : out STD_LOGIC_VECTOR (2 downto 0);
           change_int : out STD_LOGIC_VECTOR (2 downto 0));
end CHANGE;

architecture Behavioral of CHANGE is

begin


end Behavioral;