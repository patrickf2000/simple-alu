-- 8-bit subtractor
--
-- A subtractor is actually a pretty simple circuit. All we need
-- is an adder and a negater; we negate the second number, and
-- add it to the first
library ieee;
use ieee.std_logic_1164.all;

entity Subtractor is
    port (
        A, B : in std_logic_vector(7 downto 0);
        F : out std_logic_vector(7 downto 0)
    );
end Subtractor;

architecture behavior of Subtractor is
    -- The negate component
    component negate
        port (
            A : in std_logic_vector(7 downto 0);
            F : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- The adder
    component adder
        port (
            vec1, vec2 : in std_logic_vector(7 downto 0);
            out_vec : out std_logic_vector(7 downto 0);
            co : out std_logic
        );
    end component;
    
    -- The signals
    signal out_negate : std_logic_vector(7 downto 0);
    signal out_add : std_logic_vector(7 downto 0);
begin
    neg : negate port map(A => B, F => out_negate);
    add : adder port map(vec1 => A, vec2 => out_negate, out_vec => out_add, co => open);
    F <= out_add;
end behavior;

