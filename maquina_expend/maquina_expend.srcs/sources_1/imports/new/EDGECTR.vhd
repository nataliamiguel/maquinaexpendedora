----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 15:57:21
-- Design Name: 
-- Module Name: EDGECTR - Behavioral
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

entity EDGECTR is
    Port(
         clk: in std_logic;
         reset:in std_logic;
         sync_in: in std_logic_vector(3 downto 0);
         edge: out std_logic_vector(3 downto 0)
 );
end EDGECTR;
architecture Behavioral of EDGECTR is
         type matrix_sreg is array(3 downto 0) of std_logic_vector(2 downto 0);
         signal sreg : matrix_sreg;
         signal edge_aux: std_logic_vector(3 downto 0):= "0000";
begin
-- DETECCION DE FLANCO
        process (reset,clk)
        begin
            if (reset = '0') then
                for i in 0 to 3 loop
                    sreg(i) <= "000";
                end loop;
            elsif rising_edge(clk) then
                 for i in 0 to 3 loop
                     sreg(i) <= sreg(i)(1 downto 0) & sync_in(i);
                 end loop;
            end if;
        end process;
        process (reset, sreg)
        begin
            if(reset = '0') then
                edge_aux <= "0000";
            else
                for i in 0 to 3 loop
                    if(sreg(i) = "100") then
                        edge_aux(i) <= '1';
                    else
                        edge_aux(i) <= '0';
                    end if;
                end loop;
            end if;
        end process;
 edge <= edge_aux;
end Behavioral;