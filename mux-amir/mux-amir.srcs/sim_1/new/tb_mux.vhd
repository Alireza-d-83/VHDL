-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 21.2.2025 10:12:06 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_mux is
end tb_mux;

architecture tb of tb_mux is

    component mux
        port (s : in std_logic_vector (7 downto 0);
              d : in std_logic_vector (2 downto 0);
              o : out std_logic);
    end component;

    signal s : std_logic_vector (7 downto 0);
    signal d : std_logic_vector (2 downto 0);
    signal o : std_logic;

begin

    dut : mux
    port map (s => s,
              d => d,
              o => o);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        s <= "00000000";
        d <= "101";
        wait for 20ns;
        s <= "00100000";
        d <= "101";
        wait for 20ns;
        s <= "10000000";
        d <= "111";
        wait for 20ns;
        s <= "01000000";
        d <= "110";
        wait for 20ns;
        s <= "00000010";
        d <= "001";
        wait for 20ns;
        s <= "00000001";
        d <= "000";
        wait for 20ns;
        
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_mux of tb_mux is
    for tb
    end for;
end cfg_tb_mux;