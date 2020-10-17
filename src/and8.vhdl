-- 8-bit AND

library ieee;
use ieee.std_logic_1164.all;

entity AND8 is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end AND8;

architecture behavior of AND8 is
    signal out_bus : std_logic_vector(7 downto 0);
begin
    out_bus(0) <= A(0) and B(0);
    out_bus(1) <= A(1) and B(1);
    out_bus(2) <= A(2) and B(2);
    out_bus(3) <= A(3) and B(3);
    out_bus(4) <= A(4) and B(4);
    out_bus(5) <= A(5) and B(5);
    out_bus(6) <= A(6) and B(6);
    out_bus(7) <= A(7) and B(7);
    
    F <= out_bus;
end behavior;

