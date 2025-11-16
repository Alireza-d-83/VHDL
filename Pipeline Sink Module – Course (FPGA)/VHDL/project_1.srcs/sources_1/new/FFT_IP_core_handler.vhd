----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2025 12:03:58 AM
-- Design Name: 
-- Module Name: FFT_IP_core_handler - Behavioral
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
use work.uni_pro_type.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FFT_IP_core_handler is
    Port ( clk : in STD_LOGIC;
           rst : in std_logic;
           valid_in_FFT : in std_logic;
           data_in_FFT : in std_logic_vector (35 downto 0);
           valid_out_FFT : out std_logic;
           FFT_data_last : out std_logic;
           data_address : out std_logic_vector (5 downto 0);
           data_out_FFT : out std_logic_vector (35 downto 0));
end FFT_IP_core_handler;

architecture Behavioral of FFT_IP_core_handler is

    COMPONENT xfft_0
      PORT (
        aclk : IN STD_LOGIC;
        aresetn : IN STD_LOGIC;
        s_axis_config_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axis_config_tvalid : IN STD_LOGIC;
        s_axis_config_tready : OUT STD_LOGIC;
        s_axis_data_tdata : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
        s_axis_data_tvalid : IN STD_LOGIC;
        s_axis_data_tready : OUT STD_LOGIC;
        s_axis_data_tlast : IN STD_LOGIC;
        m_axis_data_tdata : OUT STD_LOGIC_VECTOR(47 DOWNTO 0);
        m_axis_data_tuser : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axis_data_tvalid : OUT STD_LOGIC;
        m_axis_data_tready : IN STD_LOGIC;
        m_axis_data_tlast : OUT STD_LOGIC;
        event_frame_started : OUT STD_LOGIC;
        event_tlast_unexpected : OUT STD_LOGIC;
        event_tlast_missing : OUT STD_LOGIC;
        event_status_channel_halt : OUT STD_LOGIC;
        event_data_in_channel_halt : OUT STD_LOGIC;
        event_data_out_channel_halt : OUT STD_LOGIC
      );
    END COMPONENT;

    signal s_axis_data_tdata : STD_LOGIC_VECTOR(47 DOWNTO 0); 
    signal s_axis_data_tvalid : STD_LOGIC := '0';
    signal s_axis_data_tlast : STD_LOGIC;
    signal m_axis_data_tdata : STD_LOGIC_VECTOR(47 DOWNTO 0);
    signal m_axis_data_tuser : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal m_axis_data_tvalid : STD_LOGIC;
    signal m_axis_data_tready : STD_LOGIC := '1';

    
    signal counter : unsigned (5 downto 0);
    
    signal state : state_t := initial;
    signal valid : std_logic;
    signal FFT_rst : std_logic;
    
begin
   
    process (clk)
    begin
        
        if rising_edge(clk) then
            if rst = '1' then
                state <= initial;
                counter <= (others => '0');
                s_axis_data_tvalid <= '0';
                s_axis_data_tlast <= '0';
            else
                case state is
                    when initial =>
                        s_axis_data_tlast <= '0';
                        if valid_in_FFT = '1' then
                            s_axis_data_tdata <= "000000" & data_in_FFT(17 downto 0) & "000000" & data_in_FFT(35 downto 18);
                            counter <= counter + 1;
                            s_axis_data_tvalid <= '1';
                            s_axis_data_tlast <= '0';
                            state <= input;
                        else
                            s_axis_data_tvalid <= '0';
                        end if;
                    when input => 
                        counter <= counter + 1;
                        s_axis_data_tdata <= "000000" & data_in_FFT(17 downto 0) & "000000" & data_in_FFT(35 downto 18);
                        if counter = "011111" then
                            state <= padding;
                        end if;
                    when padding =>
                        counter <= counter + 1;
                        s_axis_data_tdata <= (others => '0');
                        if counter = "111111" then
                            s_axis_data_tlast <= '1';
                            state <= initial;
                        end if;
                end case;
            end if;
        end if;
    end process;

FFT_rst <= not(rst);

your_instance_name : xfft_0
  PORT MAP (
    aclk => clk,
    aresetn => FFT_rst,
    s_axis_config_tdata => (others => '0'),
    s_axis_config_tvalid => '0',
    s_axis_config_tready => open,
    s_axis_data_tdata => s_axis_data_tdata,
    s_axis_data_tvalid => s_axis_data_tvalid,
    s_axis_data_tready => open,
    s_axis_data_tlast => s_axis_data_tlast,
    m_axis_data_tdata => m_axis_data_tdata,
    m_axis_data_tuser => m_axis_data_tuser,
    m_axis_data_tvalid => m_axis_data_tvalid,
    m_axis_data_tready => m_axis_data_tready,
    m_axis_data_tlast => FFT_data_last,
    event_frame_started => open,
    event_tlast_unexpected => open,
    event_tlast_missing => open,
    event_status_channel_halt => open,
    event_data_in_channel_halt => open,
    event_data_out_channel_halt => open );
  
  
  
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                valid_out_FFT <= '0';
            else
                if m_axis_data_tvalid = '1' then
                
                    valid_out_FFT <= '1';
                    data_out_FFT <= m_axis_data_tdata(17 downto 0) & m_axis_data_tdata(41 downto 24);
                    data_address <= m_axis_data_tuser (5 downto 0);
                else
                    valid_out_FFT <= '0';
                end if;
            end if;
        end if;
    end process;



end Behavioral;
