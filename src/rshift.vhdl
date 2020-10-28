library ieee;
use ieee.std_logic_1164.all;

entity rshift is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end rshift;

architecture behavior of rshift is
    signal buf1, buf2, buf3 : std_logic_vector(7 downto 0) := "00000000";
begin
    -- Layer 1
    process (A, B)
    begin
        case B(0) is
            when '0' => buf1 <= A;
            
            when '1' =>
                buf1(0) <= A(1);
                buf1(1) <= A(2);
                buf1(2) <= A(3);
                buf1(3) <= A(4);
                buf1(4) <= A(5);
                buf1(5) <= A(6);
                buf1(6) <= A(7);
                buf1(7) <= '0';
            
            when others => buf1 <= "XXXXXXXX";
        end case;
    end process;
    
    -- Layer 2
    -- Shift right by 2^1 = 2 or 11
    process (A, B, buf1)
    begin
        case B(1) is
            when '0' => buf2 <= buf1;
            
            when '1' =>
                buf2(0) <= buf1(2);
                buf2(1) <= buf1(3);
                buf2(2) <= buf1(4);
                buf2(3) <= buf1(5);
                buf2(4) <= buf1(6);
                buf2(5) <= buf1(7);
                buf2(6) <= '0';
                buf2(7) <= '0';
            
            when others => buf2 <= "XXXXXXXX";
        end case;
    end process;
    
    -- Layer 3
    -- Shift right by 2^2 = 4 or 1111
    process (A, B, buf2)
    begin
        case B(2) is
            when '0' => buf3 <= buf2;
            
            when '1' =>
                buf3(0) <= buf2(4);
                buf3(1) <= buf2(5);
                buf3(2) <= buf2(6);
                buf3(3) <= buf2(7);
                buf3(4) <= '0';
                buf3(5) <= '0';
                buf3(6) <= '0';
                buf3(7) <= '0';
            
            when others => buf3 <= "XXXXXXXX";
        end case;
    end process;
    
    F <= buf3;
end behavior;

