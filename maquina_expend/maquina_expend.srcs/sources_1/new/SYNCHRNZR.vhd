----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 16:47:06
-- Design Name: 
-- Module Name: SYNCHRNZR - Behavioral
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

entity SYNCHRNZR is
    Port ( CLK : in STD_LOGIC;
           ASYNC_IN : in STD_LOGIC_VECTOR (3 downto 0);
           SYNC_OUT : out STD_LOGIC);
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is

begin


end Behavioral;
