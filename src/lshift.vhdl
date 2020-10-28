library ieee;
use ieee.std_logic_1164.all;

entity lshift is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end lshift;

architecture behavior of lshift is
    signal buf1, buf2, buf3 : std_logic_vector(7 downto 0) := "00000000";
begin
    process(A, B)
    begin
        -- Layer 1
        case B(0) is
            when '0' => buf1 <= A;
            
            when '1' =>
                buf1(0) <= '0';
                buf1(1) <= A(0);
                buf1(2) <= A(1);
                buf1(3) <= A(2);
                buf1(4) <= A(3);
                buf1(5) <= A(4);
                buf1(6) <= A(5);
                buf1(7) <= A(6);
            
            when others => buf1 <= "XXXXXXXX";
        end case;
    end process;
    
    process(A, B, buf1)
    begin
        -- Layer 2
        case B(1) is
            when '0' => buf2 <= buf1;
            
            when '1' =>
                buf2(0) <= '0';
                buf2(1) <= '0';
                buf2(2) <= buf1(0);
                buf2(3) <= buf1(1);
                buf2(4) <= buf1(2);
                buf2(5) <= buf1(3);
                buf2(6) <= buf1(4);
                buf2(7) <= buf1(5);
            
            when others => buf2 <= "XXXXXXXX";
        end case;
    end process;
    
    process(A, B, buf2)
    begin
        -- Layer 3
        case B(2) is
            when '0' => buf3 <= buf2;
            
            when '1' => 
                buf3(0) <= '0';
                buf3(1) <= '0';
                buf3(2) <= '0';
                buf3(3) <= '0';
                buf3(4) <= buf2(0);
                buf3(5) <= buf2(1);
                buf3(6) <= buf2(2);
                buf3(7) <= buf2(3);
            
            when others => buf3 <= "XXXXXXXX";
        end case;
    end process;
    
    F <= buf3;
end behavior;

