----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 02:51:55 PM
-- Design Name: 
-- Module Name: encoder - Behavioral
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

entity encoder is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0));
end encoder;

architecture Behavioral of encoder is

begin

output(3) <= a(15) or a(14) or a(13) or a(12) or a(11) or a(10) or a(9) or a(8);
 
output(2) <= a(15) or a(14) or a(13) or a(12) or a(7) or a(6) or a(5) or a(4); 

output(1) <= a(15) or a(14) or a(11) or a(10) or a(7) or a(6) or a(3) or a(2); 

output(0) <= a(15) or a(13) or a(11) or a(9) or a(7) or a(5) or a(3) or a(1); 

end Behavioral;
