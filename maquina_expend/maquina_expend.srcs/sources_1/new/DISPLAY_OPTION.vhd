----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:22:58
-- Design Name: 
-- Module Name: DISPLAY_OPTION - Behavioral
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

entity DISPLAY_OPTION is
Port (  clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        count: in STD_LOGIC_VECTOR (6 downto 0);
        digsel : out STD_LOGIC_VECTOR (3 downto 0);
        segment : out STD_LOGIC_VECTOR (6 downto 0);
        option: out STD_LOGIC_VECTOR (2 downto 0);
        error : out std_logic);
end DISPLAY_OPTION;

architecture Behavioral of DISPLAY_OPTION is
-- DECLARACION
 component COMPARE is
   Port ( clk : in STD_LOGIC;
           price : in STD_LOGIC_VECTOR (6 downto 0);
           count : in STD_LOGIC_VECTOR (6 downto 0);
           reset : in STD_LOGIC;
           option: in STD_LOGIC_VECTOR (2 downto 0);
           importe_ok : out STD_LOGIC;
           error : out std_logic);
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
   
  signal clk_aux: std_logic;   
  signal reset_aux: std_logic;
  signal price_aux : std_logic_vector(6 downto 0);
  signal count_aux : std_logic_vector(6 downto 0);
  signal option_aux : std_logic_vector(2 downto 0);
  signal error_aux : std_logic;
  signal importe_ok_aux : std_logic;
  signal sync_aux: std_logic_vector(3 downto 0);
  signal async_aux: std_logic_vector(3 downto 0); 

begin
 inst_COMPARE: COMPARE  port map(
    reset=> reset_aux,
    clk =>clk_aux,
    price=>price_aux,
    count=>count_aux,
    option=>option_aux,
    error =>error_aux,
    importe_ok=>importe_ok_aux
    );
 inst_SYNCHRNZR: synchrnzr  port map(
        reset=>reset_aux,
        Clk=>clk_aux,
        async_in=>async_aux,
        sync_out=>sync_aux
    );   



end Behavioral;
