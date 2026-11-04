library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c32_behavioral_1bit is
 Port ( 
     X0 : in  STD_LOGIC;
     X1 : in  STD_LOGIC;
     CI : in  STD_LOGIC;
     Y0 : out STD_LOGIC;
     CO : out STD_LOGIC
 );
end c32_behavioral_1bit; 

architecture Behavioral of c32_behavioral_1bit is
    signal s_in  : std_logic_vector(2 downto 0);
    signal s_out : std_logic_vector(1 downto 0);
begin
    -- Agrupa concorrentemente os 3 bits individuais de entrada
    s_in <= X0 & X1 & CI;

    -- Tabela verdade expandida termo a termo para manter a padronizacao
    with s_in select
        s_out <=
            "00" when "000",
            "01" when "001",
            "01" when "010",
            "10" when "011",
            "01" when "100",
            "10" when "101",
            "10" when "110",
            "11" when others; -- Representa o caso "111"

    -- Distribui os resultados para os pinos de saida
    Y0 <= s_out(0);
    CO <= s_out(1);
end Behavioral;
