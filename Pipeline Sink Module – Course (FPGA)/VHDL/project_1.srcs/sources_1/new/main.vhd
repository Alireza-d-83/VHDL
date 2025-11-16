----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2025 10:08:38 PM
-- Design Name: 
-- Module Name: shift - Behavioral
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

entity main is
    Port ( valid_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           valid_out : out STD_LOGIC;
           last_out : out STD_LOGIC;
           data_in  : in  STD_LOGIC_VECTOR (35 downto 0);  --re & img
           data_out : out STD_LOGIC_VECTOR (5 downto 0);  --re & img
           clk : in STD_LOGIC);
end main;

architecture Behavioral of main is


    component FFT_IP_core_handler
        port (clk               : in std_logic;
              rst               : in std_logic;
              valid_in_FFT      : in std_logic;
              data_in_FFT : in std_logic_vector (35 downto 0);
              valid_out_FFT     : out std_logic;
              FFT_data_last : out std_logic;
              data_address      : out std_logic_vector (5 downto 0);
              data_out_FFT      : out std_logic_vector (35 downto 0));
    end component;

    type memory_t is array (0 to 255) of std_logic_vector(35 downto 0);

    signal R_memory : memory_t := (
x"C658B05F1",x"734A37D55",x"0E913F2BD",x"4D782727F",x"60D7FBC48",x"1F83EE919",x"CF0EBAFE0",
x"C05105EFE",x"2E016020F",x"C6EDFEBA8",x"BEE33998C",x"0FCE54B31",x"1792E9767",x"CFF8695C9",x"0146AA48A",
x"3C74B7795",x"53823B301",x"00C0460FA",x"0BA7435B7",x"8752B938B",x"5A25B3C9B",x"95109F149",x"C1303DBEC",
x"9DAFC44C7",x"C57987758",x"DDCE325BA",x"539FF4E7B",x"05F537BB3",x"CAFC4FDB4",x"89FE815DE",x"6A0A9387C",
x"723448C97",x"204F7CB9C",x"04FFECEC8",x"7A7B4E0A8",x"518C5DD48",x"CE020F72D",x"B30F31D37",x"DDB02A431",
x"1D0D12ED0",x"965DB753D",x"3D45A994B",x"36AAC80F5",x"6CED682E1",x"5B7EB11A9",x"B7DC18924",x"3357FFF62",
x"EB6E6F971",x"53834047E",x"51771DA40",x"5FDDCBF30",x"609440389",x"27B8D3D6C",x"C4B2E3C72",x"DF9BDE5C0",
x"86FE09BDB",x"D8FA8D4A4",x"F80552791",x"EA2123BAC",x"696684DFB",x"809538CAC",x"F24A8D030",x"546578C2F",
x"1E973448C",x"29A6D7EC4",x"A7D7F39A9",x"82334FF54",x"C0EDBF5CC",x"E52F462B0",x"A0EFEFFF3",x"A179EF5EC",
x"D7E06A1D3",x"D56542D49",x"E470A8947",x"B45A3DCB1",x"22314C05E",x"E0C3547A3",x"FE3A881F9",x"D85C8DB92",
x"AC47F2171",x"200108141",x"9F78DAC07",x"721BAE2BB",x"1CDF3ACD6",x"E704462FE",x"A44D4703E",x"7A53806C7",
x"E49CFAA43",x"778499738",x"F5FE5B73B",x"8ABB0854C",x"F714DD91B",x"7F07D2190",x"2615236EC",x"8FA632B6B",
x"28934679A",x"41A3AA109",x"1AF9C5527",x"E1D2B3B0B",x"EE3DC5617",x"C0902138D",x"0BAEF7323",x"3D3CA2721",
x"C1D73AB53",x"31B9F5F6A",x"A6353BCDC",x"53D07B62E",x"210539CA0",x"93C7DDBE5",x"6F6FBD2F9",x"D4A43BEBF",
x"79D84D267",x"9943DEB26",x"4FC0156E4",x"D3BCCC1A9",x"094563D1E",x"771DA9D3F",x"324F124A5",x"A2F72AF97",
x"B363E7710",x"917504B98",x"CE59A5EC6",x"F88C14D6D",x"4BD7102EE",x"117DE5C5E",x"7DC4C9817",x"FE7F431B7",
x"C40AB55E8",x"65CCB3352",x"64617EAD9",x"9D86D0A24",x"47FBFF2B9",x"39F677429",x"C8DC05E16",x"374931C2E",
x"A06531894",x"63A50F76E",x"65C3CE8AF",x"1AE8699B9",x"5EE08106C",x"026875650",x"202DA9B91",x"BDA753579",
x"F3CDAE339",x"F7C899FF2",x"B046D5DCB",x"01BDCCB0F",x"158AEF18D",x"375501FF5",x"4F0EB8588",x"D90E5F0EE",
x"27A3D60FC",x"692A7D744",x"2B7401C1A",x"D99B12C0C",x"B08A4C5A9",x"9E26144E8",x"F4E3B66B8",x"13A5F19EC",
x"171481811",x"B87609726",x"9E3556641",x"4C2801C8F",x"D3AF6A465",x"1CABF0BD1",x"A8920E0FB",x"59921E9A3",
x"A73E4826C",x"C8D7F5021",x"E5E3CF93B",x"631E18139",x"6DED2AC29",x"00C6C955B",x"33A507398",x"06213AA8C",
x"7E3FECB23",x"E350952F1",x"B38649DC1",x"FA4860CBC",x"0B0E14088",x"17E9BF1A8",x"33879F17F",x"001F7A35C",
x"DC0734361",x"2C4E278D8",x"BF024A269",x"E373DDC58",x"982547EC2",x"A8AD8CEA3",x"884A1A3C6",x"84BBAC3F5",
x"8B0BD1FEE",x"B1577F7F3",x"482226480",x"934E25E60",x"073F44DE9",x"411767E0E",x"1C8803DEF",x"1F9AE825A",
x"71CDBD197",x"99542629C",x"DC22ACCFE",x"372E69BC1",x"6A7B6F24C",x"09AC99BEF",x"BB29FEAE4",x"0F810C176",
x"B5895E3CA",x"14291B598",x"342770EAD",x"0883C48D0",x"13F3B928C",x"9939DC0D8",x"24031989A",x"DEC10817B",
x"099099D20",x"7BEB2BC28",x"4A9BA5729",x"33A4B497D",x"7AB5D20A7",x"2169E4157",x"1C00EE29C",x"D8A0C6780",
x"9E206149B",x"3226AAB1E",x"BDBE96EB5",x"96B871D0E",x"C5D5FF558",x"C99DEAA58",x"041107645",x"F34516FF1",
x"12174ED5C",x"DA6580767",x"894F64C40",x"49C44E9ED",x"CD9C3C4E9",x"5A09BCC0A",x"09C239868",x"58BBB6462",
x"A344B81F5",x"163397F65",x"5A0029325",x"592E17222",x"1221ED377",x"455CD7566",x"3EEF28331",x"96E9E349C",
x"59212C54A",x"6D0951FE4",x"7E333A22A",x"0186B40CB",x"FD4E1C62F",x"A4E7D0EF7",x"D3470EDF5",x"C9A8DC79F",x"D61275756"
    );
    
    signal S_memory : memory_t := (
x"77179E709",x"C658B05F1",x"734A37D55",x"0E913F2BD",x"4D782727F",x"60D7FBC48",x"1F83EE919",x"CF0EBAFE0",
x"C05105EFE",x"2E016020F",x"C6EDFEBA8",x"BEE33998C",x"0FCE54B31",x"1792E9767",x"CFF8695C9",x"0146AA48A",
x"3C74B7795",x"53823B301",x"00C0460FA",x"0BA7435B7",x"8752B938B",x"5A25B3C9B",x"95109F149",x"C1303DBEC",
x"9DAFC44C7",x"C57987758",x"DDCE325BA",x"539FF4E7B",x"05F537BB3",x"CAFC4FDB4",x"89FE815DE",x"6A0A9387C",
x"723448C97",x"204F7CB9C",x"04FFECEC8",x"7A7B4E0A8",x"518C5DD48",x"CE020F72D",x"B30F31D37",x"DDB02A431",
x"1D0D12ED0",x"965DB753D",x"3D45A994B",x"36AAC80F5",x"6CED682E1",x"5B7EB11A9",x"B7DC18924",x"3357FFF62",
x"EB6E6F971",x"53834047E",x"51771DA40",x"5FDDCBF30",x"609440389",x"27B8D3D6C",x"C4B2E3C72",x"DF9BDE5C0",
x"86FE09BDB",x"D8FA8D4A4",x"F80552791",x"EA2123BAC",x"696684DFB",x"809538CAC",x"F24A8D030",x"546578C2F",
x"1E973448C",x"29A6D7EC4",x"A7D7F39A9",x"82334FF54",x"C0EDBF5CC",x"E52F462B0",x"A0EFEFFF3",x"A179EF5EC",
x"D7E06A1D3",x"D56542D49",x"E470A8947",x"B45A3DCB1",x"22314C05E",x"E0C3547A3",x"FE3A881F9",x"D85C8DB92",
x"AC47F2171",x"200108141",x"9F78DAC07",x"721BAE2BB",x"1CDF3ACD6",x"E704462FE",x"A44D4703E",x"7A53806C7",
x"E49CFAA43",x"778499738",x"F5FE5B73B",x"8ABB0854C",x"F714DD91B",x"7F07D2190",x"2615236EC",x"8FA632B6B",
x"28934679A",x"41A3AA109",x"1AF9C5527",x"E1D2B3B0B",x"EE3DC5617",x"C0902138D",x"0BAEF7323",x"3D3CA2721",
x"C1D73AB53",x"31B9F5F6A",x"A6353BCDC",x"53D07B62E",x"210539CA0",x"93C7DDBE5",x"6F6FBD2F9",x"D4A43BEBF",
x"79D84D267",x"9943DEB26",x"4FC0156E4",x"D3BCCC1A9",x"094563D1E",x"771DA9D3F",x"324F124A5",x"A2F72AF97",
x"B363E7710",x"917504B98",x"CE59A5EC6",x"F88C14D6D",x"4BD7102EE",x"117DE5C5E",x"7DC4C9817",x"FE7F431B7",
x"C40AB55E8",x"65CCB3352",x"64617EAD9",x"9D86D0A24",x"47FBFF2B9",x"39F677429",x"C8DC05E16",x"374931C2E",
x"A06531894",x"63A50F76E",x"65C3CE8AF",x"1AE8699B9",x"5EE08106C",x"026875650",x"202DA9B91",x"BDA753579",
x"F3CDAE339",x"F7C899FF2",x"B046D5DCB",x"01BDCCB0F",x"158AEF18D",x"375501FF5",x"4F0EB8588",x"D90E5F0EE",
x"27A3D60FC",x"692A7D744",x"2B7401C1A",x"D99B12C0C",x"B08A4C5A9",x"9E26144E8",x"F4E3B66B8",x"13A5F19EC",
x"171481811",x"B87609726",x"9E3556641",x"4C2801C8F",x"D3AF6A465",x"1CABF0BD1",x"A8920E0FB",x"59921E9A3",
x"A73E4826C",x"C8D7F5021",x"E5E3CF93B",x"631E18139",x"6DED2AC29",x"00C6C955B",x"33A507398",x"06213AA8C",
x"7E3FECB23",x"E350952F1",x"B38649DC1",x"FA4860CBC",x"0B0E14088",x"17E9BF1A8",x"33879F17F",x"001F7A35C",
x"DC0734361",x"2C4E278D8",x"BF024A269",x"E373DDC58",x"982547EC2",x"A8AD8CEA3",x"884A1A3C6",x"84BBAC3F5",
x"8B0BD1FEE",x"B1577F7F3",x"482226480",x"934E25E60",x"073F44DE9",x"411767E0E",x"1C8803DEF",x"1F9AE825A",
x"71CDBD197",x"99542629C",x"DC22ACCFE",x"372E69BC1",x"6A7B6F24C",x"09AC99BEF",x"BB29FEAE4",x"0F810C176",
x"B5895E3CA",x"14291B598",x"342770EAD",x"0883C48D0",x"13F3B928C",x"9939DC0D8",x"24031989A",x"DEC10817B",
x"099099D20",x"7BEB2BC28",x"4A9BA5729",x"33A4B497D",x"7AB5D20A7",x"2169E4157",x"1C00EE29C",x"D8A0C6780",
x"9E206149B",x"3226AAB1E",x"BDBE96EB5",x"96B871D0E",x"C5D5FF558",x"C99DEAA58",x"041107645",x"F34516FF1",
x"12174ED5C",x"DA6580767",x"894F64C40",x"49C44E9ED",x"CD9C3C4E9",x"5A09BCC0A",x"09C239868",x"58BBB6462",
x"A344B81F5",x"163397F65",x"5A0029325",x"592E17222",x"1221ED377",x"455CD7566",x"3EEF28331",x"96E9E349C",
x"59212C54A",x"6D0951FE4",x"7E333A22A",x"0186B40CB",x"FD4E1C62F",x"A4E7D0EF7",x"D3470EDF5",x"C9A8DC79F"
    );


    
    signal adder_memory : adder_memory_t := (others => (others => '0'));
    
    signal result_cal_memory : result_cal_memory_t;
    
    signal pro_addr : unsigned(4 downto 0) := (others => '0');
    signal sum_addr : unsigned(4 downto 0) := (others => '0');
    signal data_in_FFT : std_logic_vector(35 downto 0);
    signal valid_flag : std_logic := '0';
    
    signal valid_in_FFT_m : std_logic;
    
    signal valid_out_FFT : std_logic;
    signal data_address : std_logic_vector(5 downto 0);
    signal data_out_FFT : std_logic_vector(35 downto 0);
    signal result_FFT_memory : std_logic_vector (35 downto 0);
    
    signal FFT_data_last : std_logic;
    signal temp_address : std_logic_vector(5 downto 0);
    signal temp_last : std_logic;
    signal max_data : std_logic_vector (35 downto 0) := (others => '0');
    signal max_address : std_logic_vector(5 downto 0) := (others => '0');
    signal max_flag : std_logic;
    signal max_last : std_logic;
    signal temp : std_logic;
    
    signal test_re1 : std_logic_vector(17 downto 0);
    signal test_im1 : std_logic_vector(17 downto 0);
    signal test_re2 : std_logic_vector(17 downto 0);
    signal test_im2 : std_logic_vector(17 downto 0);
    signal test_FFT_re : std_logic_vector(17 downto 0);
    signal test_FFT_im : std_logic_vector(17 downto 0);
    signal test_FFTo_re : std_logic_vector(17 downto 0);
    signal test_FFTo_im : std_logic_vector(17 downto 0);
    signal test_result_re : std_logic_vector(17 downto 0);
    signal test_result_im : std_logic_vector(17 downto 0);
begin

    test_re1 <= R_memory(0)(35 downto 18);
    test_im1 <= S_memory(0)(17 downto 0);
    test_re2 <= R_memory(1)(35 downto 18);
    test_im2 <= S_memory(1)(17 downto 0);
    process (clk)
    begin
        if rising_edge(clk) then
            if (rst='1') then
                valid_flag <= '0';
            else
                if valid_in = '1' then
                    R_memory(0) <= data_in ;
                    for i in 0 to 254 loop
                       R_memory(i+1) <= R_memory(i);
                    end loop;
                    valid_flag <= '1';
                else
                    valid_flag <= '0';
                end if;
                
           end if;
        end if;
    end process;
    
    process (clk)
        variable addr : std_logic_vector(7 downto 0);
        variable pro_tmp_re_re : std_logic_vector(35 downto 0);
        variable pro_tmp_re_im : std_logic_vector(35 downto 0);
        variable pro_tmp_im_im : std_logic_vector(35 downto 0);
        variable pro_tmp_im_re : std_logic_vector(35 downto 0);
        variable loop_addr_re : std_logic_vector(2 downto 0);
        variable loop_addr_im : std_logic_vector(2 downto 0);
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                pro_addr <= (others => '0');
            else
                if valid_flag = '1' or pro_addr > 0 then
                    for j in 0 to 3 loop
                        addr := std_logic_vector(pro_addr) &
                                std_logic_vector(to_unsigned(j, 3));
                                
                        
                        
                        pro_tmp_re_re := std_logic_vector(
                                           signed(R_memory(to_integer(unsigned(addr)))(35 downto 18)) * 
                                           signed(S_memory(to_integer(unsigned(addr)))(35 downto 18))  );
                                           
                        pro_tmp_re_im := std_logic_vector(
                                           signed(R_memory(to_integer(unsigned(addr)))(35 downto 18)) * 
                                           signed(S_memory(to_integer(unsigned(addr)))(17 downto 0 ))  );
                        
                        pro_tmp_im_im := std_logic_vector(
                                           signed(R_memory(to_integer(unsigned(addr)))(17 downto 0)) * 
                                           signed(S_memory(to_integer(unsigned(addr)))(17 downto 0))  );     
                         
                        pro_tmp_im_re := std_logic_vector(
                                           signed(R_memory(to_integer(unsigned(addr)))(17 downto 0)) * 
                                           signed(S_memory(to_integer(unsigned(addr)))(35 downto 18))  );
                        
                        loop_addr_re := '0' & std_logic_vector(to_unsigned(j,2));
                        loop_addr_im := '1' & std_logic_vector(to_unsigned(j,2));
        
                        adder_memory(to_integer(unsigned(loop_addr_re))) <= std_logic_vector(unsigned(pro_tmp_re_re (35 downto 18)) -
                                                                                             unsigned(pro_tmp_im_im (35 downto 18)));
                                                              
                        adder_memory(to_integer(unsigned(loop_addr_im))) <= std_logic_vector(unsigned(pro_tmp_re_im (35 downto 18)) +
                                                                                             unsigned(pro_tmp_im_re (35 downto 18)));
              
                    end loop;
                    
                    pro_addr <= pro_addr + 1;
                end if;
            end if;
        end if;
    end process;

        
  
    process (clk)
        variable sum_tmp_re : signed(17 downto 0);
        variable sum_tmp_im : signed(17 downto 0);
    begin
        if(rising_edge(clk)) then
            if (rst='1') then
                result_cal_memory <= (others => (others => '0'));
                valid_in_FFT_m <= '0';
                sum_addr <= (others => '0');
            else
                if pro_addr > 0 or sum_addr > 0 then
                    sum_tmp_re := signed(adder_memory(0)(17) & adder_memory(0)(17 downto 1)) + signed(adder_memory(1)(17) & adder_memory(1)(17 downto 1)) +
                                  signed(adder_memory(2)(17) & adder_memory(2)(17 downto 1)) + signed(adder_memory(3)(17) & adder_memory(3)(17 downto 1));
                    
                    sum_tmp_im := signed(adder_memory(4)(17) & adder_memory(4)(17 downto 1)) + signed(adder_memory(5)(17) & adder_memory(5)(17 downto 1)) +
                                  signed(adder_memory(6)(17) & adder_memory(6)(17 downto 1)) + signed(adder_memory(7)(17) & adder_memory(7)(17 downto 1));
                    
                    
                    result_cal_memory(to_integer(sum_addr)) <= sum_tmp_re(17) & std_logic_vector(sum_tmp_re(17 downto 1)) &
                                                               sum_tmp_im(17) & std_logic_vector(sum_tmp_im(17 downto 1));
                                                               
                    test_result_re <= sum_tmp_re(17) & std_logic_vector(sum_tmp_re(17 downto 1));
                    test_result_im <= sum_tmp_im(17) & std_logic_vector(sum_tmp_im(17 downto 1));
                    sum_addr <= sum_addr + 1;
                    valid_in_FFT_m <= '1';
                elsif pro_addr = 0 then
                    valid_in_FFT_m <= '0';
                end if;
            end if;
        end if;
    end process;
    
    data_in_FFT <= result_cal_memory(to_integer(sum_addr-1));
    
    test_FFT_re <= result_cal_memory(1)(35 downto 18);
    test_FFT_im <= result_cal_memory(1)(17 downto 0);
    
    dut : FFT_IP_core_handler
    port map (clk               => clk,
              rst               => rst,
              valid_in_FFT      => valid_in_FFT_m,
              data_in_FFT       => data_in_FFT,
              valid_out_FFT     => valid_out_FFT,
              data_address      => data_address,
              FFT_data_last     => FFT_data_last,
              data_out_FFT      => data_out_FFT);
    
    test_FFTo_re <= data_out_FFT(35 downto 18);
    test_FFTo_im <= data_out_FFT(17 downto 0);
    
    process (clk)
    variable pro_tmp_re_re : std_logic_vector(35 downto 0);
    variable pro_tmp_im_im : std_logic_vector(35 downto 0);
    begin
        if rising_edge(clk) then
            if rst = '1' then
                max_flag <= '0';
                max_last <= '0';
            else
                max_last <= FFT_data_last;
                if valid_out_FFT = '1' then
                    max_flag <= '1';
                    temp_address <= data_address;
                    pro_tmp_re_re := std_logic_vector(
                                       signed(data_out_FFT(35 downto 18)) * 
                                       signed(data_out_FFT(35 downto 18)) );
                    
                    pro_tmp_im_im := std_logic_vector(
                                       signed(data_out_FFT(17 downto 0)) * 
                                       signed(data_out_FFT(17 downto 0))  );     
                    
                    result_FFT_memory <= std_logic_vector(unsigned(pro_tmp_re_re) +
                                                          unsigned(pro_tmp_im_im));
                else
                    max_flag <= '0';
                end if;
            end if;
        end if;
    end process;
    
    
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                max_data <= (others => '0');
                max_address <= (others => '0');
                temp <= '0';
            else
                if temp = '1' then
                    data_out <= (others => '0');
                    max_data <= (others => '0');
                    max_address <= (others => '0');
                end if;
                temp <= max_last;
                valid_out <= temp;
                if max_address = "00000" or max_address = "11111" then
                    data_out <= (others => '0');
                else
                    data_out <= not(max_address(5)) & max_address(4 downto 0);
                end if;
                if max_flag = '1' then
                    if result_FFT_memory >= max_data then
                        max_data <= result_FFT_memory;
                        max_address <= temp_address(5 downto 0);
                    end if;
                end if;
            end if;
        end if;
    
    end process;
    
    
    

end Behavioral;













