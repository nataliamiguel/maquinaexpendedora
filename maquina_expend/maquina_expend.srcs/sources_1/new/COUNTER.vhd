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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
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
           count : out STD_LOGIC_VECTOR (6 downto 0);
           ok_cuenta : out std_logic);
end COUNTER;

architecture Behavioral of COUNTER is
    type ESTADO is (S0, S1);
    signal estado_actual: ESTADO := S0;
    signal estado_siguiente: ESTADO; 
    signal  actual_count : natural range 0 to 99:=0;
    begin
    process(clk, reset)
    begin
        if (reset = '1') then
            estado_actual <= S0;
        elsif (rising_edge(clk)) then
            estado_actual <= estado_siguiente;
        end if;
    end process;


    return_count: process (clk, estado_actual,Coin,Actual_count,ok)
    begin
        if (Coin = "0001") then  --10 cent
            actual_count<=actual_count+1;
        elsif (Coin = "0010") then  --20 cent
            actual_count<=actual_count+2;
        elsif (Coin = "0100") then  --50 cent
            actual_count<=actual_count+5;
        elsif (Coin = "1000") then  --1 euro
        actual_count<=actual_count+10;
        else
        end if;
        if(ok = '1') then
        estado_siguiente <= S1;
        else
        estado_siguiente <= S0;
        end if;
    
        if(estado_actual = s1) then
        actual_count<= 0;
        end if;
    end process;
    count <= std_logic_vector(to_unsigned(actual_count, count'length));
end Behavioral;
