library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Compressor 6:3 generico em N bits construído a partir
-- de N compressores comportamentais 6:3 de 1 bit.
--
-- Para cada coluna i:
--   X0(i)+...+X5(i) = S0(i) + 2*S1(i) + 4*S2(i)
--
-- As saidas vetoriais sao alinhadas por peso:
--   Y0 = S0
--   Y1 = S1 << 1
--   Y2 = S2 << 2
--
-- Portanto, em aritmetica de largura fixa:
--   X0+...+X5 = Y0 + Y1 + Y2  (mod 2^N)

entity c63_behavioral is
   generic (
        N : positive := 16
   );
   Port (
       X0 : in  std_logic_vector(N-1 downto 0);
       X1 : in  std_logic_vector(N-1 downto 0);
       X2 : in  std_logic_vector(N-1 downto 0);
       X3 : in  std_logic_vector(N-1 downto 0);
       X4 : in  std_logic_vector(N-1 downto 0);
       X5 : in  std_logic_vector(N-1 downto 0);

       Y0 : out std_logic_vector(N-1 downto 0);
       Y1 : out std_logic_vector(N-1 downto 0);
       Y2 : out std_logic_vector(N-1 downto 0)
   );
end c63_behavioral;

architecture Structural of c63_behavioral is

    signal S0 : std_logic_vector(N-1 downto 0);
    signal S1 : std_logic_vector(N-1 downto 0);
    signal S2 : std_logic_vector(N-1 downto 0);

begin

    ------------------------------------------------------------------
    -- N compressores 6:3 de 1 bit em paralelo
    ------------------------------------------------------------------
    GEN_C63 : for i in 0 to N-1 generate

        C63_I : entity work.c63_behavioral_1bit
            port map (
                X0 => X0(i),
                X1 => X1(i),
                X2 => X2(i),
                X3 => X3(i),
                X4 => X4(i),
                X5 => X5(i),
                Y0 => S0(i),
                Y1 => S1(i),
                Y2 => S2(i)
            );

    end generate GEN_C63;

    ------------------------------------------------------------------
    -- Linha de peso 1
    ------------------------------------------------------------------
    Y0 <= S0;

    ------------------------------------------------------------------
    -- Linha de peso 2: S1 << 1
    -- Forma por generate para funcionar também com N=1.
    ------------------------------------------------------------------
    Y1(0) <= '0';

    GEN_Y1 : if N > 1 generate
        GEN_Y1_BITS : for i in 1 to N-1 generate
            Y1(i) <= S1(i-1);
        end generate GEN_Y1_BITS;
    end generate GEN_Y1;

    ------------------------------------------------------------------
    -- Linha de peso 4: S2 << 2
    -- Forma por generate para funcionar com N=1, N=2 e N>=3.
    ------------------------------------------------------------------
    Y2(0) <= '0';

    GEN_Y2_BIT1 : if N > 1 generate
        Y2(1) <= '0';
    end generate GEN_Y2_BIT1;

    GEN_Y2 : if N > 2 generate
        GEN_Y2_BITS : for i in 2 to N-1 generate
            Y2(i) <= S2(i-2);
        end generate GEN_Y2_BITS;
    end generate GEN_Y2;

end Structural;
