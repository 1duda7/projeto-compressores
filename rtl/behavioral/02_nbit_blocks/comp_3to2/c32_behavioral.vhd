library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity c32_behavioral is
   generic (
        N : integer := 16
   );
   Port (
       X0 : in  std_logic_vector(N-1 downto 0);
       X1 : in  std_logic_vector(N-1 downto 0);
       X2 : in  std_logic_vector(N-1 downto 0);
       Y0 : out std_logic_vector(N-1 downto 0);
       Y1 : out std_logic_vector(N-1 downto 0) -- peso 2^1 (shift << 1)
   );
end c32_behavioral;

architecture Behavioral of c32_behavioral is

    -- Carry gerado independentemente em cada coluna
    signal W : std_logic_vector(N-1 downto 0);

begin

    ------------------------------------------------------------------
    -- N Full Adders comportamentais trabalhando em paralelo
    --
    -- Para cada bit i:
    -- X0(i) + X1(i) + X2(i) -> Y0(i) + 2*W(i)
    ------------------------------------------------------------------
    GEN_FA : for i in 0 to N-1 generate

        FA_I : entity work.c32_behavioral_1bit
            port map (
                X0 => X0(i),
                X1 => X1(i),
                CI => X2(i),
                Y0 => Y0(i),
                CO => W(i)
            );

    end generate GEN_FA;

    ------------------------------------------------------------------
    -- Os carries possuem peso 2 vezes maior.
    -- Portanto, a linha Y1 é W deslocado uma posição à esquerda.
    ------------------------------------------------------------------
    Y1 <= W(N-2 downto 0) & '0';

end Behavioral;
