-- 8-bit XOR unit
library ieee;
use ieee.std_logic_1164.all;

entity XOR8 is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end XOR8;

architecture behavior of XOR8 is
    signal out_xor : std_logic_vector(7 downto 0);
begin
    out_xor(0) <= A(0) xor B(0);
    out_xor(1) <= A(1) xor B(1);
    out_xor(2) <= A(2) xor B(2);
    out_xor(3) <= A(3) xor B(3);
    out_xor(4) <= A(4) xor B(4);
    out_xor(5) <= A(5) xor B(5);
    out_xor(6) <= A(6) xor B(6);
    out_xor(7) <= A(7) xor B(7);
    
    F <= out_xor;
end behavior;

