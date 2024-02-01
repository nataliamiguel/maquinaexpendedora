----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 19:22:52
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
port(
    clk: in std_logic;
    reset:in std_logic;
    SW_in: IN std_logic_vector(3 DOWNTO 0);
    DP: out std_logic;
    digsel: out std_logic_vector (7 downto 0);
    led: out std_logic_vector (15 downto 0);
    segments:out std_logic_vector(6 downto 0)
    );
end FSM;

architecture Behavioral of FSM is
    type STATE is (COUNTER_STATE, OPTIONS_STATE, CHANGE_STATE, ERROR_STATE);
    signal estado_actual: STATE := COUNTER_STATE;
    signal estado_siguiente: STATE ;
    signal ok_counter: std_logic:='0';
    signal ok_option: std_logic:='0'; --es el negado de 'error' de display_option
    --signal reset_aux: std_logic;
   -- signal clk_aux: std_logic;
    signal count_aux: std_logic_vector(6 downto 0);
    signal digsel_aux1,digsel_aux2,digsel_aux3,digsel_aux4: std_logic_vector (7 downto 0):="00000000";
    signal segment_aux1: std_logic_vector (6 downto 0):="0000000";
    signal segment_aux2: std_logic_vector (6 downto 0):="0000000";
    signal segment_aux3: std_logic_vector (6 downto 0):="0000000";
    signal segment_aux4: std_logic_vector (6 downto 0):="0000000";
    signal DP_aux1: std_logic;
    signal DP_aux2: std_logic;
    signal DP_aux3: std_logic;
    --signal error_aux:std_logic;
    signal led_aux:std_logic_vector(15 downto 0);
  --  signal sw_aux: std_logic_vector(2 downto 0);
begin

process (estado_actual,ok_counter,segment_aux1,DP_aux1,digsel_aux1,ok_option,segment_aux2,DP_aux2,DP_aux2,digsel_aux2,segment_aux4,digsel_aux4,led_aux)
    begin
        case estado_actual is
        when COUNTER_STATE=>
            if (ok_counter='1') then
            estado_siguiente<=OPTIONS_STATE;
            ok_counter<='0';
            segments<=segment_aux1;
            DP<=DP_aux1; 
            digsel<=digsel_aux1;
            end if;
        when OPTIONS_STATE=>
            if (ok_option='1') then
            estado_siguiente<=CHANGE_STATE;
            segments<=segment_aux2;
            DP<=DP_aux2; 
            digsel<=digsel_aux2;
            end if;
        when CHANGE_STATE=>
            if (falling_edge(ok_option)) then
            estado_siguiente<=ERROR_STATE;  
           segments<=segment_aux3; 
           DP<=DP_aux3;
           digsel<=digsel_aux3;
            end if;    
            when ERROR_STATE=>
            ok_option<='1';
            estado_siguiente<=COUNTER_STATE;
            segments<=segment_aux4;
            digsel<=digsel_aux4;
            led<=led_aux;
        end case;   
    end process;
    
   -- error_aux<=not ok_option;
  --  sw_aux<=sw_in(3 downto 1);
   -- clk_aux<=clk;
    --reset_aux<=not reset;

end Behavioral;