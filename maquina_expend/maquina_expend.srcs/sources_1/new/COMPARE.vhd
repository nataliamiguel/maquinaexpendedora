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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMPARE is
    Port ( clk : in STD_LOGIC;
           price : in STD_LOGIC_VECTOR (6 downto 0);
           count : in STD_LOGIC_VECTOR (6 downto 0);
           reset : in STD_LOGIC;
           importe_ok : out STD_LOGIC;
           error : out std_logic);
end COMPARE;

architecture Behavioral of COMPARE is
 type ESTADO is (S0, S2, S3, S4);
    signal estado_actual: ESTADO := S0;
    signal estado_siguiente: ESTADO; 

begin

 process(clk, reset)
    begin
        if (reset = '0') then
            estado_actual <= S0;
        elsif (rising_edge(clk)) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
   return_compare: process (clk, option)
    begin
    
    
end Behavioral;