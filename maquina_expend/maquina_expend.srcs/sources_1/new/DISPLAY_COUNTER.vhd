----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:22:58
-- Design Name: 
-- Module Name: DISPLAY_COUNTER - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISPLAY_COUNTER is
Port ( clk : in STD_LOGIC;
       coin_in : in std_logic_vector(3 downto 0);
       reset : in STD_LOGIC;
       ok_in : in std_logic;
       digsel : out STD_LOGIC_VECTOR (7 downto 0);
       segment_out : out STD_LOGIC_VECTOR (6 downto 0);
       count : out STD_LOGIC_VECTOR (6 downto 0); 
       ok_out : out std_logic;
       DP : out std_logic);     
end DISPLAY_COUNTER;
architecture Behavioral of DISPLAY_COUNTER is
        component COUNTER is
        Port ( reset : in STD_LOGIC;
               CLK : in STD_LOGIC;
               COIN : in STD_LOGIC_VECTOR (3 downto 0);
               OK : in STD_LOGIC;
               count : out STD_LOGIC_VECTOR (6 downto 0);
               ok_cuenta : out std_logic
         );
    end component;
    component decoder is
        Port ( 
               code : IN std_logic_vector(3 DOWNTO 0);
               segment : OUT std_logic_vector(6 DOWNTO 0)
         );
    end component;
    component SYNCHRNZR is
        Port ( 
                CLK : in STD_LOGIC;
                ASYNC_IN : in STD_LOGIC_VECTOR (3 downto 0);
                SYNC_OUT : out STD_LOGIC_vector(3 downto 0);
                RESET: in std_logic
         );
    end component;
    component edgectr is
        Port ( 
                RESET : in std_logic;
                CLK : in STD_LOGIC;
                SYNC_IN : in STD_LOGIC_vector(3 downto 0);
                EDGE : out STD_LOGIC_vector(3 downto 0)
         );
    end component;
    component Debouncer is
        Port ( 
                CLK : in STD_LOGIC;
                COIN : in STD_LOGIC_VECTOR(3 downto 0);
                COIN_OUT : out STD_LOGIC_VECTOR(3 downto 0)
         );
    end component;
       signal ok_aux: std_logic := '0';
       signal reset_aux: std_logic;
       signal digit_cycle: natural range 0 to 1 := 0;
       signal counter_1ms: natural range 0 to 99999 := 0;
       signal number_int: integer:=0;
       signal number_unidades: std_logic_vector(3 downto 0);
       signal number_decenas: std_logic_vector(3 downto 0);
       signal number_vector: std_logic_vector(6 downto 0);
       signal decoder_in: std_logic_vector(3 downto 0);
       signal clk_aux: std_logic;
       signal sync_aux: std_logic_vector(3 downto 0);
       signal async_aux: std_logic_vector(3 downto 0); 
       signal coin_aux : std_logic_vector(3 downto 0);
begin 
    inst_Debouncer: Debouncer  port map(
    clk =>clk_aux,
    Coin=>Coin_in,
    Coin_out=>async_aux
    );
    inst_COUNTER: COUNTER  port map(
    reset=> reset_aux,
    clk =>clk_aux,
    Coin=>coin_aux,
    ok=>ok_in,
    count =>number_vector,
    ok_cuenta=>ok_aux
    );
    inst_SYNCHRNZR: synchrnzr  port map(
        reset=>reset_aux,
        Clk=>clk_aux,
        async_in=>async_aux,
        sync_out=>sync_aux
    );
    inst_DECODER: Decoder  port map(
        code=>decoder_in,
        segment=>segment_out
    );
    inst_Edgectr: edgectr  port map(
        reset=>reset_aux,
        sync_in=>sync_aux,
        clk=>clk_aux,
        edge=>coin_aux
    );
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
     digit_seleccion: process(digit_cycle,number_decenas,number_unidades)
 begin
        case (digit_cycle) is
            when 0 =>
                digsel <= "10111111";
                decoder_in<= number_decenas;
                DP <= '1';
            when 1 =>
                digsel <= "11011111";
                decoder_in<= number_unidades;
       end case;
     end process;
      clk_aux <= clk;
      ok_out<=ok_aux;
      reset_aux<=reset;
      count <= number_vector;
      number_int <= to_integer(unsigned(number_vector));
      number_unidades <= std_logic_vector(to_unsigned(number_int mod 10, 4));
      number_decenas <= std_logic_vector(to_unsigned(number_int / 10, 4));
      
end Behavioral;
