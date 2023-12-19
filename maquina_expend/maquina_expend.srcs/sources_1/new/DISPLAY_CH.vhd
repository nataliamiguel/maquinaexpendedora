----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:37:35
-- Design Name: 
-- Module Name: DISPLAY_CH - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISPLAY_CH is
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       --change: in STD_LOGIC_VECTOR (3 downto 0);
       option: in STD_LOGIC_VECTOR (2 downto 0);
       reassemble: in STD_LOGIC;
       count: in STD_LOGIC_VECTOR (6 downto 0);
       digsel : out STD_LOGIC_VECTOR (3 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0);
       DP : out std_logic);
end DISPLAY_CH;

architecture Behavioral of DISPLAY_CH is
-- DECLARACION
    component CHANGE is
        Port ( reset : in STD_LOGIC;
               clk : in STD_LOGIC;
               option: in STD_LOGIC_vECTOR(2 downto 0); --100 agua; 010 coca; 001 cafe
               reassemble: in STD_LOGIC;
               count : in STD_LOGIC_VECTOR (6 downto 0);
               change: out STD_LOGIC_VECTOR (6 downto 0)
         );
    end component;
    component decoder is
        Port ( 
               code : IN std_logic_vector(3 DOWNTO 0);
               segment : OUT std_logic_vector(6 DOWNTO 0)
        );
    end component;
    
    --SEÑALES
    signal change_signal: STD_LOGIC_VECTOR (6 downto 0);
    signal digit_cycle: natural range 0 to 1 := 0;
    signal counter_1ms: natural range 0 to 99999 := 0;
    signal integer_change: integer:=0;
    signal number_unidades: std_logic_vector(3 downto 0);
    signal number_decenas: std_logic_vector(3 downto 0);
    signal clk_aux: std_logic;
    signal decoder_in: std_logic_vector(3 downto 0);

begin
--INSTANCIACIÓN
    inst_CHANGE: CHANGE port map(
    reset=> reset,
    clk =>clk,
    option=>option,
    reassemble=> reassemble,
    count =>count,
    change=>change_signal
    );
    
    inst_DECODER: Decoder  port map(
        code=>decoder_in,
        segment=>segment
    );
    
--IMPRIMIR EL CAMBIO:
--crear un reloj auxiliar de 1ms
reloj_1ms: process(clk_aux)
 begin
        if (rising_edge(clk_aux)) then
            counter_1ms <= counter_1ms + 1;
         if (counter_1ms >= 99999) then
             counter_1ms <= 0;
             digit_cycle <= digit_cycle + 1;
         if (digit_cycle > 1)then
             digit_cycle <= 0;
         end if;
         end if;
         end if;
     end process;
     digit_seleccion: process(digit_cycle)
     begin
        case (digit_cycle) is
            when 0 =>
                digsel <= "11111011";
                decoder_in<= number_decenas;
                DP <= '1';
            when 1 =>
                digsel <= "11111101";
                decoder_in<= number_unidades;
       end case;
     end process;
     
     clk_aux <= clk;
     integer_change <= to_integer(unsigned(change_signal));
     number_unidades <= std_logic_vector(to_unsigned(integer_change mod 10, 4));
     number_decenas <= std_logic_vector(to_unsigned(integer_change / 10, 4));


end Behavioral;
