----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 16:08:41
-- Design Name: 
-- Module Name: ERROR - Behavioral
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

entity ERROR is
PORT (
    error : IN std_logic;
    reset : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    led: OUT std_logic;
    digsel: OUT std_logic_vector(7 downto 0);
    segment_error : OUT std_logic_vector(6 DOWNTO 0)    
);
end ERROR;

architecture Behavioral of ERROR is
--Para cambiar pantalla de tal modo que no sea perceptible para...
-- ... el ojo y parezca un texto mostrado de manera continua:
signal counter_1ms: natural range 0 to 99999 := 0;
--La señal de error (display y LED) queremos que duren 2 segundos
signal counter_2s: natural range 0 to 199999999 := 0;
--Para cambiar de digsel:
signal digsel_change: natural range 0 to 7 := 0;
--Pantalla final cuando han pasado 2 segundos:
signal final: natural range 0 to 1 := 0;
begin

--PROCESS 1 -> señal que cambia cada milisegundo
    reloj_1ms: process(clk)
    begin
        if (rising_edge(clk)) then
            counter_1ms <= counter_1ms + 1;
            if (counter_1ms >= 99999) then
                counter_1ms <= 0;
                digsel_change <= digsel_change + 1;
                if (digsel_change > 7)then
                    digsel_change <= 0;
                end if;
            end if;
        end if;
    end process;

--PROCESS 2 -> señal que cambia a los 2 segundos
    reloj_2s: process(clk)
    begin
        if (rising_edge(clk)) then
            counter_2s <= counter_2s + 1;
            if (counter_2s >= 199999999) then
                counter_2s <= 0;
                final <= final + 1;
                if (final > 1)then
                    final <= 0;
                end if;
            end if;
        end if;
    end process;

-- Asociamos los anodos de los diodos a la señal de un 1[ms]
 digit_control: process(digsel_change)
 begin
    case (digsel_change) is
        when 0 =>
            -- Significa que queremos el primer digito activo (activo a nivel bajo)
            digsel <= "01111111";
        when 1 =>
            digsel <= "10111111";
        when 2 =>
            digsel <= "11011111";
        when 3 =>
            digsel <= "11101111";
        when 4 =>
            digsel <= "11110111";
        when 5 =>
            digsel <= "11111011";
        when 6 =>
            digsel <= "11111101";
        when 7 =>
            digsel <= "11111110";
    end case;
 end process;


--PROCESS 4-> encender el LED indicativo de error
error_led: process(error,final)
    begin
        if (final=0) then
            if (error = '1') then
                led <= '1';  -- Se enciende el LED de error
            end if;
        else
            led <= '0';
        end if; 
end process;

--PROCESS 5-> Process para mostrar mensaje de error
error_display: process(error, reset, digsel_change, final)
begin
    segment_error  <= "11111111";
    if (reset='0') then
        segment_error <= "11111111";
    else 
        case (error) is
            when '1'=>
            --Muestra "ERR" en los 3 últimos digsel
            if (digsel_change = 5) then
                segment_error <= "1111001"; -- E
            elsif (digsel_change = 6) then
                segment_error <= "1110000"; -- R
            elsif (digsel_change = 7) then
                segment_error <= "1110000"; -- R            
            end if;
        end case;
    end if;
end process;
end Behavioral;
