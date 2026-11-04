library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c63_behavioral_1bit is
 Port ( 
     X0 : in  STD_LOGIC;
     X1 : in  STD_LOGIC;
     X2 : in  STD_LOGIC;
     X3 : in  STD_LOGIC;
     X4 : in  STD_LOGIC;
     X5 : in  STD_LOGIC;
     Y0 : out STD_LOGIC;
     Y1 : out STD_LOGIC;
     Y2 : out STD_LOGIC
 );
end c63_behavioral_1bit;

architecture Behavioral of c63_behavioral_1bit is
    signal s_in  : std_logic_vector(5 downto 0);
    signal s_out : std_logic_vector(2 downto 0);
begin
    s_in <= X5 & X4 & X3 & X2 & X1 & X0;

    with s_in select
        s_out <=
            "000" when "000000", "001" when "000001", "001" when "000010", "010" when "000011",
            "001" when "000100", "010" when "000101", "010" when "000110", "011" when "000111",
            "001" when "001000", "010" when "001001", "010" when "001010", "011" when "001011",
            "010" when "001100", "011" when "001101", "011" when "001110", "100" when "001111",
            "001" when "010000", "010" when "010001", "010" when "010010", "011" when "010011",
            "010" when "010100", "011" when "010101", "011" when "010110", "100" when "010111",
            "010" when "011000", "011" when "011001", "011" when "011010", "100" when "011011",
            "011" when "011100", "100" when "011101", "100" when "011110", "101" when "011111",
            "001" when "100000", "010" when "100001", "010" when "100010", "011" when "100011",
            "010" when "100100", "011" when "100101", "011" when "100110", "100" when "100111",
            "010" when "101000", "011" when "101001", "011" when "101010", "100" when "101011",
            "011" when "101100", "100" when "101101", "100" when "101111", "101" when "101110",
            "010" when "110000", "011" when "110001", "011" when "110010", "100" when "110011",
            "011" when "110100", "100" when "110101", "100" when "110110", "101" when "110111",
            "011" when "111000", "100" when "111001", "100" when "111010", "101" when "111011",
            "100" when "111100", "101" when "111101", "101" when "111110", "110" when others;

    Y0 <= s_out(0);
    Y1 <= s_out(1);
    Y2 <= s_out(2);
end Behavioral;
