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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CHANGE is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           option: in STD_LOGIC_vECTOR(2 downto 0); --100 agua; 010 coca; 001 cafe
           reassemble: in STD_LOGIC;
           count : in STD_LOGIC_VECTOR (6 downto 0);
           change: out STD_LOGIC_VECTOR (6 downto 0)
     );
end CHANGE;


architecture Behavioral of CHANGE is
    type ESTADO is (S0, S5, S6, S7);
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

    return_change: process (clk, estado_actual,option,count)
    begin
        if (option = "100") then --AGUA 1€ 
        --multiplicamos 1€ por 10 para quitar la parte decimal(si la hubiera)
        --10 en binario es 1010 -> 0001010
            estado_siguiente<=S5;
            change<= (count-"0001010");
        elsif (option="010") then  --COCA 1.8€
        -- 18 en binario es 0010010
            estado_siguiente<=S6;
            change<= (count-"0010010");
        elsif (option="001") then --CAFE 0.7€
        -- 7 en binario es 0000111
            estado_siguiente<=S7;
            change<= (count-"0000111");
        end if;
    end process;
    
    reassemble_button: process (reassemble,estado_actual)
    begin
        --si pulsamos reassemble y estamos en los estados S5, S6 o S7, vuelve al estado S0
        if (reassemble='1') then
            if (estado_actual = S5 or estado_actual = S6 or estado_actual = S7) then
            estado_siguiente<=S0;
            end if;
        end if;
        estado_actual<=estado_siguiente;
    end process;
    
    
    
end Behavioral;
