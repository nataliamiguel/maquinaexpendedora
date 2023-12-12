----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:21:13
-- Design Name: 
-- Module Name: COMPARE - Behavioral
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

entity COMPARE is
    Port ( CLK : in STD_LOGIC;
           price_int : in STD_LOGIC_VECTOR (2 downto 0);
           price_dec : in STD_LOGIC_VECTOR (2 downto 0);
           count_dec : in STD_LOGIC_VECTOR (2 downto 0);
           count_int : in STD_LOGIC;
           reset : in STD_LOGIC;
           importe_ok : in STD_LOGIC);
end COMPARE;

architecture Behavioral of COMPARE is

begin


end Behavioral;