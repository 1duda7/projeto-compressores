library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Arvore de compressao de 15 vetores para 1 vetor (versao Behavioral).
-- A rede interna realiza 15:2 usando compressores c63_behavioral e c32_behavioral,
-- e a ultima etapa 2:1 e feita com o operador nativo "+".
--
-- Resultado em largura fixa:
-- Y0 = X0 + X1 + ... + X14  (mod 2^N)

entity tree_63_behavioral_15to1 is
    generic(
        N : integer := 16
    );
    port (
        X0  : in  std_logic_vector(N-1 downto 0);
        X1  : in  std_logic_vector(N-1 downto 0);
        X2  : in  std_logic_vector(N-1 downto 0);
        X3  : in  std_logic_vector(N-1 downto 0);
        X4  : in  std_logic_vector(N-1 downto 0);
        X5  : in  std_logic_vector(N-1 downto 0);
        X6  : in  std_logic_vector(N-1 downto 0);
        X7  : in  std_logic_vector(N-1 downto 0);
        X8  : in  std_logic_vector(N-1 downto 0);
        X9  : in  std_logic_vector(N-1 downto 0);
        X10 : in  std_logic_vector(N-1 downto 0);
        X11 : in  std_logic_vector(N-1 downto 0);
        X12 : in  std_logic_vector(N-1 downto 0);
        X13 : in  std_logic_vector(N-1 downto 0);
        X14 : in  std_logic_vector(N-1 downto 0);

        Y0  : out std_logic_vector(N-1 downto 0)
    );
end tree_63_behavioral_15to1;

architecture structural of tree_63_behavioral_15to1 is
	attribute multstyle : string;
	attribute multstyle of structural : architecture is "logic";

    -- Duas linhas resultantes da arvore de reducao 15:2
    signal C0 : std_logic_vector(N-1 downto 0);
    signal C1 : std_logic_vector(N-1 downto 0);

    -- Soma final 2:1 com propagacao de carry completa
    signal SUM_FINAL : signed(N-1 downto 0);

begin

    ------------------------------------------------------------------
    -- COMPRESSAO 15 : 2 (BEHAVIORAL)
    ------------------------------------------------------------------
    TREE_15_TO_2 : entity work.tree_63_behavioral
        generic map (
            N => N
        )
        port map (
            X0  => X0,  X1  => X1,  X2  => X2,
            X3  => X3,  X4  => X4,  X5  => X5,
            X6  => X6,  X7  => X7,  X8  => X8,
            X9  => X9,  X10 => X10, X11 => X11,
            X12 => X12, X13 => X13, X14 => X14,
            Y0  => C0,
            Y1  => C1
        );

    ------------------------------------------------------------------
    -- SOMA FINAL 2 : 1
    -- Operador nativo "+"
    ------------------------------------------------------------------
    SUM_FINAL <= signed(C0) + signed(C1);

    Y0 <= std_logic_vector(SUM_FINAL);

end structural;