----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 17:21:13
-- Design Name: 
-- Module Name: COMPARE - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COMPARE is
    Port ( clk : in STD_LOGIC;
           price : in STD_LOGIC_VECTOR (6 downto 0);
           count : in STD_LOGIC_VECTOR (6 downto 0);
           reset : in STD_LOGIC;
           option: in STD_LOGIC_VECTOR (2 downto 0);
           importe_ok : out STD_LOGIC;
           error : out STD_LOGIC
         ); 
end COMPARE;

architecture Behavioral of COMPARE is
    type ESTADO is (S0, S2, S3, S4, S5,S6,S7);
    signal estado_actual: ESTADO := S0;
    signal estado_siguiente: ESTADO; 
    
 constant PRICE_S2 : STD_LOGIC_VECTOR(6 downto 0) := "0001010"; -- 10 en binario
 constant PRICE_S3 : STD_LOGIC_VECTOR(6 downto 0) := "0010010"; -- 18 en binario
 constant PRICE_S4 : STD_LOGIC_VECTOR(6 downto 0) := "0000111"; -- 07 en binario    


begin

 process(clk, reset)
    begin
        if (reset = '0') then
            estado_actual <= S0;
        elsif (rising_edge(clk)) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
    
  process(estado_actual,price,count,option,reset)
  begin
   case estado_actual is
    when S0 =>
                if reset = '1' then
                   importe_ok <= '0';
                   estado_siguiente <= S0;
                else
                    case option is
                     when "100" => 
                        estado_siguiente <= S2; --agua
                     when "010" => 
                        estado_siguiente <= S3; --coca
                     when "001" => 
                        estado_siguiente <= S4; --cafe
                     when others =>
                        estado_siguiente <= S0;
                     end case;
                end if;
    when S2 =>
                if price = PRICE_S2 and count >= price then
                    importe_ok <= '1';
                    error <= '0';
                    estado_siguiente <= S5;
                else
                    importe_ok <= '0';
                    error <= '1';
                    estado_siguiente <= S0;

                end if;
     when S3 =>
                if price = PRICE_S3 and count >= price then
                    importe_ok <= '1';
                    error <= '0';
                    estado_siguiente <= S6;
                else
                    importe_ok <= '0';
                    error <= '1';
                    estado_siguiente <= S0;
                end if;
     when S4 =>
                if price = PRICE_S4 and count >= price then
                    importe_ok <= '1';
                    error <= '0';
                    estado_siguiente <= S7;
                else
                    importe_ok <= '0';
                    error <= '1';
                    estado_siguiente <= S0; 
                end if;
        
            when others =>
                importe_ok <= '0';
                error <= '0';
                estado_siguiente <= S0;
        end case;
       end process;

    
    
end Behavioral;