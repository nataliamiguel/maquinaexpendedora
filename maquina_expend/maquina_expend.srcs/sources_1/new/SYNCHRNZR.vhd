----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2023 16:47:06
-- Design Name: 
-- Module Name: SYNCHRNZR - Behavioral
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SYNCHRNZR is
    Port ( CLK : in STD_LOGIC;
           ASYNC_IN : in STD_LOGIC_VECTOR (3 downto 0);
           SYNC_OUT : out STD_LOGIC_vector(3 downto 0);
           reset: in std_logic);
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is
    type matrix_sreg is array(3 downto 0) of std_logic_vector(1 downto 0);
    signal sreg: matrix_sreg;
begin
    process (reset,clk)
    begin
        if (reset='1') then
            for i in 0 to 3 loop
                sync_out(i) <= '0';
                sreg(i) <="00";
            end loop;
        elsif rising_edge(clk) then
            for i in 0 to 3 loop
                sync_out(i) <= sreg(i)(1);
                sreg(i) <= sreg(i)(0) & async_in(i);
             end loop;
        end if;
     end process;
end architecture Behavioral;
