-- 8-bit NOT
library ieee;
use ieee.std_logic_1164.all;

entity NOT8 is
    port (
        A : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end NOT8;

architecture behavior of NOT8 is
    signal out_not : std_logic_vector(7 downto 0);
begin
    out_not(0) <= not A(0);
    out_not(1) <= not A(1);
    out_not(2) <= not A(2);
    out_not(3) <= not A(3);
    out_not(4) <= not A(4);
    out_not(5) <= not A(5);
    out_not(6) <= not A(6);
    out_not(7) <= not A(7);
    
    F <= out_not;
end behavior;

