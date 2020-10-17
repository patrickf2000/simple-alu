-- 8-bit OR
library ieee;
use ieee.std_logic_1164.all;

entity OR8 is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end OR8;

architecture behavior of OR8 is
    signal or_out : std_logic_vector(7 downto 0);
begin
    or_out(0) <= A(0) or B(0);
    or_out(1) <= A(1) or B(1);
    or_out(2) <= A(2) or B(2);
    or_out(3) <= A(3) or B(3);
    or_out(4) <= A(4) or B(4);
    or_out(5) <= A(5) or B(5);
    or_out(6) <= A(6) or B(6);
    or_out(7) <= A(7) or B(7);
    
    F <= or_out;
end behavior;
