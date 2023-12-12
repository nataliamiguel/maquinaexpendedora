----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 16:58:16
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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

entity COUNTER is
    Port ( reset : in STD_LOGIC;
           CLK : in STD_LOGIC;
           COIN : in STD_LOGIC_VECTOR (3 downto 0);
           OK : in STD_LOGIC;
           count_int : out STD_LOGIC_VECTOR (2 downto 0);
           count_dec : out STD_LOGIC_VECTOR (2 downto 0));
end COUNTER;

architecture Behavioral of COUNTER is

begin


end Behavioral;
