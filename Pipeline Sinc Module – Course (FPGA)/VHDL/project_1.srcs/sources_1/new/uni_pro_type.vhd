library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package uni_pro_type is
    type memory_t is array (0 to 255) of STD_LOGIC_VECTOR (35 downto 0);
    type adder_memory_t is array (0 to 7) of std_logic_vector (17 downto 0);
    type result_cal_memory_t is array (0 to 31) of std_logic_vector(35 downto 0);
--    type result_FFT_memory_t is array (0 to 63) of std_logic_vector(35 downto 0);
    type state_t is (initial, input, padding);
    type product_memory_t is array (0 to 1) of std_logic_vector (35 downto 0);
end package;

package body uni_pro_type is
end package body;