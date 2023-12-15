----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2023 15:54:02
-- Design Name: 
-- Module Name: Top - Behavioral
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

entity Top is
--  Port ( );
PORT (
    CLK: IN std_logic;
    reset: in std_logic;
    COIN: IN std_logic_vector(3 DOWNTO 0);
    reassemble: IN std_logic;
    SW: IN std_logic_vector(3 DOWNTO 0);
    digsel: OUT std_logic_vector(7 DOWNTO 0);
    led: OUT std_logic 
    );
end Top;

architecture Behavioral of Top is
component EDGEDCTR is
 Port ( CLK : in STD_LOGIC;
 SYNC_IN : in std_logic_vector;
 EDGE : out std_logic_vector
 );
end component;
begin
end Behavioral;
