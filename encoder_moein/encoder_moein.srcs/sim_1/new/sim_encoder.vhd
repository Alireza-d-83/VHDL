-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 21.2.2025 11:39:17 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_encoder is
end tb_encoder;

architecture tb of tb_encoder is

    component encoder
        port (a      : in std_logic_vector (15 downto 0);
              output : out std_logic_vector (3 downto 0));
    end component;

    signal a      : std_logic_vector (15 downto 0);
    signal output : std_logic_vector (3 downto 0);

begin

    dut : encoder
    port map (a      => a,
              output => output);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        a <= x"0001";
        wait for 50 ns;
        
        a <= x"0002";
        wait for 50 ns;
        
        a <= x"0004";
        wait for 50 ns;
        
        a <= x"0008";
        wait for 50 ns;
        
        a <= x"0010";
        wait for 50 ns;
        
        a <= x"0020";
        wait for 50 ns;
        
        a <= x"0040";
        wait for 50 ns;
        
        a <= x"0080";
        wait for 50 ns;
        
        a <= x"0100";
        wait for 50 ns;
        
        a <= x"0200";
        wait for 50 ns;
        
        a <= x"0400";
        wait for 50 ns;
        
        a <= x"0800";
        wait for 50 ns;
        
        a <= x"1000";
        wait for 50 ns;
        
        a <= x"2000";
        wait for 50 ns;
        
        a <= x"4000";
        wait for 50 ns;
        
        a <= x"8000";
        wait for 50 ns;
        
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_encoder of tb_encoder is
    for tb
    end for;
end cfg_tb_encoder;