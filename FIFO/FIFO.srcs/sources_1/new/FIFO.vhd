----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2025 05:18:44 PM
-- Design Name: 
-- Module Name: FIFO - Behavioral
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

entity FIFO is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Write : in STD_LOGIC;
           Read : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out STD_LOGIC_VECTOR (7 downto 0);
           Full : out STD_LOGIC;
           Empty : out STD_LOGIC);
end FIFO;

architecture Behavioral of FIFO is
    
    type ram_type is array (0 to 31) of std_logic_vector (7 downto 0);
    signal ram : ram_type := (others => (others => '0'));

    type state_type is (T0, T1);
    signal current_state : state_type := T0;
    signal next_state    : state_type;
    
    
    
begin
    
    

end Behavioral;
