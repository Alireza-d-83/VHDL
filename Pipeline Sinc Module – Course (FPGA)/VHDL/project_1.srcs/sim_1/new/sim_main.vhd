-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 06 Nov 2025 14:18:46 GMT
-- Request id : cfwk-fed377c2-690cae46025fd

library ieee;
use ieee.std_logic_1164.all;

entity tb_main is
end tb_main;

architecture tb of tb_main is

    component main
        port (valid_in  : in std_logic;
              rst       : in std_logic;
              valid_out : out std_logic;
              last_out  : out std_logic;
              data_in   : in std_logic_vector (35 downto 0);
              data_out  : out std_logic_vector (5 downto 0);
              clk       : in std_logic);
    end component;

    signal valid_in  : std_logic;
    signal rst       : std_logic;
    signal valid_out : std_logic;
    signal last_out  : std_logic;
    signal data_in   : std_logic_vector (35 downto 0);
    signal data_out  : std_logic_vector (5 downto 0);
    signal clk       : std_logic;

begin

    dut : main
    port map (valid_in  => valid_in,
              rst       => rst,
              valid_out => valid_out,
              last_out  => last_out,
              data_in   => data_in,
              data_out  => data_out,
              clk       => clk);

    process begin
    clk <= '0';
    wait for(10ns);
    clk <= '1';
    wait for(10ns);
    end process;
    
    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed

        valid_in <= '0';
        data_in <= x"77179E709";
        rst <= '1';
        wait for 200ns;
        rst<='0';
        valid_in <= '1';
        wait for 20ns;
        valid_in <= '0';
        wait for 1260ns;
        data_in <= x"000000000";
        valid_in <= '1';
        wait for 15ns;
        valid_in <= '0';

        -- ***EDIT*** Add stimuli here

        wait;
    end process;

end tb;