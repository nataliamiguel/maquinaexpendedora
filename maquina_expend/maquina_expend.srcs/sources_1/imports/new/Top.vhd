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
    SW_in: IN std_logic_vector(3 DOWNTO 0);
    digsel: OUT std_logic_vector(7 DOWNTO 0);
    segments: out std_logic_vector(7 downto 0); 
    DP: out std_logic;
    led: OUT std_logic 
    );
end Top;

architecture Behavioral of Top is
    type STATE is (COUNTER_STATE, OPTIONS_STATE, CHANGE_STATE, ERROR_STATE);
    signal estado_actual: STATE := COUNTER_STATE;
    signal estado_siguiente: STATE ;
    signal ok_counter: std_logic:='0';
    signal ok_option: std_logic:='0'; --es el negado de 'error' de display_option
    signal reset_aux: std_logic;
    signal clk_aux: std_logic;
    signal count_aux: std_logic_vector(6 downto 0);
    signal digsel_aux: std_logic_vector (7 downto 0);
    signal segment_aux: std_logic_vector (6 downto 0);
    signal DP_aux: std_logic;
    signal error_aux:std_logic;
    signal led_aux:std_logic;
    signal sw_aux: std_logic_vector(2 downto 0);
    
    
    
   component DISPLAY_COUNTER is
    Port ( clk : in STD_LOGIC;
       coin_in : in std_logic_vector(3 downto 0);
       reset : in STD_LOGIC;
       ok_in : in std_logic;
       digsel : out STD_LOGIC_VECTOR (7 downto 0);
       segment_out : out STD_LOGIC_VECTOR (6 downto 0);
       count : out STD_LOGIC_VECTOR (6 downto 0);
       ok_out : out std_logic;
       DP : out std_logic    );
    end component;
    
    component DISPLAY_CH is
    Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       --change: in STD_LOGIC_VECTOR (3 downto 0);
       option: in STD_LOGIC_VECTOR (2 downto 0);
       reassemble: in STD_LOGIC;
       count: in STD_LOGIC_VECTOR (6 downto 0);
       digsel : out STD_LOGIC_VECTOR (7 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0);
       DP : out std_logic);
    end component;
    
    component DISPLAY_ERR is
Port ( clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       input_error: in STD_LOGIC;
       led: OUT std_logic;
       digsel : out STD_LOGIC_VECTOR (7 downto 0);
       segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component DISPLAY_OPTION is
Port (  clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        count: in STD_LOGIC_VECTOR (6 downto 0);
        sw: in STD_LOGIC_VECTOR (2 downto 0);
        digsel : out STD_LOGIC_VECTOR (7 downto 0);
        segment : out STD_LOGIC_VECTOR (6 downto 0);
        DP : out std_logic;
        error : out std_logic);        
end component;
    

begin

inst_DISPLAY_COUNTER: DISPLAY_COUNTER Port map ( 
       clk =>clk_aux,
       coin_in=> coin,
       reset=>reset_aux,
       ok_in => sw_in(0),
       digsel => digsel_aux,
       segment_out => segment_aux,
       count => count_aux,
       ok_out=> ok_counter,
       DP =>DP_aux); 
       
 inst_DISPLAY_OPTION: DISPLAY_OPTION port map(
       clk =>clk_aux,
        reset=>reset_aux,
        count=>count_aux,
        sw=> sw_aux,
        digsel =>digsel_aux,
        segment=> segment_aux,
        error=> error_aux
 );    

inst_DISPLAY_CH: DISPLAY_CH port map(
       clk =>clk_aux,
       reset =>reset_aux,
       option=>sw_aux,
       reassemble=> reassemble,
       count=>count_aux,
       digsel =>digsel_aux,
       segment=>segment_aux,
       DP=>DP_aux
);

inst_DISPLAY_ERR: DISPLAY_ERR port map(
       clk => clk_aux,
       reset =>reset_aux,
       input_error=> error_aux,
       led=>led_aux,
       digsel=> digsel_aux,
       segment=>segment_aux
);


    process (clk_aux,reset_aux)
    begin
        if (reset_aux='1') then
            estado_actual<=COUNTER_STATE;
        elsif (rising_edge(clk_aux)) then
        estado_actual<=estado_siguiente;
        end if;
    end process;

    process (estado_actual)
    begin
        case estado_actual is
        when COUNTER_STATE=>
            if (ok_counter='1') then
            estado_siguiente<=OPTIONS_STATE;
            ok_counter<='0';
            end if;
        when OPTIONS_STATE=>
            if (ok_option='1') then
            estado_siguiente<=CHANGE_STATE;
            end if;
        when CHANGE_STATE=>
            if (falling_edge(ok_option)) then
            estado_siguiente<=ERROR_STATE;  
           
            end if;    
            when ERROR_STATE=>
            ok_option<='1';
            estado_siguiente<=COUNTER_STATE; 
        end case;   
    end process;
    error_aux<=not ok_option;
    sw_aux<=sw_in(3 downto 1);
end Behavioral;
