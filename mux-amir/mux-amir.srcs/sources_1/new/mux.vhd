----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2025 01:24:51 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    Port ( s : in STD_LOGIC_VECTOR (7 downto 0);
           d : in STD_LOGIC_VECTOR (2 downto 0);
           o : out STD_LOGIC);
end mux;

architecture Behavioral of mux is
signal dw: STD_LOGIC_VECTOR (2 downto 0);
signal ow: STD_LOGIC_VECTOR (7 downto 0);
begin

-- not of selectors
dw(0)<= not d(0);
dw(1)<= not d(1);
dw(2)<= not d(2);

-- and gates 

ow(0)<= dw(0) and dw(1) and dw(2) and s(0);
ow(1)<= d(0) and dw(1) and dw(2) and s(1);
ow(2)<= dw(0) and d(1) and dw(2) and s(2);
ow(3)<= d(0) and d(1) and dw(2) and s(3);
ow(4)<= dw(0) and dw(1) and d(2) and s(4);
ow(5)<= d(0) and dw(1) and d(2) and s(5);
ow(6)<= dw(0) and d(1) and d(2) and s(6);
ow(7)<= d(0) and d(1) and d(2) and s(7);

-- or gate

o<= ow(0) or ow(1) or ow(2) or ow(3) or ow(4) or ow(5) or ow(6) or ow(7);

end Behavioral;
