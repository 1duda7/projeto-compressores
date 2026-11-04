library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tree_63_behavioral is
   generic(
        N : integer := 16
    );
 port (
     X0 : in  std_logic_vector(N-1 downto 0);
     X1 : in  std_logic_vector(N-1 downto 0);
     X2 : in  std_logic_vector(N-1 downto 0);
     X3 : in  std_logic_vector(N-1 downto 0);
     X4 : in  std_logic_vector(N-1 downto 0);
     X5 : in  std_logic_vector(N-1 downto 0);
     X6 : in  std_logic_vector(N-1 downto 0);
     X7 : in  std_logic_vector(N-1 downto 0);
     X8 : in  std_logic_vector(N-1 downto 0);
     X9 : in  std_logic_vector(N-1 downto 0);
     X10: in  std_logic_vector(N-1 downto 0);
     X11: in  std_logic_vector(N-1 downto 0);
     X12: in  std_logic_vector(N-1 downto 0);
     X13: in  std_logic_vector(N-1 downto 0);
     X14: in  std_logic_vector(N-1 downto 0);
     Y0 : out std_logic_vector(N-1 downto 0);
     Y1 : out std_logic_vector(N-1 downto 0)
 );
end tree_63_behavioral;

architecture structural of tree_63_behavioral is

    signal a0, a1, a2, a3, a4, a5 :
        std_logic_vector(N-1 downto 0);

    signal b0, b1, b2 :
        std_logic_vector(N-1 downto 0);

    signal c0, c1, c2 :
        std_logic_vector(N-1 downto 0);

begin

    ------------------------------------------------------------------
    -- CAMADA 1 : dois compressores 6:3 em paralelo
    -- 12 operandos -> 6 linhas, restando X12, X13, X14
    ------------------------------------------------------------------
    c1b1 : entity work.c63_behavioral
        generic map (N => N)
        port map(
            X0 => X0, X1 => X1, X2 => X2,
            X3 => X3, X4 => X4, X5 => X5,
            Y0 => a0, Y1 => a1, Y2 => a2
        );

    c1b2 : entity work.c63_behavioral
        generic map (N => N)
        port map(
            X0 => X6, X1 => X7, X2 => X8,
            X3 => X9, X4 => X10, X5 => X11,
            Y0 => a3, Y1 => a4, Y2 => a5
        );

    ------------------------------------------------------------------
    -- CAMADA 2 : 6 -> 3
    ------------------------------------------------------------------
    c2b1 : entity work.c63_behavioral
        generic map (N => N)
        port map(
            X0 => a0, X1 => a1, X2 => a2,
            X3 => a3, X4 => a4, X5 => a5,
            Y0 => b0, Y1 => b1, Y2 => b2
        );

    ------------------------------------------------------------------
    -- CAMADA 3 : (3 linhas + X12 + X13 + X14) -> 3
    ------------------------------------------------------------------
    c3b1 : entity work.c63_behavioral
        generic map (N => N)
        port map(
            X0 => b0, X1 => b1, X2 => b2,
            X3 => X12, X4 => X13, X5 => X14,
            Y0 => c0, Y1 => c1, Y2 => c2
        );

    ------------------------------------------------------------------
    -- CAMADA 4 : 3 -> 2
    ------------------------------------------------------------------
    c4fa : entity work.c32_behavioral
        generic map (N => N)
        port map(
            X0 => c0, X1 => c1, X2 => c2,
            Y0 => Y0, Y1 => Y1
        );

end structural;
