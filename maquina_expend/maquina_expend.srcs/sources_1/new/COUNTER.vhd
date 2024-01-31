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
           ok_cuenta: out std_logic
           );
           
end COUNTER;

architecture Behavioral of COUNTER is
    type ESTADO is (S0, S1);
    signal estado_actual: ESTADO := S1;
    signal estado_siguiente: ESTADO:=S1; 
    signal  actual_count : natural range 0 to 99:=0;
    signal ok_cuenta_aux: std_logic:='0';
    signal coin_anterior: std_logic:='0';
    begin
    process(clk, reset)
    begin
        if (reset = '1') then
            estado_actual <= S0;
        elsif (rising_edge(clk)) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
--Estado S0, cuenta = 0
--Estado S1, suma las monedas
    
    process (clk,ok,estado_actual,reset)
    begin
        if(ok = '1') then      
            estado_siguiente <= S0;
            ok_cuenta_aux<='1';
        else
           --estado_siguiente <= S1;
        end if;
    end process;  
    process (clk, estado_actual,coin)
    begin
        case (estado_actual) is
            when s0=>
                actual_count<= 0;
            when s1=>
                if(coin'event) then
                coin_anterior<='1';
                end if;
                if (Coin_anterior = '1' and coin ="0001") then  --10 cent
                actual_count<=actual_count+1;
                coin_anterior<='0';
                elsif (Coin_anterior = '1' and coin ="0010") then  --20 cent
                actual_count<=actual_count+2;
                coin_anterior<='0';
                elsif (Coin_anterior = '1' and coin ="0100") then  --50 cent
                actual_count<=actual_count+5;
                coin_anterior<='0';
                elsif (Coin_anterior = '1' and coin ="1000") then  --1 euro
                actual_count<=actual_count+10;
                coin_anterior<='0';
                else
                end if;
        end case;
    end process;
    count <= std_logic_vector(to_unsigned(actual_count, count'length));
    ok_cuenta<=ok_cuenta_aux;
end Behavioral;
